import os
import re

def clean_vtt_content(content):
    """
    Clean the content of a VTT file by removing duplicates, timestamps, style tags, and metadata.
    Args:
        content (str): The content of the VTT file.
    Returns:
        str: Cleaned plain text without duplicates.
    """
    lines = content.splitlines()
    plain_text = []
    seen_lines = set()  # To store unique lines

    for line in lines:
        # Skip timestamps and metadata
        if re.match(r'\d{2}:\d{2}:\d{2}\.\d{3} --> \d{2}:\d{2}:\d{2}\.\d{3}', line) or line.strip() == '' or line.startswith(('WEBVTT', 'Kind:', 'Language:', 'NOTE')):
            continue

        # Remove inline timestamps and style tags (e.g., <00:00:00.240> or <c>)
        cleaned_line = re.sub(r'<\d{2}:\d{2}:\d{2}\.\d{3}>', '', line)  # Remove inline timestamps
        cleaned_line = re.sub(r'<.*?>', '', cleaned_line)  # Remove any remaining tags (e.g., <c>)

        # Append only unique lines
        if cleaned_line.strip() and cleaned_line not in seen_lines:
            plain_text.append(cleaned_line.strip())
            seen_lines.add(cleaned_line)

    return "\n".join(plain_text)

def vtt_to_plain_text(input_file, output_file):
    """
    Convert a VTT subtitle file to plain text.
    Args:
        input_file (str): Path to the input VTT file.
        output_file (str): Path to save the output plain text file.
    """
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    cleaned_text = clean_vtt_content(content)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(cleaned_text)

def process_all_vtt_files():
    """
    Process all VTT files in the current directory, converting them to plain text.
    """
    for file in os.listdir():
        if file.endswith('.vtt'):
            output_file = file.rsplit('.', 1)[0] + '.txt'
            print(f"Processing {file} -> {output_file}")
            vtt_to_plain_text(file, output_file)

# Run the script
if __name__ == "__main__":
    process_all_vtt_files()
