#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'Why_Seamless_Documentaries_Distort_History'
# Conservative transcription repairs checked against representational-complexity.pdf.
replacements = [
 (r'\bFlyelik\b', 'Flyxion'),
 (r'\bFlaigstein\b', 'Flyxion'),
 (r'\bFlaggerson\b', 'Flyxion'),
 (r'\bFlaykowskis\b', 'Flyxion'),
 (r'\bfligation\b', 'Flyxion'),
 (r'\bFleikholzian\b', 'Flyxion'),
 (r'\bFlaxomon\b', 'Flyxion'),
 (r'\bFlyixion\b', 'Flyxion'),
 (r'\bVigalytics\b', 'Flyxion'),
 (r'\bFlagstaff\b', 'Flyxion'),
 (r'\bRomans\b', 'Rommens'),
 (r'\bRaman\b', 'Rommens'),
 (r'\bFauras de Arruda\b', 'Ferraz de Arruda'),
 (r'\bJeffrey Hinton\b', 'Geoffrey Hinton'),
 (r'\bRobocop\b', 'RoboCop'),
 (r'\bWar Games\b', 'WarGames'),
 (r'\bquery relative distortion\b', 'query-relative distortion'),
 (r'\bAuthentic Component Non-Entailment\b', 'Authentic-component non-entailment'),
 (r'\bPremiere to Tribeca\b', 'Premiered at Tribeca'),
 (r'\bfeatured documentary\b', 'feature documentary'),
 (r'\bthe man who had eventually found DeepMind\b', 'the man who would eventually found DeepMind'),
 (r'\bhow much of film\'s induced answers\b', "how much a film's induced answers"),
 (r'\ba guy in the 50s made of mouths\b', 'a researcher in the 1950s made a mechanical mouse'),
 (r'\blapped at him\b', 'laughed at him'),
 (r'\bthen the video is an evidence of destiny\b', 'then the video is not evidence of destiny'),
 (r'\bI\'m forging for the absolute truth\b', "I'm foraging for the absolute truth"),
 (r'\bFrictionalist is the perfect word\b', 'Frictionless is the perfect word'),
 (r'\ba mathematically distorting reality\b', 'I am mathematically distorting reality'),
 (r'\bthey are an evidence of destiny\b', 'they are evidence of destiny'),
]
for suffix in ('.txt', '.vtt'):
    path = Path(stem + suffix)
    if not path.is_file():
        raise SystemExit(f'Missing file: {path}')
    original = path.read_text(encoding='utf-8-sig')
    before_timestamps = re.findall(r'(?m)^.*-->.*$', original) if suffix == '.vtt' else []
    updated = original
    counts = []
    for pattern, replacement in replacements:
        updated, n = re.subn(pattern, lambda m, r=replacement: r, updated, flags=re.IGNORECASE)
        if n:
            counts.append((pattern, n))
    if suffix == '.vtt' and re.findall(r'(?m)^.*-->.*$', updated) != before_timestamps:
        raise SystemExit('Timestamp integrity check failed; no file written')
    if updated != original:
        backup = path.with_name(path.name + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_text(updated, encoding='utf-8')
    print(f'{path.name}: {sum(n for _, n in counts)} corrections; backup preserved')
PY

