#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
base='Why_Replacing_Experts_With_AI_Backfires'
replacements=[
(r'\bCori Doctro\b','Cory Doctorow'),
(r'\bDoctro\b','Doctorow'),
(r'\bDoctoral\b','Doctorow'),
(r'\bDr\. (?:Roe|Rowe|Rell|O)\b','Doctorow'),
(r'\bDr\. Roe\b','Doctorow'),
(r'\bDr\. Rowe\b','Doctorow'),
(r'\bDr\. Rell\b','Doctorow'),
(r'\bDr\. O\b','Doctorow'),
(r'\bDr\. Roe\'s\b',"Doctorow's"),
(r'\bDr\. Rowe\'s\b',"Doctorow's"),
(r'\bDr\. O\'s\b',"Doctorow's"),
(r'\bVleiksen\b','Flyxion'),
(r'\bFlagsheen\b','Flyxion'),
(r'\bDepartment of Government Deficiency\b','Department of Government Efficiency'),
(r'\bDoty\b','DOGE'),
(r'\bThe cue backs up\b','The queue backs up'),
(r'\bribbed market mechanics\b','rigged market mechanics'),
(r'\breduction in peril as efficiency\b','reduction in payroll as efficiency'),
(r'\bthe primary engine to value creation\b','the primary engine of value creation'),
(r'\bnot as schematic\b','not a schematic'),
(r'\bthe source text uses this super powerful contrast\b','the source text uses this powerful contrast'),
]
for ext in ('.txt','.vtt'):
    path=Path(base+ext)
    if not path.exists():
        raise SystemExit(f'Missing: {path}')
    original=path.read_text(encoding='utf-8-sig')
    updated=original
    counts=[]
    for pattern,replacement in replacements:
        updated,n=re.subn(pattern,replacement,updated)
        if n: counts.append((pattern,n))
    if ext=='.vtt':
        timestamp=re.compile(r'^.*-->.*$',re.M)
        assert timestamp.findall(original)==timestamp.findall(updated), 'VTT timestamps changed'
    if updated!=original:
        backup=path.with_name(path.name+'.bak')
        if not backup.exists(): shutil.copy2(path,backup)
        path.write_text(updated,encoding='utf-8')
    print(f'{path.name}: {sum(n for _,n in counts)} corrections; backup created if modified')
PY

