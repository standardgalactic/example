#!/usr/bin/env bash
# Correct transcription errors without rewriting the spoken discussion.
# Requires Python 3. Run beside the transcripts, or supply their paths.
# Usage: bash fix_integer_transcription.sh [--dry-run] [FILE ...]
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
parser.add_argument('files', nargs='*', help='defaults to the two Eliminating_Phantom_Variation_with_Integer_Math files')
args = parser.parse_args()
paths = [Path(p) for p in (args.files or [
    'Eliminating_Phantom_Variation_with_Integer_Math.txt',
    'Eliminating_Phantom_Variation_with_Integer_Math.vtt',
])]
if len({p.resolve() for p in paths}) != len(paths):
    parser.error('The same file was supplied more than once.')
for path in paths:
    if not path.is_file() or path.suffix.lower() not in {'.txt', '.vtt'}:
        parser.error(f'Expected an existing .txt or .vtt file: {path}')

# Deliberately targeted: do not replace ordinary "sync" (e.g. "in perfect sync")
# or "decibel" in the music analogy. Numerical research claims and rhetorical
# overstatements are retained. These rules fix spelling, terminology, and clear
# recognition errors, including two units garbled as percentages.
rules = [
    (r'\bNunder Formats\b', 'Number Formats'),
    (r'\bchat GPT\b', 'ChatGPT'),
    (r'\bSMOL-LM2-135M\b', 'SmolLM2-135M'),
    (r'\bsmall LM2-135M\b', 'SmolLM2-135M'),
    (r'\bsmall LM2\b', 'SmolLM2'),
    (r'\bRMS(?:[ -])NORM\b|\bRMS norm\b', 'RMSNorm'),
    (r'\bthe significant or the mantissa\b', 'the significand or the mantissa'),
    (r'\bHorace, he pointed out\b', 'Horace He pointed out'),
    (r'\bthese are assigned integers\b', 'these are signed integers'),
    (r'\bk represents the activations\b', 'a represents the activations'),
    (r'\bNo, a 64-bit integer\b', 'Now, a 64-bit integer'),
    (r'\bspits out a decibel\b', 'spits out a decimal'),
    (r'\bSan et al\.', 'Sun et al.'),
    (r'\bDetmers\b', 'Dettmers'),
    (r'\battention syncs\b', 'attention sinks'),
    (r'\bAttention syncs\b', 'Attention sinks'),
    (r'\battention-sync\b', 'attention-sink'),
    (r'\b(?:sync|SYNC) tokens?\b', lambda m: 'sink tokens' if m.group().endswith('tokens') else 'sink token'),
    (r'\bsoul word drawer\b', 'silverware drawer'),
    (r'\b20,500% spike\b', '20,500 activation spike'),
    (r'\b0\.12% penalty\b', '0.12-nat penalty'),
    (r'\bNATS\b', 'nats'),
    (r'\bbase E\b', 'base e'),
    (r'\b2 to the 53rd limit pounds\b', '2 to the 53rd bounds'),
    (r'\bghost of the machine is officially exercised\b', 'ghost of the machine is officially exorcised'),
    (r'\bcache decoding\b', 'cached decoding'),
    (r'\bWhich leads us with a final\b', 'Which leaves us with a final'),
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
