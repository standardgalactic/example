# stochastic_langevin.py — Langevin SPDE extension
from __future__ import annotations
from dataclasses import dataclass
import numpy as np
from .field_solver import Params, laplacian_periodic, gradient_periodic

@dataclass
class NoiseParams(Params):
    sigma_phi: float = 0.05
    sigma_s: float = 0.02
    seed: int | None = None

def simulate_stochastic(p: NoiseParams):
    rng = np.random.default_rng(p.seed)
    N, L = p.N, p.L
    dx = L/N
    dt = min(0.05, p.cfl*dx*dx/max(p.lam, p.nu, 1e-6))
    steps = int(p.T/dt)+1
    x = np.linspace(0, L, N, endpoint=False)
    phi = 0.1*np.cos(2*np.pi*x/L) + 0.02*rng.standard_normal(N)
    v   = 0.05*np.sin(4*np.pi*x/L)
    s   = 0.2 + 0.01*rng.standard_normal(N)
    Tlist, Plist, Vlist, Slist = [], [], [], []
    for n in range(steps):
        if n % p.save_every == 0 or n == steps-1:
            Tlist.append(n*dt); Plist.append(phi.copy()); Vlist.append(v.copy()); Slist.append(s.copy())
        d2phi = laplacian_periodic(phi, dx)
        d2v   = laplacian_periodic(v, dx)
        dphi  = gradient_periodic(phi, dx)
        dv    = gradient_periodic(v, dx)
        rhs_phi = p.lam*d2phi - p.gam*phi - p.chi*s + p.eta
        rhs_v   = p.nu*d2v   - p.mu*v   - dphi
        sigma   = p.k1*(dphi**2) + p.k2*(dv**2)
        rhs_s   = sigma - p.eta
        xi_phi = rng.standard_normal(N) * (2.0*dt)**0.5 / (dx**0.5)
        xi_s   = rng.standard_normal(N) * (2.0*dt)**0.5 / (dx**0.5)
        phi += dt*rhs_phi + p.sigma_phi*xi_phi
        v   += dt*rhs_v
        s   += dt*rhs_s + p.sigma_s*xi_s
    return {
        't': np.array(Tlist),
        'phi': np.stack(Plist),
        'v': np.stack(Vlist),
        's': np.stack(Slist),
    }
