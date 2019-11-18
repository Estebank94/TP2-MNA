function Y = phi_strang(delta_t, U, k, m, positive, count)
  h = delta_t / m;
  if positive
    Y = linear(h/2, linear(h, linear(h/2, U, k), k), k);
  else
    Y = linear(h/2, non_linear(h, linear(h/2, U, k), k), k);
  end

  if count ~= 1
    Y = phi_strang(delta_t, Y, k, m, positive, count-1);
  end

end
