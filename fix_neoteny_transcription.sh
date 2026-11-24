#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - "$@" <<'PY'
from pathlib import Path
import re, shutil, sys
base = Path(sys.argv[1]) if len(sys.argv)>1 else Path('.')
stem = 'Why_Adult_Curiosity_Needs_Protected_Time'
rules = [
(r'\b(?:Felicia|Phlyxen|Flaggson|Flacom|Fraxion)\b', 'Flyxion'),
(r'\bneotony\b', 'neoteny'),
(r'\bgeozotic\b', 'geodesic'),
(r'\bWatt-Strogatz\b', 'Watts–Strogatz'),
(r'\bNicholas Georgescu-Roygen\b', 'Nicholas Georgescu-Roegen'),
(r'\bLuke Bolchansky and Ev Chappello\b', 'Luc Boltanski and Ève Chiapello'),
(r'\bThese see the whole spectrum\b', 'They see the whole spectrum'),
(r'\bpeer suppression\b', 'pure suppression'),
(r'\bpresence under the tree\b', 'presents under the tree'),
(r'\bunexaminaable\b', 'unexaminable'),
(r'\bco-ops the term\b', 'co-opts the term'),
(r'\bKevin Bacon phenomena\b', 'Kevin Bacon phenomenon'),
(r'\bslack notification\b', 'Slack notification'),
(r'\bsocio-emotional selectivity theory\b', 'socioemotional selectivity theory'),
(r'\bThe tech(?=\s*$)', 'The text'),
(r'\bor zero(?=\s*$)', 'where zero'),
(r'\blog normal\b', 'lognormal'),
(r'\bsmall world graph\b', 'small-world graph'),
]
updates=[]
for ext in ('.txt','.vtt'):
    p=base/(stem+ext)
    raw=p.read_bytes(); original=raw.decode('utf-8'); lines=original.splitlines(keepends=True); count=0
    for i,line in enumerate(lines):
        if '-->' in line or line.strip()=='WEBVTT': continue
        for pattern,replacement in rules:
            line,n=re.subn(pattern,replacement,line); count+=n
        lines[i]=line
    result=''.join(lines)
    assert len(result.splitlines())==len(original.splitlines())
    assert re.findall(r'\r\n|\r|\n',result)==re.findall(r'\r\n|\r|\n',original)
    assert [l for l in result.splitlines() if '-->' in l]==[l for l in original.splitlines() if '-->' in l]
    updates.append((p,raw,result.encode('utf-8'),count))
for p,raw,result,count in updates:
    if raw!=result:
        backup=p.with_name(p.name+'.bak')
        if not backup.exists(): shutil.copy2(p,backup)
        p.write_bytes(result)
    print(f'{p.name}: {count} corrections')
PY

