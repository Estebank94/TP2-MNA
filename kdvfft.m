%lie trotter
%Kdv Dos_solitones

clear all
clc
set(gca,'FontSize',8)
set(gca,'LineWidth',2)

q = 0;
while q <= 0 || mod(q,2) > 0
    msg = 'Ingresar el orden (debe ser un número par > 0): ';
    q = input(msg);
end
s = q/2;

integrators = {@phi_LieTrotter}; %TODO add strang
integrator_method = 0;
while integrator_method <= 0 || integrator_method > 2
    prompt = 'Seleccionar un método (1: Lie-Trotter, 2: Strang): ';
    integrator_method = input(prompt);
end
integrator = integrators{integrator_method};

N = 256;
x = linspace(-10,10,N);
delta_x = x(2) - x(1);
delta_k = 2*pi/(N*delta_x);

k = [0:delta_k:(N/2-1)*delta_k,0,-(N/2-1)*delta_k:delta_k:-delta_k];
c_1=13;
c_2 =3;

u = 1/2*c_1*(sech(sqrt(c_1)*(x+8)/2)).^2 + 1/2*c_2*(sech(sqrt(c_2)*(x+1)/2)).^2;

delta_t = 0.4/N^2;
t=0;
plot(x,u,'LineWidth',2)
axis([-10 10 0 10])
xlabel('x')
ylabel('u')
text(6,9,['t = ',num2str(t,'%1.2f')],'FontSize',14)
drawnow

tmax = 1.5; nplt = floor((tmax/100)/delta_t); nmax = round(tmax/delta_t);
udata = u.'; tdata = 0;
U = fft(u);

gammas = {[0.5]; [-1/16, 9/16]; [1/144, -8/63, 625/1008]; [-1/2304, 32/675, -729/3200, 117649/172800]};

for n = 1:nmax-40000
    t = n*delta_t;

    U_aux = zeros(1, N);
    gamma = gammas{s};
    for m = 1:s
      phi_positive = integrator(U, k, delta_t, m, true, m);
      phi_negative = integrator(U, k, delta_t, m, false, m);

      % integrador simetrico
      U_aux = U_aux + gamma(m) * (phi_positive + phi_negative);
    end
    U = U_aux;
    if mod(n,nplt) == 0
        u = real(ifft(U));
        udata = [udata u.']; tdata = [tdata t];
        if mod(n,4*nplt) == 0
            plot(x,u,'LineWidth',2)
            axis([-10 10 0 10])
            xlabel('x')
            ylabel('u')
            text(6,9,['t = ',num2str(t,'%1.2f')],'FontSize',10)
            drawnow
        end
    end
end

figure

waterfall(x,tdata(1:4:end),udata(:,1:4:end)')
xlabel x, ylabel t, axis([-10 10 0 tmax 0 10]), grid off
zlabel u
