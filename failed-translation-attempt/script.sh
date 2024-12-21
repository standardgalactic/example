summary_file="translation.txt"
progress_file="progress-file.log"
main_dir=$(pwd)

# Function to check if a file is already processed
is_processed() {
	    grep -Fxq "$1" "$main_dir/$progress_file"
    }

    # Create progress and summary files if they don't exist
    touch "$main_dir/$progress_file"
    touch "$main_dir/$summary_file"

    # Start logging script progress
    echo "Script started at $(date)" >> "$main_dir/$progress_file"
    echo "Summaries will be saved to $summary_file" >> "$main_dir/$progress_file"

    # Iterate over each .txt file in the current directory
    for file in "$main_dir"/*.txt; do
	        # Check if the glob didn't match or if file doesn't exist
		    if [ ! -e "$file" ]; then
			            continue
				        fi
					    
					    if [ -f "$file" ]; then
						            file_path=$(realpath "$file")  # Get absolute path of the file
							            
							            # Process only if not processed before
								            if ! is_processed "$file_path"; then
										                echo "Processing $file"
												            echo "Processing $file" >> "$main_dir/$progress_file"
													                
													                # Create a temporary directory for the file's chunks
															            sanitized_name=$(basename "$file" | tr -d '[:space:]')
																                temp_dir=$(mktemp -d "$main_dir/tmp_${sanitized_name}_XXXXXX")
																		            echo "Temporary directory created: $temp_dir" >> "$main_dir/$progress_file"
																			                
																			                # Split the file into chunks of 100 lines each
																					            split -d -l 100 "$file" "$temp_dir/chunk_"
																						                echo "File split into chunks: $(find "$temp_dir" -type f)" >> "$main_dir/$progress_file"
																								            
																								            # Mention the file name before summarizing its chunks
																									                echo ""
																											            echo "Summarizing file: $file"
																												                echo "===== Summaries for $file =====" | tee -a "$main_dir/$summary_file"
																														            
																														            # Summarize each chunk without mentioning chunk names
																															                for chunk_file in "$temp_dir"/chunk_*; do
																																		                [ -f "$chunk_file" ] || continue
																																				                # Summarize the chunk and append directly to the summary file while also displaying to terminal
																																						                ollama run wizardlm2 "Translate from Arabic to English, line by line:" < "$chunk_file" | tee -a "$main_dir/$summary_file"
																																								                echo "" | tee -a "$main_dir/$summary_file"
																																										            done
																																											                
																																											                # Remove the temporary directory
																																													            rm -rf "$temp_dir"
																																														                echo "Temporary directory $temp_dir removed" >> "$main_dir/$progress_file"
																																																            
																																																            # Mark the file as processed
																																																	                echo "$file_path" >> "$main_dir/$progress_file"
																																																			        fi
																																																				    fi
																																																			    done

																																																			    echo "Script completed at $(date)" >> "$main_dir/$progress_file"
