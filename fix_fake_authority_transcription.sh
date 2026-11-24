#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem = 'Why_Fake_Authority_Looks_Real'
# Exact, context-sensitive speech recognition corrections. Avoid changing the speaker's argument.
replacements = [
 (r'\btheogalon\b', 'Theo Galavan'),
 (r'\btheo (?:gallivan|gollivan|gallivin)\b', 'Theo Galavan'),
 (r'\b(?:gallivan|galavan|gallivin|gallivins)\b', 'Galavan'),
 (r'\b(?:vaultec|voltech|vault tech)\b', 'Vault-Tec'),
 (r'\b(?:barns)\b', 'Barnes'),
 (r'\b(?:mackenzie)\b', 'McKenzie'),
 (r'\bnon-identify ability\b', 'non-identifiability'),
 (r'\bthe city is just suffered\b', 'the city has just suffered'),
 (r'\bthe viewers of gotham no Galavan\b', 'the viewers of Gotham know Galavan'),
 (r'\bthey start finding a family\b', 'they start fining a family'),
 (r'\bdiverse old growth force\b', 'diverse old-growth forest'),
 (r'\bit is actively destroyed the welfare\b', 'it has actively destroyed the welfare'),
 (r'\blook at this hospital i build\b', 'look at this hospital I built'),
 (r'\bjust by the corporation good pr\b', 'just buy the corporation good PR'),
 (r'\bmust to be logically consistent except the exact same\b', 'must, to be logically consistent, accept the exact same'),
 (r'\bthe barnes\'s and the Galavan of the world\b', "the Barneses and the Galavans of the world"),
 (r'\bthe barnes\'s and the gallivins of the world\b', 'the Barneses and the Galavans of the world'),
 (r'\blegal rational authority\b', 'legal-rational authority'),
 (r'\bhigh modernist\b', 'high-modernist'),
 (r'\bthe german state forests\b', 'the German state forests'),
 (r'\bthe great depression\b', 'the Great Depression'),
 (r'\bthe new deal\b', 'the New Deal'),
 (r'\bthe ring of gyges\b', 'the Ring of Gyges'),
 (r'\bglaucon\b', 'Glaucon'),
 (r'\birving goffman\b', 'Erving Goffman'),
 (r'\bjames c scott\b', 'James C. Scott'),
 (r'\brobert k merton\b', 'Robert K. Merton'),
 (r'\bmax weber\b', 'Max Weber'),
 (r'\bnaomi klein\b', 'Naomi Klein'),
 (r'\bjacob silverman\b', 'Jacob Silverman'),
 (r'\bben McKenzie\b', 'Ben McKenzie'),
 (r'\boswald cobblepot\b', 'Oswald Cobblepot'),
 (r'\bnathaniel barnes\b', 'Nathaniel Barnes'),
 (r'\bthe maniacs\b', 'the Maniax'),
 (r'\bthe shock doctrine\b', 'The Shock Doctrine'),
 (r'\bseeing like a state\b', 'Seeing Like a State'),
 (r'\bthe presentation of self\b', 'The Presentation of Self'),
]
for ext in ('.txt', '.vtt'):
    path = Path(stem + ext)
    if not path.exists():
        raise SystemExit(f'Missing {path}')
    original = path.read_bytes()
    data = original.decode('utf-8-sig')
    timestamps = re.findall(r'(?m)^\S+\s+-->\s+\S+.*$', data) if ext == '.vtt' else []
    total = 0
    for pattern, replacement in replacements:
        data, n = re.subn(pattern, replacement, data, flags=re.IGNORECASE)
        total += n
    if ext == '.vtt':
        assert timestamps == re.findall(r'(?m)^\S+\s+-->\s+\S+.*$', data), 'VTT timestamps changed'
    updated = data.encode('utf-8-sig' if original.startswith(b'\xef\xbb\xbf') else 'utf-8')
    if updated != original:
        backup = path.with_name(path.name + '.bak')
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_bytes(updated)
    print(f'{path.name}: {total} corrections; backup preserved')
PY
