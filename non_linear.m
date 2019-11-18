function U = non_linear(delta_t, U, k)
  U = U  - (3i*k*delta_t).*dft((real(idft(U))).^2);
end
