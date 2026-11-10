#!/usr/bin/env bash
set -euo pipefail

# Run in the directory containing the originals, or pass that directory.
# Outputs go into its corrected/ subdirectory. Requires Bash and sed.
if (( $# > 1 )); then
    printf 'Usage: %s [transcript-directory]\n' "${0##*/}" >&2
    exit 2
fi

source_dir=${1:-.}
stem=The_Thermodynamic_Limits_of_Artificial_Organs

for extension in txt vtt; do
    if [[ ! -f "$source_dir/$stem.$extension" || ! -r "$source_dir/$stem.$extension" ]]; then
        printf 'Cannot read %s\n' "$source_dir/$stem.$extension" >&2
        exit 1
    fi
done

output_dir="$source_dir/corrected"
mkdir -p -- "$output_dir"
stage=$(mktemp -d "$output_dir/.transcripts.XXXXXX")
trap 'rm -rf -- "$stage"' EXIT

# Apply the same narrowly scoped substitutions to both formats.
# Proper names and coined terms follow the textbook spelling.
# Leave ambiguous audio and the hosts' factual claims as transcribed.
for extension in txt vtt; do
    sed '
        /^WEBVTT/b
        / --> /b
        s/name Phlaxion/name Flyxion/g
        s/biology, let us to believe/biology led us to believe/g
        s/limit that Tex mentions/limit the text mentions/g
        s/Krog cylinder/Krogh cylinder/g
        s/Krog model/Krogh model/g
        s/square cube law/square-cube law/g
        s/hepastidium/hepastitium/g
        s/hepastium/hepastitium/g
        s/swarm-bought/swarm-bot/g
        s/how they.re collagen formed/how their collagen formed/g
        s/naval ports/navel ports/g
        s/prolonged fast air/prolonged fasting/g
    ' "$source_dir/$stem.$extension" > "$stage/$stem.$extension"
done

for extension in txt vtt; do
    mv -f -- "$stage/$stem.$extension" "$output_dir/$stem.$extension"
    printf '%s\n' "$output_dir/$stem.$extension"
done
