C_y_beta = -0.698;
C_y_p = -0.141;
C_y_r = 0.355;
C_l_beta = -0.1096;
C_n_beta = 0.1444;
C_l_p = -0.551;
C_n_p = -0.0257;
C_l_r = 0.0729;
C_n_r = -0.1495;
C_l_delA = -0.172;
C_n_delA = 0.0168;
C_y_delR = 0.23;
C_l_delR = 0.0192;
C_n_delR = -0.1152;
CTx = 0.031;

g = 32.17;
Ix = 8884*g; % in lb-ft^2
Iz = 11001*g; % in lb-ft^2
Ixz = 0; % in lb-ft^2
I = Ix*Iz/(Ix*Iz - Ixz^2);
I2 = Ixz/Ix;
W = 564032; %lbf
alpha = 5.7; %in degrees
M_inf = 0.25;
rho = 0.076;
q = 500/(CTx*S);
S = 5650; 
c = 30;
b = 36.9; %in ft.
u_o = sqrt(2*q(1)/rho);

Y_beta = q*S*C_y_beta/W;
Y_p = q*S*b*C_y_p/(2*W*u_o);
Y_r = q*S*b*C_y_r/(2*W*u_o);
L_beta = q*S*b*C_l_beta/Ix;
L_p = q*S*b*b*C_l_p/2/Ix/u_o;
L_r = C_l_r*q*S*b*b/2/Ix/u_o;
N_beta = q*S*b*C_n_beta/Iz;
N_p = q*S*b*b*C_n_p/2/Iz/u_o;
N_r = q*S*b*b*C_n_r/(2*Iz*u_o);
Y_v = q*S*C_y_beta/W/u_o;
L_v = q*S*b*C_l_beta/(Ix*u_o);
N_v = q*S*b/Iz/u_o*C_n_beta;
A21 = I*(L_v + I2*N_v);
A22 = I*(L_p + I2*N_p);
A23 = I*(L_r + I2*N_r);
A31 = I*(N_v + I2*L_v);
A32 = I*(N_p + I2*L_p);
A33 = I*(N_r + I2*L_r);

Y_delR = q*S*C_y_delR/W;
N_delR = q*S*b*C_n_delR/Iz;
N_delA = q*S*b*C_n_delA/Iz;
L_delA = q*S*b*C_l_delA/Ix;
L_delR = q*S*b*C_l_delR/Ix;

B21 = I*(L_delA +I2*N_delA);
B22 = I*(L_delR +I2*N_delR);
B31 = I*(N_delA +I2*L_delA);
B32 = I*(N_delR +I2*L_delR);


A = [Y_v Y_p -(u_o-Y_r) g;
    A21 A22 A23 0;
    A31 A32 A33 0;
    0 1 0 0]
B = [0 Y_delR; 
     B21 B22;
     B31 B32;
      0 0]

% For trim conditions, X = -inv(A)*B*{control input matrix(2x1), i.e. [delA
% delR]}

coeff_trim_lateral = -inv(A)*B

%Jacobian Matrix is A itself.
%now finding eigenvalues and eigenvectors
e = eig(A)
[V,D] = eig(A);

V