#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem='How_Algorithms_Turned_Creators_Into_Inventory'
replacements=[
 ('The Manufacturer of Participation','The Manufacture of Participation'),
 ("Hitcher's Guide to the Galaxy", "Hitchhiker's Guide to the Galaxy"),
 ('Phylaxion','Flyxion'),
 ('pervergent','divergent'),
 ('deletrives','deprives'),
 ('the modern intranet','the modern internet'),
 ('on the intranet','on the internet'),
 ("the platform's introduced",'the platforms introduced'),
 ('Hubpages','HubPages'),
 ('Hub pages','HubPages'),
 ('lens masters','Lensmasters'),
 ('neon lit','neon-lit'),
 ('5 foot 7','five foot seven'),
 ('The source text calls document-oriented participation','The source text calls document-oriented participation'),
]
replacements=[(a,b) for a,b in replacements if a!=b]
for ext in ('.txt','.vtt'):
 p=Path(stem+ext)
 if not p.is_file(): raise SystemExit(f'Missing {p}')
 original=p.read_bytes()
 text=original.decode('utf-8')
 lines=text.splitlines(keepends=True)
 timing=[line for line in lines if '-->' in line] if ext=='.vtt' else []
 changes=[]
 for before,after in replacements:
  n=text.count(before)
  if n:
   text=text.replace(before,after)
   changes.append(f'{before!r} -> {after!r}: {n}')
 if ext=='.vtt':
  assert [line for line in text.splitlines(keepends=True) if '-->' in line]==timing, 'VTT timing changed'
  assert text.startswith('WEBVTT'), 'VTT header changed'
 if text!=original.decode('utf-8'):
  backup=Path(str(p)+'.bak')
  if not backup.exists(): shutil.copy2(p,backup)
  p.write_bytes(text.encode('utf-8'))
 print(f'{p}: {sum(int(s.rsplit(": ",1)[1]) for s in changes)} replacements')
 for c in changes: print('  '+c)
PY
