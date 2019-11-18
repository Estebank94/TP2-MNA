function v = LieTrotterL(dt, v, x)
  v = Lineal(dt, v, x);
  v = NonLineal(dt, v, x);
end

function v = LieTrotterNL(dt, v, x)
  v = NonLineal(dt, v, x);
  v = Lineal(dt, v, x);
end

function U = Lineal(delta_t, U, k)
  U = U.*exp(1i*k.^3*delta_t);
end

function U = NonLineal(delta_t, U, k)
  U = U  - (3i*k*delta_t).*dft((real(idft(U))).^2);
end
