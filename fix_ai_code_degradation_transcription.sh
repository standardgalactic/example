#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem='How_AI_Code_Degrades_Software_Quality'
# Conservative corrections to recognisable transcription errors. No content is removed.
replacements=[
 (r'Google\s+Dora\s+Research\s+Group', 'Google DORA research group'),
 (r'\bDora\b', 'DORA'),
 (r'\bGetClear\b', 'GitClear'),
 (r'\bGet\s+Clear\b', 'GitClear'),
 (r'\bTech\s+Radar\b', 'TechRadar'),
 (r'\bAI\s+Slap\b', 'AI slop'),
 (r'\bManny\s+Lehman\b', 'M. M. Lehman'),
 (r'\bLehman\'s\s+Laws\b', "Lehman's laws"),
 (r'\bLehman\'s\s+laws\b', "Lehman's laws"),
 (r'\bthe\s+dry\s+principle\b', 'the DRY principle'),
 (r'\bremained\s+firmly\s+infringed\b', 'remained firmly entrenched'),
 (r'\bfeel\s+like\s+odds\b', 'feel like gods'),
 (r'\bthe\s+meta\s+study\s+developers\b', 'the METR study developers'),
 (r'\bAI\s+adoption\s+and\s+coding\b', 'AI adoption in coding'),
 (r'\bcode\s+bases\b', 'codebases'),
 (r'\bmachine\s+written\b', 'machine-written'),
 (r'\bhuman\s+centric\b', 'human-centric'),
 (r'\bopen\s+source\b', 'open-source'),
 (r'\bcyber\s+security\b', 'cybersecurity'),
 (r'\b100\s+line\s+version\b', '100-line version'),
 (r'\b10\s+lines\s+of\s+elegantly\s+written\b', '10 lines of elegantly written'),
]
for ext in ('.txt','.vtt'):
    p=Path(stem+ext)
    original=p.read_text(encoding='utf-8-sig')
    updated=original
    counts=[]
    for pattern,repl in replacements:
        updated,n=re.subn(pattern.replace(r'\s+',r'[ \t]+'),repl,updated,flags=re.IGNORECASE)
        if n: counts.append((pattern,n))
    if ext=='.vtt':
        stamp=r'(?m)^\d{2}:\d{2}(?::\d{2})?\.\d{3} --> \d{2}:\d{2}(?::\d{2})?\.\d{3}.*$'
        assert re.findall(stamp,original)==re.findall(stamp,updated),'Timestamp modification detected'
    assert updated.count('\n')==original.count('\n'), 'Line count changed unexpectedly'
    if updated!=original:
        backup=p.with_name(p.name+'.bak')
        if not backup.exists(): shutil.copy2(p,backup)
        p.write_text(updated,encoding='utf-8',newline='')
    print(f'{p.name}: {sum(n for _,n in counts)} replacements; {len(counts)} patterns matched')
PY

