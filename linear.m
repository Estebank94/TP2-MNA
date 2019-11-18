function U = linear(delta_t, U, k)
  U = U.*exp(1i*k.^3*delta_t);
end
