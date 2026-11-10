#!/usr/bin/env bash
# Correct transcription errors without rewriting the spoken discussion.
# Requires Python 3. Run beside the transcripts, or supply their paths.
# Usage: bash fix_growth_transcription.sh [--dry-run] [FILE ...]
set -euo pipefail
command -v python3 >/dev/null 2>&1 || { printf 'Python 3 is required.\n' >&2; exit 1; }
python3 - "$@" <<'PY'
import argparse
import difflib
import os
from pathlib import Path
import re
import shutil
import tempfile

parser = argparse.ArgumentParser(description='Fix known TXT/VTT transcription errors; preserve timestamps and create .bak backups.')
parser.add_argument('--dry-run', action='store_true', help='show changes without writing files')
parser.add_argument('files', nargs='*', help='defaults to the two Why_Platforms_Force_You_to_Grow files')
args = parser.parse_args()
paths = [Path(p) for p in (args.files or [
    'Why_Platforms_Force_You_to_Grow.txt',
    'Why_Platforms_Force_You_to_Grow.vtt',
])]
if len({p.resolve() for p in paths}) != len(paths):
    parser.error('The same file was supplied more than once.')
for path in paths:
    if not path.is_file() or path.suffix.lower() not in {'.txt', '.vtt'}:
        parser.error(f'Expected an existing .txt or .vtt file: {path}')

# Targeted spelling and recognition repairs. Spoken arguments, repetitions,
# informal phrasing, and substantive claims are not rewritten.
# Match the split "puissant / process" cue by correcting its distinctive word.
rules = [
    (r'\bblaze pascal\b', 'Blaise Pascal'),
    (r'\bjacques elul\b', 'Jacques Ellul'),
    (r'\belul\b', 'Ellul'),
    (r'\b(?:phlexion|flakestream)\b', 'Flyxion'),
    (r'\b(?:tulex|tullic|tullet)\b', 'Tullock'),
    (r'\bpoison process\b', 'Poisson process'),
    (r'\bpush on process\b', 'Poisson process'),
    (r'\bpuissant\b', 'Poisson'),
    (r'\bpoisson processes\b', 'Poisson processes'),
    (r'\bsheep theory\b', 'sheaf theory'),
    (r"\bit's assumed trajectory\b", 'its assumed trajectory'),
    (r'\binactivity at dead zone\b', 'inactivity a dead zone'),
    (r'\bFlyxion models is mathematically\b', 'Flyxion models this mathematically'),
    (r'\bfollowing with the exact same advice\b', 'following the exact same advice'),
    (r'\bto truly prove the the platform', 'to truly prove the platform'),
    (r'\bit built on everything\b', 'it builds on everything'),
    (r'\bsee a 30(?=\s*$)', 'see a 30 percent'),
    (r'\blook 80 of our users\b', 'look 80 percent of our users'),
    (r"it's called the obligation to grow\b", "it's called The Obligation to Grow"),
    (r'\beveryone as founder\b', 'Everyone as Founder'),
    (r'\bthe hostile interface\b', 'The Hostile Interface'),
    (r'\bthe truman show\b', 'The Truman Show'),
    (r'\btruman\b', 'Truman'),
    (r'\bjim carrey\b', 'Jim Carrey'),
    (r'\bfacebook\b', 'Facebook'),
    (r'\bnovember 2026\b', 'November 2026'),
    (r'\bfrench philosopher\b', 'French philosopher'),
    (r'\bai tools\b', 'AI tools'),
]

plans = []
for path in paths:
    original_bytes = path.read_bytes()
    original = original_bytes.decode('utf-8')
    lines = original.splitlines(keepends=True)
    counts = [0] * len(rules)
    for index, line in enumerate(lines):
        # Do not touch VTT timing, cue identifiers, headers or metadata blocks.
        if path.suffix.lower() == '.vtt':
            continue  # VTT text is handled block by block below.
        for rule_index, (pattern, replacement) in enumerate(rules):
            line, count = re.subn(pattern, replacement, line)
            counts[rule_index] += count
        lines[index] = line
    if path.suffix.lower() == '.vtt':
        in_cue = False
        metadata = False
        for index, line in enumerate(lines):
            stripped = line.strip()
            if not stripped:
                in_cue = False
                metadata = False
                continue
            if metadata:
                continue
            if stripped == 'NOTE' or stripped.startswith('NOTE ') or stripped in {'STYLE', 'REGION'}:
                metadata = True
                continue
            if '-->' in line:
                in_cue = True
                continue
            if not in_cue:
                continue
            for rule_index, (pattern, replacement) in enumerate(rules):
                line, count = re.subn(pattern, replacement, line)
                counts[rule_index] += count
            lines[index] = line
    corrected = ''.join(lines)
    if len(original.splitlines()) != len(corrected.splitlines()):
        raise RuntimeError(f'Line count changed: {path}')
    if path.suffix.lower() == '.vtt':
        assert [s for s in original.splitlines() if '-->' in s] == [s for s in corrected.splitlines() if '-->' in s]
    plans.append((path, original_bytes, original, corrected, counts))

for path, original_bytes, original, corrected, counts in plans:
    if corrected == original:
        print(f'{path}: no changes needed')
        continue
    print(f'{path}: {sum(counts)} corrections')
    if args.dry_run:
        print(''.join(difflib.unified_diff(original.splitlines(keepends=True), corrected.splitlines(keepends=True), fromfile=str(path), tofile=str(path) + ' (corrected)')), end='')
        continue
    backup = Path(str(path) + '.bak')
    # Keep the first backup forever; refuse to overwrite it on subsequent runs.
    try:
        with backup.open('xb') as handle:
            handle.write(original_bytes)
        shutil.copystat(path, backup)
    except FileExistsError:
        pass
    descriptor, temporary = tempfile.mkstemp(prefix='.' + path.name + '.', dir=path.parent)
    try:
        with os.fdopen(descriptor, 'wb') as handle:
            handle.write(corrected.encode('utf-8'))
        os.chmod(temporary, path.stat().st_mode & 0o777)
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)
    print(f'  Updated; original backup: {backup}')
PY
