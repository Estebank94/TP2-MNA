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
