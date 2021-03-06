
%%%%%% Specify Motor Parameters %%%%%%
%%%%%% Edit these parameters %%%%%%
%%% Flux Linkage, Wb %%%
k1 = 0.023; %%harmonic coefficients
k3 = .00;
k5 = -.00;
k7 = 0;
k9 = 0.000; 
%%% pm flux linked by rotor at angle theta_r to phase at angle theta_p %%%
wb_r = @(theta_r, theta_p, i) k1*cos(theta_p - theta_r) + k3*cos(3*(-theta_r) +theta_p) + k5*cos(5*(-theta_r)+theta_p) + k9*cos(9*(-theta_r) + theta_p);

%%% Phase Resistances %%%
r_a = .25;
r_b = .25;
r_c = .25;

%%% Termination Type: wye, delta, ind %%%
termination = 'wye';

%%% Pole Pairs %%%
npp = 13;

%%% Inductances %%%
l_d = .0005;     %D-Axis Inductance
l_q = .0005;      %Q-Axis Inductance
l_m =  .00;    %Phase Mutual Inductance, assuming a constant for now


%%%%% Automatic Setup %%%%%
%%%%% Don't change unless you know what you're doing %%%%%
%%% Resistance Matrix %%%
R = [r_a 0 0; 
    0 r_b 0; 
    0 0 r_c];

%%% Phase Self Inductance %%%
l_p = @(theta_r, theta_p) .5*(l_d - l_q)*(cos(2*(theta_p - theta_r)))+(l_d + l_q)/2;

%%% Inductance Matrix %%% 
L = @(theta_r, id, iq) [l_p(theta_r, 0), l_m, l_m; l_m, l_p(theta_r, 2*pi/3), l_m; l_m, l_m, l_p(theta_r, -2*pi/3)];

%%% Flux Linkage Matrix %%%
Wb = @(theta_r, i, id, iq) [L(theta_r)]*i + [wb_r(theta_r, 0); wb_r(theta_r, 2*pi/3); wb_r(theta_r, -2*pi/3)];

