#!/usr/bin/env bash
set -euo pipefail
# Correct transcription/spelling in two TXT/VTT pairs, preserving WebVTT cues.
# Run in the directory containing all four files. Requires Python 3.
python3 - <<'PY'
from pathlib import Path
import re, shutil

pairs = {
 'The_Mathematics_of_Information_Loss': [
  (r'\bPhylacian\b', 'Flyxion'),
  (r'\btri-structure\b', 'trie structure'),
  (r'\bto save Piper\b', 'to save paper'),
  (r'\bTo perfect compression\b', 'So, perfect compression'),
  (r'\bthe tree time\b', 'the true time'),
  (r'\bAnd event list\b', 'An event list'),
  (r'\bmagic eight ball to saying\b', 'Magic 8 Ball just saying'),
  (r'\ba query to find solely on its own internal events\b', 'a query defined solely on its own internal events'),
  (r'\btime stamp\b', 'timestamp'),
  (r'\btime stamps\b', 'timestamps'),
  (r'\bzero crossing time stamps\b', 'zero-crossing timestamps'),
  (r'\b10 hertz\b', '10 Hz'),
  (r'\b50 hertz\b', '50 Hz'),
  (r'\b360 hertz\b', '360 Hz'),
  (r'\bscipy library\b', 'SciPy library'),
  (r'\bphase locking\b', 'phase-locking'),
  (r'\bfalse valid answers\b', 'false-valid answers'),
 ],
 'Why_AI_Compression_Creates_Dangerous_Blind_Spots': [
  (r'\bJan Lekan\b', 'Yann LeCun'),
  (r'\bFlyxion Team\'s\b', "Flyxion's"),
  (r'\bA\.I\. Syncoder\b', 'AI encoder'),
  (r'\bPluxian\b', 'Flyxion'),
  (r'\bFlorexie\b', 'Flyxion'),
  (r'\bchoosing a course of representation\b', 'choosing a coarse representation'),
  (r'\bit was searched for an action\b', 'it must search for an action'),
  (r'\bforced to plate safe\b', 'forced to play it safe'),
  (r'\buniversally states action\b', 'universally safe action'),
  (r'\bto safe compute\b', 'to save compute'),
  (r'\bThough are logically independent outcomes\b', 'Those are logically independent outcomes'),
  (r'\bIt was perfectly stated\b', 'It was perfectly stated'),
  (r'\bwithout braking\b', 'without breaking'),
  (r'\bthe pendulum sync up\b', 'the pendulums sync up'),
  (r'\bYou log the food, \$50 receipt\b', 'You log the $50 food receipt'),
  (r'\bQuestion Relative Sufficiency\b', 'Question-Relative Sufficiency'),
  (r'\bjoint-embedding predictive architecture\b', 'Joint-Embedding Predictive Architecture'),
  (r'\bA\.I\.\b', 'AI'),
 ]
}

stamp = re.compile(r'^\s*(?:\d\d:)?\d\d:\d\d\.\d\d\d\s+-->\s+(?:\d\d:)?\d\d:\d\d\.\d\d\d.*$', re.M)
for stem, rules in pairs.items():
    for ext in ('.txt', '.vtt'):
        path = Path(stem + ext)
        if not path.is_file():
            raise SystemExit(f'Missing {path}; run this script beside the four files')
        original = path.read_text(encoding='utf-8-sig')
        updated = original
        changes = 0
        for pattern, replacement in rules:
            updated, n = re.subn(pattern, replacement, updated)
            changes += n
        if ext == '.vtt' and stamp.findall(original) != stamp.findall(updated):
            raise SystemExit(f'ERROR: timestamps would change in {path}')
        if updated != original:
            backup = path.with_name(path.name + '.bak')
            if not backup.exists():
                shutil.copy2(path, backup)
            path.write_text(updated, encoding='utf-8')
        print(f'{path}: {changes} corrections' + (' (unchanged)' if updated == original else ''))
print('Done. Original files backed up as *.bak (if changes were made).')
PY

