function y = idft(x,N)
  L=length(x);
  y=[ ]; % matriz vacia
  k=0:L -1;
  for m=0:N-1
    b=exp((1i*2*k*m*pi)/N);
    s=sum(x.*b)./N;
    y=[y s];
  endfor
endfunction
