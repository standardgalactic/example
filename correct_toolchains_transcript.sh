#!/usr/bin/env bash
set -euo pipefail

# Run in the directory containing the two transcript files, or pass that directory.
dir=${1:-.}
base='Software_Toolchains_Are_the_Real_AI_Moat'

python3 - "$dir" "$base" <<'PY'
from pathlib import Path
import sys, shutil, difflib
folder, base = Path(sys.argv[1]), sys.argv[2]
replacements = [
    ('compute course of the GPU', 'compute cores of the GPU'),
    ('tool chain familiarity', 'toolchain familiarity'),
    ('tool chains like CUDA', 'toolchains like CUDA'),
    ('open source tool chain', 'open-source toolchain'),
    ('Dvorak or Comac', 'Dvorak or Colemak'),
    ('Arrival offers a slightly faster', 'a rival offers a slightly faster'),
    ('Kaixing Global', 'Caixin Global'),
    ('Nature of poor is a vacuum.', 'Nature abhors a vacuum.'),
    ('DeepSeq', 'DeepSeek'),
    ('Liaxon', 'Flyxion'),
    ('Flyethand', 'Flyxion'),
    ('Zalman', 'Zollman'),
    ('the assay argues', 'the essay argues'),
    ('exiflops', 'exaflops'),
    ('who are forced into Huawei\'s Ascend ecosystem', 'or forced into Huawei\'s Ascend ecosystem'),
]
for ext in ('.txt', '.vtt'):
    path = folder / (base + ext)
    if not path.is_file():
        raise SystemExit(f'Missing file: {path}')
    original = path.read_text(encoding='utf-8-sig')
    corrected = original
    for wrong, right in replacements:
        corrected = corrected.replace(wrong, right)
    if corrected == original:
        print(f'No changes: {path.name}')
        continue
    backup = path.with_name(path.name + '.bak')
    if not backup.exists():
        shutil.copy2(path, backup)
    path.write_text(corrected, encoding='utf-8')
    print(f'Updated {path.name} (backup: {backup.name})')
    for line in difflib.unified_diff(original.splitlines(), corrected.splitlines(), lineterm='', n=0):
        if line.startswith(('+', '-')) and not line.startswith(('+++', '---')):
            print(line)
PY

