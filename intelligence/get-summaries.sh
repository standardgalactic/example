#!/usr/bin/env bash
set -Eeuo pipefail

###############################################################################
#  Usage:
#    1) Make it executable:  chmod +x summarize.sh
#    2) Run in the directory that has .vtt (and/or .txt) files:
#         ./summarize.sh
#
#  Description:
#    - Processes .vtt files by removing timestamps (and other typical cues).
#    - Processes .txt files "as is."
#    - Splits each file into chunks, calls Ollama to summarize each chunk.
#    - Logs progress to progress.log and outputs all summaries to
#      detailed-summary.txt.
###############################################################################

############################
# Configuration Variables  #
############################

# Number of lines per chunk.
CHUNK_LINES=200

# The command/model used for summarization. Adjust as needed.
# Example:
#  MODEL_COMMAND=("ollama" "run" "vanilj/phi-4")
MODEL_COMMAND=("ollama" "run" "vanilj/phi-4")

# Log/summary filenames
PROGRESS_FILE="progress.log"
SUMMARY_FILE="detailed-summary.txt"

#######################
#  Preparatory Checks #
#######################

if ! command -v "${MODEL_COMMAND[0]}" >/dev/null 2>&1; then
  echo "Error: '${MODEL_COMMAND[0]}' is not installed or not in PATH."
  exit 1
fi

#########################
#  Script Initialization#
#########################

main_dir="$(pwd)"  # The directory where this script is being run

# Create the progress and summary files if they don't exist
touch "$main_dir/$PROGRESS_FILE"
touch "$main_dir/$SUMMARY_FILE"

# Helper function to log with timestamps
log() {
  local message="[${USER:-$(whoami)}@$(hostname)] [$(date '+%Y-%m-%d %H:%M:%S')] $*"
  echo "$message"
  echo "$message" >> "$main_dir/$PROGRESS_FILE"
}

log "Script started."
log "Summaries will be appended to $SUMMARY_FILE"

#########################
#   Utility Functions   #
#########################

# Return 0 (true) if $1 is in $PROGRESS_FILE
is_processed() {
  local file_path="$1"
  grep -Fxq "$file_path" "$main_dir/$PROGRESS_FILE"
}

# Mark file as processed
mark_processed() {
  local file_path="$1"
  echo "$file_path" >> "$main_dir/$PROGRESS_FILE"
}

# Temporary dir cleanup
cleanup_tempdirs() {
  if [[ -n "${TEMP_DIRS_CREATED:-}" ]]; then
    for tmpd in $TEMP_DIRS_CREATED; do
      if [[ -d "$tmpd" ]]; then
        rm -rf "$tmpd"
        log "Cleaned up temporary directory: $tmpd"
      fi
    done
  fi
}
trap cleanup_tempdirs EXIT

############################
#  Preprocessing Function  #
############################

# Removes typical VTT metadata:
#   - Lines containing '-->' (timestamps/cues)
#   - Lines that start with 'WEBVTT'
#   - Lines that are purely numeric (cue indexes)
#   - Everything else is left untouched
preprocess_vtt() {
  local file="$1"

  # Remove lines with '-->', lines beginning with 'WEBVTT', or purely numeric
  grep -v -- '-->' "$file" \
    | grep -v '^WEBVTT' \
    | grep -vE '^[0-9]+$'
}

############################
#  Processing  Function    #
############################

process_files_in_directory() {
  local dir="$1"
  log "Processing directory: $dir"

  # Collect .vtt and .txt (change as needed)
  shopt -s nullglob
  local vtt_files=("$dir"/*.vtt)
  local txt_files=("$dir"/*.txt)
  shopt -u nullglob

  # Combine them if we want to handle both
  local all_files=("${vtt_files[@]}" "${txt_files[@]}")

  # Skip if none found
  if [[ ${#all_files[@]} -eq 0 ]]; then
    log "No .vtt or .txt files found in $dir"
    return
  fi

  for file in "${all_files[@]}"; do
    # Skip symlinks and re-processed files
    if [[ -f "$file" && ! -L "$file" ]]; then
      if ! is_processed "$file"; then
        local file_name
        file_name="$(basename "$file")"

        log "Processing file: $file"

        # Create a temporary directory
        local sanitized_name
        sanitized_name="$(echo "$file_name" | tr -d '[:space:]')"
        local temp_dir
        temp_dir="$(mktemp -d "$dir/tmp_${sanitized_name}_XXXXXX")"
        TEMP_DIRS_CREATED="${TEMP_DIRS_CREATED:-} $temp_dir"
        log "Created temporary directory: $temp_dir"

        # 1) Preprocess if it's VTT. Otherwise copy as-is.
        local preprocessed_file="$temp_dir/preprocessed.txt"
        if [[ "$file" == *.vtt ]]; then
          preprocess_vtt "$file" > "$preprocessed_file"
        else
          cp "$file" "$preprocessed_file"
        fi

        # 2) Split into chunks
        split -l "$CHUNK_LINES" -- "$preprocessed_file" "$temp_dir/chunk_"
        log "Split $file into chunks of $CHUNK_LINES lines each."

        # 3) Summarize each chunk
        for chunk_file in "$temp_dir"/chunk_*; do
          [[ -f "$chunk_file" ]] || continue
          local chunk_name
          chunk_name="$(basename "$chunk_file")"
          log "Summarizing chunk: $chunk_name"

          # The prompt is piped into Ollama
          log "Running command: ${MODEL_COMMAND[*]} (chunk: $chunk_name)"
          {
            echo "Summarize the following transcript from \"$file_name\"."
            echo "Focus on the main ideas, ignoring timestamps or extraneous details."
            echo "---------------"
            cat "$chunk_file"
          } | "${MODEL_COMMAND[@]}" >> "$main_dir/$SUMMARY_FILE" 2>>"$main_dir/$PROGRESS_FILE"

          # Extra new line after each chunk summary
          echo "" >> "$main_dir/$SUMMARY_FILE"
        done

        # 4) Mark file as processed
        mark_processed "$file"
        log "Marked $file as processed."
      else
        log "Skipping file (already processed): $file"
      fi
    fi
  done
}

#######################
#  Recursive (Optional)
#######################

process_subdirectories_recursively() {
  local parent_dir="$1"
  for dir in "$parent_dir"/*/; do
    [[ -d "$dir" ]] || continue
    process_files_in_directory "$dir"
    process_subdirectories_recursively "$dir"
  done
}

###################
#    Main Logic   #
###################

# 1) Process top-level .vtt/.txt files in the current directory
process_files_in_directory "$main_dir"

# 2) Uncomment to recurse subdirectories if needed
# process_subdirectories_recursively "$main_dir"

log "Script completed."
