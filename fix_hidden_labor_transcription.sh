#!/usr/bin/env bash
set -euo pipefail
python3 - "$@" <<'PY'
from pathlib import Path
import sys, shutil, re
base = Path(sys.argv[1]) if len(sys.argv)>1 else Path('.')
paths = [base / ('The_Hidden_Labor_Behind_AI_Math.' + ext) for ext in ('txt','vtt')]
for p in paths:
    if not p.is_file(): raise SystemExit(f'Missing file: {p}')
replacements = {
    'flexions critique': "Flyxion's critique",
    'Flylec Sun': 'Flyxion',
    'AI Flyxion its circuits': 'AI flexing its circuits',
    'new 0.94 exponent': 'new 9/4 exponent',
    'O of n to the 0.94 plus epsilon': 'O of n to the 9/4 plus epsilon',
    'the 94 upper bound': 'the 9/4 upper bound',
    'a 9-4 matrix multiplication bound': 'a 9/4 matrix multiplication bound',
    'the 94 algorithm': 'the 9/4 algorithm',
    'asymptotic exponent of 94': 'asymptotic exponent of 9/4',
    'db dt equals lambda mu': 'dB/dt equals lambda minus mu',
    'E sub i equals V sub i times S sub i times U sub i': 'E sub i equals V sub i minus S sub i minus U sub i',
    'verification capacity via view': 'verification capacity v(u)',
    'verification capacity mu as available': 'verification capacity v(u) as available',
    'DuPont': 'Dupont',
    'Aminov': 'Amanov',
    'Vandenberg': 'van den Berg',
    'Zuadem': 'Zuiddam',
    'massive butt': 'massive but',
    'you suit the landlord': 'you sue the landlord',
    "you don't suit the guy": "you don't sue the guy",
    'The height metric': 'The hype metric',
    'single principle theorem': 'single principal theorem',
    "They're finding a one-page lemma": 'Verifying a one-page lemma',
    'puts in a reading': 'puts into reading',
    'Was the ultimate goal.': "What's the ultimate goal?",
}
for p in paths:
    original = p.read_bytes().decode('utf-8')
    lines = original.splitlines(keepends=True)
    count = 0
    for i,line in enumerate(lines):
        if p.suffix == '.vtt' and ('-->' in line or line.strip().lstrip('\ufeff') == 'WEBVTT'): continue
        for old,new in replacements.items():
            count += line.count(old)
            line = line.replace(old,new)
        for pattern,new in [(r'\bopen AI\b','OpenAI'),(r'\bOpen AI\b','OpenAI'),(r'\blean\b','Lean')]:
            line,n = re.subn(pattern,new,line); count += n
        lines[i] = line
    updated = ''.join(lines)
    if updated != original:
        backup = p.with_name(p.name + '.bak')
        if not backup.exists(): shutil.copy2(p,backup)
        p.write_bytes(updated.encode('utf-8'))
    print(f'{p.name}: {count} corrections')
PY

