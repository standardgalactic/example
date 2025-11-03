# network_rg.py — Network renormalization (NumPy)
import numpy as np

def laplacian(A: np.ndarray) -> np.ndarray:
    d = np.sum(A, axis=1)
    return np.diag(d) - A

def lambda2(L: np.ndarray) -> float:
    w = np.linalg.eigvalsh(L)
    w = np.sort(w)
    return float(w[1]) if len(w) > 1 else 0.0

def aggregate(L: np.ndarray, groups: np.ndarray) -> np.ndarray:
    n = L.shape[0]
    g = groups.astype(int)
    G = g.max()+1
    P = np.zeros((n,G)); P[np.arange(n), g] = 1.0
    Lp = P.T @ L @ P
    sizes = P.sum(axis=0)
    S = np.diag(np.where(sizes>0, 1.0/sizes, 0.0))
    Lc = S @ Lp @ S
    return 0.5*(Lc+Lc.T)

def spectral_dimension(L: np.ndarray, t_min=1e-3, t_max=1e1, num=20) -> float:
    w = np.linalg.eigvalsh(L); w = w[w>1e-12]
    ts = np.logspace(np.log10(t_min), np.log10(t_max), num=num)
    K = np.array([np.sum(np.exp(-t*w)) for t in ts])
    logt, logK = np.log(ts), np.log(K+1e-15)
    m = num//3; a = np.polyfit(logt[m:-m], logK[m:-m], 1)[0]
    ds = -2.0*a
    return float(max(ds,0.0))

def one_step_nrg(L: np.ndarray, r: float, u: float, g_cpl: float, groups: np.ndarray):
    Lc = aggregate(L, groups)
    n = L.shape[0]
    shift = r + 1e-6
    try:
        G = np.linalg.inv(shift*np.eye(n) + L)
        mu2 = np.trace(G)/n; mu4 = np.trace(G@G)/n
    except np.linalg.LinAlgError:
        mu2 = 0.0; mu4 = 0.0
    Xi_v = 0.1*mu2; Psi_v = 0.1*mu2
    r_p = r + 0.5*u*mu2 - (g_cpl**2)*Xi_v
    u_p = u - 1.5*(u**2)*mu4
    g_p = g_cpl - g_cpl*u*mu2 - g_cpl*Psi_v
    return Lc, float(r_p), float(u_p), float(g_p)

if __name__ == '__main__':
    n=16; A=np.zeros((n,n));
    for i in range(n): A[i,(i+1)%n]=A[(i+1)%n,i]=1
    L=laplacian(A); groups=(np.arange(n)//2)
    Lc,rp,up,gp=one_step_nrg(L,0.2,0.1,0.3,groups)
    print('lambda2', lambda2(L), 'ds', spectral_dimension(L), 'Lc', Lc.shape)
