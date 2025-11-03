# scaling_fit.py — empirical fitting without SciPy
from __future__ import annotations
import numpy as np, csv
from dataclasses import dataclass

@dataclass
class FitResult:
    params: dict; rss: float; r2: float; preds: np.ndarray

def load_trust_timeseries(path: str):
    years, phi = [], []
    with open(path, newline='', encoding='utf-8') as f:
        rdr = csv.DictReader(f)
        for r in rdr:
            years.append(int(r['year'])); phi.append(float(r['trust_index']))
    years=np.array(years); phi=np.array(phi); o=np.argsort(years)
    return years[o], phi[o]

def forward_model(years: np.ndarray, theta: np.ndarray, phi0: float) -> np.ndarray:
    a,b,c = theta; t = years - years[0]; dt = np.diff(t, prepend=t[0])
    phi = np.zeros_like(t, dtype=float); phi[0]=phi0
    for k in range(1,len(t)):
        phi[k]=phi[k-1]+dt[k]*(-a*phi[k-1]+b-c*(phi[k-1]**3))
    return phi

def random_search_fit(years, phi, n_iter=2000, seed=0):
    rng=np.random.default_rng(seed); best=None; phi0=phi[0]
    for _ in range(n_iter):
        th=np.array([rng.uniform(0,0.2), rng.uniform(0,0.1), rng.uniform(0,1.0)])
        pred=forward_model(years, th, phi0)
        rss=float(np.sum((pred-phi)**2)); ss=float(np.sum((phi-phi.mean())**2))
        r2=1.0-rss/ss if ss>0 else 0.0
        if (best is None) or (rss<best.rss):
            best=FitResult(params={'a':th[0],'b':th[1],'c':th[2]}, rss=rss, r2=r2, preds=pred)
    return best

def estimate_exponent_autocorr(phi_series: np.ndarray, max_lag: int = 10):
    phi=phi_series-phi_series.mean(); ac=[]
    for k in range(0, max_lag+1):
        x=phi[:-k] if k>0 else phi; y=phi[k:]
        ac.append(float(np.dot(x,y)))
    ac=np.array(ac); ac/= (ac[0]+1e-12); t=np.arange(len(ac))+1.0
    m = (np.polyfit(np.log(t[2:]), np.log(np.clip(ac[2:],1e-12,1.0)), 1)[0])
    z = -1.0/(m+1.0) if m>-0.99 else np.nan
    return float(z)

if __name__=='__main__':
    y,phi=load_trust_timeseries('data/trust_timeseries.csv')
    res=random_search_fit(y,phi,1000,1)
    print('params',res.params,'R2',round(res.r2,3),'z~',estimate_exponent_autocorr(res.preds,6))
