# tests — basic checks
import numpy as np
from src.field_solver import Params, simulate, gradient_periodic

def test_entropy_nonneg():
    p=Params(T=0.2,N=128,eta=0.0)
    t,Phi,V,S=simulate(p,seed=0)
    dx=p.L/p.N; dphi=gradient_periodic(Phi[-1],dx); dv=gradient_periodic(V[-1],dx)
    sigma=p.k1*(dphi**2)+p.k2*(dv**2)
    assert np.all(sigma>=-1e-10)

def test_energy_decay_damped():
    p=Params(T=1.0,N=128,eta=0.0,chi=0.0,k1=0.0,k2=0.0)
    t,Phi,V,S=simulate(p,seed=1)
    E0=float(np.mean(Phi[0]**2+V[0]**2+S[0]**2))
    E1=float(np.mean(Phi[-1]**2+V[-1]**2+S[-1]**2))
    assert E1<=E0+1e-6

if __name__=='__main__':
    test_entropy_nonneg(); test_energy_decay_damped(); print('ok')
