function V = phi_lie_trotter(delta_t, U, k, m, positive, count)
  h = delta_t / m;
  if positive
    V = non_linear(h, linear(h, U, k), k);
  else
    V = linear(h, non_linear(h, U, k), k);
  end

  if count ~= 1
    V = phi_lie_trotter(delta_t, V, k, m, positive, count-1);
  end

end

function Y = phi_strang(delta_t, U, k, m, positive, count)
  h = delta_t / m;
  if is_plus
    Y = linear(h/2, linear(h, linear(h/2, U, k), k), k);
  else
    Y = linear(h/2, non_linear(h, linear(h/2, U, k), k), k);
  end

  if count ~= 1
    Y = phi_strang(delta_t, Y, k, m, is_plus, count-1);
  end

endt

function U = linear(delta_t, U, k)
  U = U.*exp(1i*k.^3*delta_t);
end

function U = non_linear(delta_t, U, k)
  U = U  - (3i*k*delta_t).*dft((real(idft(U))).^2);
end
