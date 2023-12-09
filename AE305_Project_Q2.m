A = [  -0.0003    0.0200         0  -32.1700;
   -0.0406   -0.0103   49.2485         0;
    0.0006   -0.0033   -2.3490         0;
         0         0    1.0000         0;];

B = [0         0;
   -0.0883         0;
   -2.7978         0;
         0         0;];

C = [ 1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1;];

D = [ 0 0 ;0 0 ;0 0 ;0 0 ];
s = tf('s');
sys = ss(A,B,C,D);
sys_as_tf = tf(sys)
a = sys_as_tf(1, 1)
b = sys_as_tf(2, 1)
c = sys_as_tf(3, 1)
d = sys_as_tf(4, 1)

delE = 1*pi/180;
V_inf = 49.2485; %u_o taken from other file
t = 10;%second, short term


opt = stepDataOptions('StepAmplitude',delE);

[u,tOut]=step(a, t, opt);

w = step(b, tOut, opt);
theta = step(d, tOut, opt);

alpha = atan((w./(u+V_inf))*180/pi);
gamma = theta - alpha;


plot(tOut, u)
title('Short term (10 sec) Step Response for \Deltau')
xlabel('Time (sec)') 
ylabel('\Deltau') 
figure(2)
plot(tOut, alpha)
title('Short term (10 sec) Step Response for \Delta\alpha')
xlabel('Time (sec)') 
ylabel('\Delta\alpha') 
figure(3)
plot(tOut, gamma)
title('Short term (10 sec) Step Response \Delta\gamma')
xlabel('Time (sec)') 
ylabel('\Delta\gamma') 

%long term response
t = 600;%second

opt = stepDataOptions('StepAmplitude',delE);
[u,tOut]=step(a, t, opt);
w = step(b, tOut, opt);
theta = step(d, tOut, opt);

alpha = (w./(u+V_inf))*180/pi;
gamma = theta - alpha;

figure(4)
plot(tOut, u)
title('Long term (10 min) Step Response \Deltau')
xlabel('Time (sec)') 
ylabel('\Deltau')
figure(5)
plot(tOut, alpha)
title('Long term (10 min) Step Response \Delta\alpha')
xlabel('Time (sec)') 
ylabel('\Delta\alpha')
figure(6)
plot(tOut, gamma)
title('Long term (10 min) Step Response \Delta\gamma')
xlabel('Time (sec)') 
ylabel('\Delta\gamma')
