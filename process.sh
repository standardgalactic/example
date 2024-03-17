#!/bin/bash

# Iterate through each directory
for dir in */; do
	# Change into the directory
	cd "$dir" || continue  # Continue to the next directory if cd fails

		    # Run the command 'whisper *' inside the directory
		    whisper ./*

			    # Change back to the original directory
			    cd ..
		    done
