function U = non_linear(delta_t, U, k)
  U = U  - (3i*k*delta_t).*fft((real(ifft(U))).^2);
end
