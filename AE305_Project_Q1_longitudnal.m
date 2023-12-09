W = [4600*32.17 636636]; %in lbf
S = 175; % in sq.ft
c = 4.79; % in ft
alpha = 5.7; %degrees
rho = 0.076;
CTx = 0.031;

g = 32.17; %ft/s^2
Iy = 1939*g; %lb-ft^2
    
C_D = [0.102 0.0393]; %Cd at sea level and 20000ft
C_D_alpha = 0.16;
C_D_M = 0.0;

q = [500/(CTx*S) 0 ];
M_inf = [0.25 0.5]; %M_inf at sea level and 20000ft
u_o = [sqrt(2*q(1)/rho) 0 ]



% C_L = [1.11 0.680];
C_L_o  = 0.288;
C_L_alpha = 4.58;
C_L_alpha_dot = 5.3;
C_L_q= 9.7;
C_L_M = 0.0;
C_L_delE = 0.81;
C_L = [W/(q(1)*S) 0 ];
C_D = [(500+500)/(q(1)*S) 0 ];

C_L = [W/(q(1)*S) 0];

C_m_alpha = -0.137;
C_m_alpha_dot = -12.7;
C_m_q = -26.3;
C_m_delE = -2.26;
C_m_M = 0;





Xu = -(2*C_D(1))*q(1)*S/(W(1)*u_o(1));
Xw = q(1)*S*(C_L(1) - C_D_alpha)/(W(1)*u_o(1));

Zu = -(2*C_L(1) + M_inf(1)*C_L_M)*q(1)*S/(W(1)*u_o(1));
Zw = -q(1)*S*(C_D(1)+C_L_alpha)/(W(1)*u_o(1));
Zq = -(C_L_q)*q(1)*S*c/(2*(W(1)*u_o(1)));
Zdw = 0; % as per nelson

Mw = q(1)*S*c*(C_m_alpha)/(Iy*u_o(1));
Mdw = C_m_alpha_dot*c*c*q(1)*S/(2*Iy*u_o(1)*u_o(1))
Mu = q(1)*S*c*(M_inf(1)*C_m_M)/(Iy*u_o(1));
Mq = q(1)*S*c^2*C_m_q/(2*(Iy*u_o(1)));
M_delE = q(1)*S*c*C_m_delE/Iy;

a31 = Mu(1) + Mdw(1)*Zu;
a32 = Mw+Mdw*Zw;
a33 = Mq+Mdw*u_o(1);

Z_delE = -q(1)*S*C_L_delE/W(1);
M_delE_star = M_delE + Mdw * Z_delE;

A = [Xu Xw 0 -g; Zu Zw u_o(1) 0; a31 a32 a33 0; 0 0 1 0]

% Considering the only control input is delta_e, due to elevators
B = [0 0; Z_delE 0 ; M_delE_star 0; 0 0]


% For trim conditions, X = -inv(A)*B*{control input matrix(1x1), i.e. [delE]}
coeff_trim_longitudinal = -inv(A)*B

%Jacobian Matrix is A itself.
%now finding eigenvalues and eigenvectors

e = eig(A)
[V,D] = eig(A);

V