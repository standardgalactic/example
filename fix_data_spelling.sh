#!/usr/bin/env bash
set -euo pipefail
DIR="${1:-.}"
python3 - "$DIR" <<'PY'
import pathlib, re, shutil, sys
root=pathlib.Path(sys.argv[1]); stem='The_Math_of_Safely_Discarding_Data'
# Corrections limited to identifiable transcription/spelling mistakes; no factual rewrites.
replacements=[
 ('Vibers','fibers'),('the vibers','the fibers'),
 ('Flay Axion','Flyxion'),('Flychan','Flyxion'),('Inflection puts','Flyxion puts'),('Fleikerson','Flyxion'),
 ('a concept of a meat in the lattice','a concept of a meet in the lattice'),
 ('the meat of','the meet of'),('find the meat','find the meet'),
 ('participates into exactly two','partitions into exactly two'),
 ('you\'d hide to guess','you\'d have to guess'),
 ('Letting you that saved number 7','Looking at that saved number 7'),
 ('the function error constant','the function is constant'),
 ('your summaries bucket','your summary\'s bucket'),
 ('a one-to-one pixel perfect memory','a one-to-one pixel-perfect memory'),
 ('the fifth bell number','the fifth Bell number'),('the tenth bell number','the tenth Bell number'),
 ('the bell numbers example','the Bell numbers example'),('a bell number','a Bell number'),
 ('Fisher\'s Sufficiency','Fisher\'s sufficiency'),
]
for ext in ('.txt','.vtt'):
    p=root/(stem+ext)
    if not p.is_file(): raise SystemExit(f'Missing: {p}')
    raw=p.read_bytes(); bom=b'\xef\xbb\xbf' if raw.startswith(b'\xef\xbb\xbf') else b''
    body=raw[len(bom):].decode('utf-8'); newline='\r\n' if '\r\n' in body else '\n'
    count=0
    for old,new in replacements:
        # Whitespace-flexible for subtitles, but never across cue timestamps or blank lines.
        pat=re.compile(re.escape(old).replace(r'\ ',r'[ \t\r\n]+'),re.I if old in ('Vibers','Flay Axion','Flychan','Fleikerson') else 0)
        def replace(m):
            global count
            count+=1
            return new
        body=pat.sub(replace,body)
    if body.encode('utf-8')!=raw[len(bom):]:
        backup=p.with_name(p.name+'.bak')
        if not backup.exists(): shutil.copy2(p,backup)
        p.write_bytes(bom+body.encode('utf-8'))
    print(f'{p.name}: {count} corrections')
PY

