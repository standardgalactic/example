#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 - <<'PY'
from pathlib import Path
import re, shutil
stem='How_Motor_Resonance_Shapes_Human_Attraction'
fixes=[
(r'\bthe peeper details\b','the paper details'),
(r'\bcalorie dense\b','calorie-dense'),
(r'\bhip to waist ratio\b','hip-to-waist ratio'),
(r'\bsensory motor\b','sensorimotor'),
(r'\bmotor independent\b','motor-independent'),
(r'\bChristian Huygens\b','Christiaan Huygens'),
(r'\bArnold Tongue\b','Arnold tongue'),
(r'\bArnold Tongue\b','Arnold tongue'),
(r'\bAdler equation\b','Adler equation'),
(r'\bBeing intake mathematically feels physically good\b','Being in sync mathematically feels physically good'),
(r'\bLet.s reach this out\b',"Let's flesh this out"),
(r'\bthe volume of the cord being struck\b','the volume of the chord being struck'),
(r'\bwhich specific cord is being played\b','which specific chord is being played'),
(r'\bif that internal cord rings loudly enough\b','if that internal chord rings loudly enough'),
(r'\bthe replica equation\b','the replicator equation'),
(r'\bthe infectiousness trap\b','the sphexishness trap'),
(r'\bSfectiousness\b','Sphexishness'),
(r'\bthis spexish tendency\b','this sphexish tendency'),
(r'\ba rigid, spexish loop\b','a rigid, sphexish loop'),
(r'\bDouglas Hofstetter\b','Douglas Hofstadter'),
(r'\bserve as living food for her ex\b','serve as living food for her eggs'),
(r'\bthe scientist will do this 40 times\b','the scientist would do this 40 times'),
(r'\bthe mathematical outputs that are statistically closest\b','the mathematical outputs that are statistically closest'),
(r'\bNo key at all\b','No key at all'),
]
for suffix in ('.txt','.vtt'):
    p=Path(stem+suffix)
    if not p.exists():
        print('Missing',p);continue
    original=p.read_text(encoding='utf-8-sig')
    updated=original
    n=0
    for pattern,replacement in fixes:
        updated,count=re.subn(pattern,replacement,updated,flags=re.IGNORECASE)
        n+=count
    if suffix=='.vtt':
        times=lambda s:re.findall(r'^\S+\s+-->\s+\S+.*$',s,re.MULTILINE)
        assert times(original)==times(updated),'VTT timestamps changed'
    if updated!=original:
        backup=Path(str(p)+'.bak')
        if not backup.exists(): shutil.copy2(p,backup)
        p.write_text(updated,encoding='utf-8')
    print(f'{p.name}: {n} replacements')
PY

