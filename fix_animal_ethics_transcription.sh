#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python3 - "$DIR" <<'PY'
from pathlib import Path
import re, shutil, sys
folder=Path(sys.argv[1]); stem='Why_Animal_Ethics_Fail_Mathematical_Logic'
# Conservative, source-verified corrections. Preserve all cue timestamps and conversational wording.
replacements=[
 (r'\bFleisen\'s\b', "Flyxion's"),
 (r'\bfliance paper\b', "Flyxion's paper"),
 (r'\bSheaf Theoretic Language\b', 'sheaf-theoretic language'),
 (r'\bSheaf Theory\b', 'sheaf theory'),
 (r'\bsheath theory\b', 'sheaf theory'),
 (r'\bBratanova, Lofnan, and Bastien\b', 'Bratanova, Loughnan, and Bastian'),
 (r'\bBastien and Loughnan\b', 'Bastian and Loughnan'),
 (r'\bAndrew Nikephoric\b', 'Andrew Nikiforuk'),
 (r'\bNikephoric\'s\b', "Nikiforuk's"),
 (r'\bHusser and Harris\b', 'Hussar and Harris'),
 (r'\bprincipal cares\b', 'principle cares'),
 (r'\bprincipal admits\b', 'principle admits'),
 (r'\bprincipal explicitly states\b', 'principle explicitly states'),
 (r'\bprincipal itself\b', 'principle itself'),
 (r'\bthe principal\b', 'the principle'),
 (r'\bYour principal\b', 'Your principle'),
 (r'\byour principal\b', 'your principle'),
 (r'\bnon-human\b', 'nonhuman'),
 (r'\bdeath productive accumulation\b', 'death-productive accumulation'),
 (r'\bdeath productive enterprise\b', 'death-productive enterprise'),
 (r'\bdeath productive enterprises\b', 'death-productive enterprises'),
 (r'\brelevance information loss\b', 'relevance-information loss'),
 (r'\bquarter over quarter\b', 'quarter-over-quarter'),
 (r'\bthe color of the individual\'s hair\? Or is this action taking place on a Tuesday\?', "the color of the individual's hair? Or is this action taking place on a Tuesday?"),
 (r'\bhair color in the day of the week\b', 'hair color and the day of the week'),
 (r'\bthe individual affected by the action\b', 'the individual affected by the action'),
 (r'\bthe author asked this really brutal question\b', 'the author asks this really brutal question'),
]
for ext in ('txt','vtt'):
    path=folder/f'{stem}.{ext}'
    if not path.is_file(): raise SystemExit(f'Missing: {path}')
    original=path.read_text(encoding='utf-8-sig')
    timestamp_lines=[line for line in original.splitlines() if '-->' in line]
    fixed=original; counts=[]
    for pattern, repl in replacements:
        fixed,n=re.subn(pattern,lambda m,r=repl:r,fixed)
        if n: counts.append((pattern,n))
    if [line for line in fixed.splitlines() if '-->' in line] != timestamp_lines:
        raise SystemExit(f'Refusing to write: timestamp changed in {path.name}')
    if fixed != original:
        backup=path.with_name(path.name+'.bak')
        if not backup.exists(): shutil.copy2(path,backup)
        path.write_text(fixed,encoding='utf-8')
    print(f'{path.name}: {sum(n for _,n in counts)} corrections; {len(timestamp_lines)} timestamps unchanged')
    for p,n in counts: print(f'  {n}x {p}')
PY

