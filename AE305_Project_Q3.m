A =[-0.0131   -0.0488  -49.1258   32.1700;
   -0.1496  -13.8784    1.8362         0;
    0.1592   -0.5228   -3.0409         0;
         0    1.0000         0         0;];

B = [0    0.2123;
  -11.5642    1.2909;
    0.9122   -6.2548;
         0         0;];

C = [ 1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1;];

D = [ 0 0 ;
    0 0 ;
    0 0 ;
    0 0 ];

s = tf('s');
sys = ss(A,B,C,D);
sys_as_tf = tf(sys)
a = sys_as_tf(1, 1)
b = sys_as_tf(2, 1)
c = sys_as_tf(3, 1)
d = sys_as_tf(4, 1)

e = sys_as_tf(1, 2)
f = sys_as_tf(2, 2)
g = sys_as_tf(3, 2)
h = sys_as_tf(4, 2)



delA = -15*pi/180;

t = 20;%second, short term
V_inf = 49.2485; 
opt = stepDataOptions('StepAmplitude',delA);


[v,tOutput] = step(a, t, opt);
u = V_inf*[ones(size(v))];
w = [zeros(size(v))];
q = [zeros(size(v))];
theta = [zeros(size(v))];
p = step(b, tOutput, opt);
r = step(c, tOutput, opt);
phi = step(d, tOutput, opt);

psi = cumsum(r);



figure(1)
plot(tOutput, u);
title('Step Response for \Deltau');
xlabel('Time (sec)') 
ylabel('\Deltau') 


figure(2)
plot(tOutput, v);
title('Step Response for \Deltav');
xlabel('Time (sec)') 
ylabel('\Deltav') 

figure(3)
plot(tOutput, w);
title('Step Response for \Deltaw');
xlabel('Time (sec)') 
ylabel('\Deltaw')

figure(4)
plot(tOutput, p);
title('Step Response for p');
xlabel('Time (sec)') 
ylabel('p') 

figure(5)
plot(tOutput, q);
title('Step Response for q');
xlabel('Time (sec)') 
ylabel('q')

figure(6)
plot(tOutput, r);
title('Step Response for r');
xlabel('Time (sec)') 
ylabel('r') 

figure(7)
plot(tOutput, phi);
title('Step Response for \phi');
xlabel('Time (sec)') 
ylabel('\phi')

figure(8)
plot(tOutput, theta);
title('Step Response for \theta');
xlabel('Time (sec)') 
ylabel('\theta') 

figure(9)
plot(tOutput, psi);
title('Step Response for \psi');
xlabel('Time (sec)') 
ylabel('\psi')


