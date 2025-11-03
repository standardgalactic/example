# field_solver.py — RSVP 1D reference solver (periodic)
from __future__ import annotations
from dataclasses import dataclass
import numpy as np

@dataclass
class Params:
    L: float = 1.0
    N: int = 256
    T: float = 10.0
    save_every: int = 50
    lam: float = 1.0   # Φ diffusion
    gam: float = 0.2   # Φ damping
    chi: float = 0.1   # S→Φ coupling
    eta: float = 0.02  # negentropy injection
    nu: float = 0.5    # v diffusion
    mu: float = 0.3    # v damping
    k1: float = 0.8    # entropy prod from |∂xΦ|^2
    k2: float = 0.4    # entropy prod from |∂xv|^2
    cfl: float = 0.2

def laplacian_periodic(u: np.ndarray, dx: float) -> np.ndarray:
    return (np.roll(u,-1) - 2.0*u + np.roll(u,1)) / (dx*dx)

def gradient_periodic(u: np.ndarray, dx: float) -> np.ndarray:
    return (np.roll(u,-1) - np.roll(u,1)) / (2.0*dx)

def simulate(params: Params, phi0=None, v0=None, s0=None, seed: int|None=None):
    rng = np.random.default_rng(seed)
    N, L = params.N, params.L
    dx = L/N
    dt = min(0.05, params.cfl*dx*dx/max(params.lam, params.nu, 1e-6))
    steps = int(params.T/dt)+1
    x = np.linspace(0, L, N, endpoint=False)
    phi = (0.1*np.cos(2*np.pi*x/L) + 0.02*rng.standard_normal(N)) if phi0 is None else phi0.astype(float).copy()
    v   = (0.05*np.sin(4*np.pi*x/L)) if v0 is None else v0.astype(float).copy()
    s   = (0.2 + 0.01*rng.standard_normal(N)) if s0 is None else s0.astype(float).copy()
    Tlist, Plist, Vlist, Slist = [], [], [], []
    for n in range(steps):
        if n % params.save_every == 0 or n == steps-1:
            Tlist.append(n*dt); Plist.append(phi.copy()); Vlist.append(v.copy()); Slist.append(s.copy())
        d2phi = laplacian_periodic(phi, dx)
        d2v   = laplacian_periodic(v, dx)
        dphi  = gradient_periodic(phi, dx)
        dv    = gradient_periodic(v, dx)
        rhs_phi = params.lam*d2phi - params.gam*phi - params.chi*s + params.eta
        rhs_v   = params.nu*d2v   - params.mu*v   - dphi
        sigma   = params.k1*(dphi**2) + params.k2*(dv**2)
        rhs_s   = sigma - params.eta
        phi += dt*rhs_phi
        v   += dt*rhs_v
        s   += dt*rhs_s
    return (np.array(Tlist), np.stack(Plist), np.stack(Vlist), np.stack(Slist))

def demo():
    p = Params(T=5.0, N=128)
    t, Phi, V, S = simulate(p, seed=0)
    print('snapshots', Phi.shape[0], 'Phi range', float(Phi.min()), float(Phi.max()))
    return t, Phi, V, S

if __name__ == '__main__':
    demo()
