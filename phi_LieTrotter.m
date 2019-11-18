function V = phi_LieTrotter(delta_t, U, k, m, positive, count)
  h = delta_t / m;
  if positive
    V = nonLinear(h, linear(h, U, k), k);
  else
    V = linear(h, nonLinear(h, U, k), k);
  end

  if count ~= 1
    V = phi_LieTrotter(delta_t, V, k, m, positive, count-1);
  end

end

function U = linear(delta_t, U, k)
  U = U.*exp(1i*k.^3*delta_t);
end

function U = nonLinear(delta_t, U, k)
  U = U  - (3i*k*delta_t).*dft((real(idft(U))).^2);
end
