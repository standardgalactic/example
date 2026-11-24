#!/usr/bin/env bash
set -euo pipefail
# Run in the directory containing the TXT and VTT files. Requires Python 3.
python3 - <<'PY'
from pathlib import Path
import re, shutil

stem = 'Why_Max_Tegmark_s_AI_Warning_Fails'
# Conservative substitutions based on identifiable ASR mistakes, not editorial rewriting.
fixes = [
 (r'\bFlagzeon\b', 'Flyxion'),
 (r'\bFleix Sheen\b', 'Flyxion'),
 (r'\bTegmar\b', 'Tegmark'),
 (r'\bTakemark\b', 'Tegmark'),
 (r'\bTickmark\b', 'Tegmark'),
 (r'\bTamar\b', 'Tegmark'),
 (r'\bAnthropik\b', 'Anthropic'),
 (r'\bDario Amadei\b', 'Dario Amodei'),
 (r'\bAmdl\x27s law\b', "Amdahl's law"),
 (r'\bad revenant\b', 'ad revenue'),
 (r'\bthis hearing wheel\b', 'this steering wheel'),
 (r'\bmost subductive, intuitive leap\b', 'most seductive, intuitive leap'),
 (r'\btreasonous political meeting\b', 'treasonous political meaning'),
 (r'\bThe software math is missing\b', 'The supporting math is missing'),
 (r'\bif the software math is underdetermined\b', 'if the supporting math is underdetermined'),
 (r'\bAmdl\x27s Law\b', "Amdahl's Law"),
 (r'\boverthrowing the U\.S\. government\b', 'overthrowing the U.S. government'),
 (r'\bshut-down mechanisms\b', 'shutdown mechanisms'),
 (r'\bspeed up\b', 'speedup'),
 (r'\bfinite time divergence\b', 'finite-time divergence'),
 (r'\b20 watt brain\b', '20-watt brain'),
]
for suffix in ('.txt', '.vtt'):
    path = Path(stem + suffix)
    if not path.is_file():
        raise SystemExit(f'Missing {path}; run this script alongside both transcripts.')
    original = path.read_text(encoding='utf-8')
    updated = original
    counts = []
    for pattern, replacement in fixes:
        updated, count = re.subn(pattern, lambda m, r=replacement: r, updated, flags=re.IGNORECASE)
        if count:
            counts.append((replacement, count))
    if suffix == '.vtt':
        timestamps = lambda s: [line for line in s.splitlines() if '-->' in line]
        if timestamps(original) != timestamps(updated):
            raise SystemExit('VTT timestamp check failed; no file written.')
    if updated != original:
        backup = Path(str(path) + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_text(updated, encoding='utf-8')
    print(f'{path}: {sum(n for _, n in counts)} replacements; backup retained if modified')
    for name, n in counts:
        print(f'  {n:>2}  {name}')
PY
