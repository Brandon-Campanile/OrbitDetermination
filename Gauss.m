%% Gauss Problem:
% =========================================================================
%   Given r_initial, r_final, and time-of-flight determine the orbital
%   elements of a satellite.

function Gauss()
clear; clc; close all
%% Usage:
%
%
%
%% Results:
%
%   There exist two solutions to the Gauss/Lambert problem named the "long
%   way" where delta_nu > pi and the "short way" where delta_nu < pi.
% 
%   Note:
%   - If r_initial and r_final are colinear AND opposite (delta_nu = pi radians)
%   a unique solution does NOT exist. This is because the vectors r_initial
%   and r_final do not define a plane in this case. 
%   - If r_initial and r_final are colinear (delta_nu = 0,2*pi radians) the
%   solution is a degenerative conic (down r_initial to the focus then back
%   up r_final) but a solution exists (equations need modification as 'p'
%   in denominator results in a singularity).
%
%% Iteration Method:
%
%   This code utilizes the "p-iteration" method where a guess of "p" is made
%   and the semi-major axis and change in mean anomaly are calculated.
%  
%   This iteration method was chosen as it allows for the formulation of an
%   analytical expression for dt/dp, meaning a Newton iteration method can
%   be used for faster convergence, resulting in the direct manipulation of "p".
%
%   Looking at the graph of t vs p, the "long way" goes from the origin to 
%   an asymptote where t->inf, caused by it becoming a parabola (delta_E=0)
%   at p_ii. The "short way" goes from a parabola at p_i where t->inf to
%   p->inf where t approaches 0 (p_i < p_ii). Our starting value of p should
%   be between p_i and p_ii. The minimum of this graph between p_i and p_ii
%   corresponds to a_min, the "minimum energy ellipse".
%
%% Algorithm:
%
%   Step 1: Evaluate the constants k, l, and m from r_i, r_f, and delta_nu
%    using equations (1), (2), and (3).
%   Step 2: Determine the limits on the possible values of p by evaluating
%    p_i and p_ii from equations (4) and (5).
%   Step 3: Pick a trial value of p within the limits p_i and p_ii
%   Step 4: Using the trial value of p, solve for 'a' from equation (6). The
%    type of conic can be determined from the value of 'a'. Elliptic if 0<a<inf,
%    hyperbolic if -inf<a<0, parabolic if a->+/-inf.
%   Step 5: Solve for f, g, and f' from equations (7), (8), and (9).
%   Step 6: Solve for delta_E or delta_F using equations (10) and (11) for
%    delta_E or equation (12) for delta_F if a<0. You need two equations
%    for delta_E to determine its sign.
%   Step 7: Solve for t from equation (13) or, if a<0,(14) and compare it
%    with the desired time-of-flight.
%   Step 8: Adjust the trial value of p using the Newton iteration method
%    until the desired time-of-flight is reached.
%      Step 8.1: Solve for the derivative dt/dp from equation (15) or, if
%       hyperbolic, (16) using the intermediary iteration values.
%      Step 8.2: Solve for the adjusted value of p using equation (17)
%   Step 9: Evaluate g' from equation (18) then solve for v_i and v_f using
%   equations (19) and (20).
%   Step 10: Calculate orbital elements from position and velocity vectors.
%      Step 10.1: p=h^2/mu
%      Step 10.2: e=1/mu*((v^2-mu/r).*r - dot(r,v)*v)
%      Step 10.3: cos(i)=h_k/h        always less than 180 deg
%      Step 10.4: cos(Omega)=n_I/n    if n_J>0, Omega<180 deg
%      Step 10.5: cos(om)=dot(n,e)/(norm(n)*norm(e)) if e_k>0, om<180 deg
%      Step 10.6: cos(nu)= dot(e,r)/(norm(e)*norm(r)) if dot(r,v)>0, nu<180 deg
%      Step 10.7: cos(u)=dot(n,r)/(norm(n)*norm(r))  if r_k>0, u<180 deg
%      Step 10.8: l=Omega+om+nu=Omega+u
%      Step 10.9: h=cross(r,v)
%      Step 10.10: n=cross(k,h)
%
%% Constants & Variables:
%   
%   delta_nu = 'long way': largest angle between r_i and r_f; 'short way':
%   smallest angle between r_i and r_f.
%   
%
%% Equations:
%   
%   (1): k=r_i*r_f*(1-cos(delta_nu))
%   (2): l=r_i+r_f
%   (3): m=r_i*r_f*(1+cos(delta_nu))
%   (4): p_i=k/(l+sqrt(2*m))
%   (5): p_ii=k/(1-sqrt(2*m))
%   (6): a= m*k*p/((2*m-l^2)*p^2+2*k*l*p-k^2)
%   (7): f=1-r_f/p*(1-cos(delta_nu))=1-a/r_i*(1-cos(delta_E))
%   (8): g=r_i*r_f*sin(delta_nu)/sqrt(mu*p)=t-sqrt(a^3/mu)*(delta_E - sin(delta_E))
%   (9): f'=sqrt(mu/p)*tan(delta_nu/2)*((1-cos(delta_nu))/p-1/r_i-1/r_f)=-sqrt(mu*a)/(r_i*r_f)*sin(delta_nu)
%  (10): cos(delta_E)=1-r_i/a*(1-f)
%  (11): sin(delta_E)=-r_i*r_f*f'/sqrt(mu*a)
%  (12): cosh(delta_F)=1-r_i/a*(1-f)
%  (13): t=g+sqrt(a^3/mu)*(delta_E-sin(delta_E))
%  (14): t=g+sqrt((-a)^3/mu)*(sinh(delta_F)-delta_F)
%  (15): dt/dp=-g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))+sqrt(a^3/mu)*(2*k*sin(delta_E)/(p*(k-l*p)))
%  (16): dt/dp=-g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))-sqrt((-a)^3/mu)*(2*k*sinh(delta_F)/(p*(k-l*p)))
%  (17): p_(n+1)=p_n+(t_desired-t_n)/(dt/dp_n)
%  (18): g'=1-r_i/p*(1-cos(delta_nu))=1-a/r_f*(1-cos(delta_E))
%  (19): v_i=(r_f-f*r_i)/g
%  (20): v_f=f'*r_i+g'*v_i
%
%% Initialize

%% Limits of P and initial Value

%% P-Iteration Method

%% Calculate Orbital Elements

%% Plot


end