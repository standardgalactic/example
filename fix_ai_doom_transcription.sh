#!/usr/bin/env bash
set -euo pipefail
DIR="${1:-.}"
python3 - "$DIR" <<'PY'
from pathlib import Path
import sys,re,shutil
root=Path(sys.argv[1]); stem='The_Flawed_Math_of_AI_Doom_Headlines'
# Literal, context-sensitive transcription corrections; preserve spoken wording otherwise.
fixes=[
(r'\bduarkesh patel\b','Dwarkesh Patel'),
(r'\bpaul cristiano\b','Paul Christiano'),
(r'\bcristiano\b','Christiano'),
(r'\bchristiana\b','Christiano'),
(r'\bfreiburg\b','Flyxion'),
(r'\bflikes incites\b','Flyxion cites'),
(r'\bfleecy and\b','Flyxion'),
(r'\bflaxseeing\b','Flyxion'),
(r'\bflagstern\b','Flyxion'),
(r'\bflags and\b','Flyxion'),
(r'\bflags an entire point\b',"Flyxion's entire point"),
(r'\bfly axon\b','Flyxion'),
(r'\binflection emphasizes\b','Flyxion emphasizes'),
(r'\bflikes in\b','Flyxion'),
(r'\bflaxion\b','Flyxion'),
(r'\bflaxseeing\b','Flyxion'),
(r'\bgood heart\'s law\b',"Goodhart's law"),
(r'\brue goldberg\b','Rube Goldberg'),
(r'\brube goldberg\b','Rube Goldberg'),
(r'\bgene amdahl\b','Gene Amdahl'),
(r'\bamdahl\'s law\b',"Amdahl's law"),
(r'\bhugging face\b','Hugging Face'),
(r'\bhacktron ai\b','Hacktron AI'),
(r'\bopen ai agents\b','OpenAI agents'),
(r'\bopen ai\b','OpenAI'),
(r'\bgoogle deep mind\b','Google DeepMind'),
(r'\bgithub\b','GitHub'),
(r'\bslack\b','Slack'),
(r'\bmonte carlo\b','Monte Carlo'),
(r'\bnsa\b','NSA'),
(r'\bsso\b','SSO'),
(r'\bgpus\b','GPUs'),
(r'\bids\b','IDs'),
(r'\bthe ai alliance naturally\b','the AI aligns naturally'),
(r'\ban unlined super\b','an unaligned super'),
(r'\bto coordinated defense\b','to coordinate defense'),
(r'\band testing environments\b','in testing environments'),
(r'\bcopy paste that certainty\b','copy-pastes that certainty'),
(r'\bthe function error constant\b','the function is constant'),
(r'\bthey did not launch a zero-day\b','they did not launch a zero-day'),
(r'\bthey only demonstrated right access\b','they only demonstrated write access'),
(r'\bdeclined to exercise read access\b','declined to exercise read access'),
(r'\bwe can beat published system cards\b','we can read published system cards'),
(r'\blook at disclose corporate\b','look at disclosed corporate'),
(r'\bthe boats still have to across the pacific\b','the boats still have to cross the Pacific'),
(r'\btime of physical training run takes\b','time a physical training run takes'),
(r'\bsilicone fabrication\b','silicon fabrication'),
(r'\bneutral look\b','new rulebook'),
]
for ext in ('.txt','.vtt'):
    path=root/(stem+ext)
    if not path.is_file(): raise SystemExit(f'Missing: {path}')
    raw=path.read_text(encoding='utf-8-sig'); timing=[x for x in raw.splitlines() if '-->' in x] if ext=='.vtt' else []
    out=raw; changes=[]
    for pattern,repl in fixes:
        out,n=re.subn(pattern,repl,out,flags=re.IGNORECASE)
        if n: changes.append((pattern,n))
    if ext=='.vtt':
        assert [x for x in out.splitlines() if '-->' in x]==timing,'VTT timestamps changed!'
        assert out.startswith('WEBVTT'),'Invalid VTT header'
    if out!=raw:
        backup=path.with_name(path.name+'.bak')
        if not backup.exists(): shutil.copy2(path,backup)
        path.write_text(out,encoding='utf-8')
    print(f'{path.name}: {sum(n for _,n in changes)} corrections across {len(changes)} rules; timestamp lines unchanged')
PY

