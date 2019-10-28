%% Gauss Problem:
% =========================================================================
%   Given r_initial, r_final, and time-of-flight determine the orbital
%   elements of a satellite.

function Gauss(r_i, r_f, start_date, end_date, orbBody, tol, iter)
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
%   dates = 
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
%% Initialize:

start_date = datetime(start_date, 'Format','dd-MMM-yyyy HH:mm:ss:SSS');
end_date = datetime(end_date, 'Format','dd-MMM-yyyy HH:mm:ss:SSS');
tof = milliseconds(end_date-start_date)/1000; % milliseconds will increase accuracy as the seconds function would round the result

T=readtable('constants.xlsx', 'ReadVariableNames', true, 'ReadRowNames', true);

DU=T.(orbBody)('DU (m)'); % meters (1 AU if heliocentric)
r_i = r_i./DU; % first position in distance units
r_f = r_f./DU; % second position in distance units
mu = T.(orbBody)('Gravitational Constant (m3/s2)'); % m^3/s^2 gravitational constant of central body
TU = sqrt(DU^3/mu); % Time unit for heliocentric orbit
delta_nu_short = acos(dot(r_i,r_f)/(norm(r_i)*norm(r_f))); % Find angle between two vectors
delta_nu_long = 2*pi-delta_nu_short;
tof = tof/TU;
x=floor(iter); % number of iteration to attempt
long = p_iter(delta_nu_long);
short = p_iter(delta_nu_short);
SemiMajorAxis = [short(1); long(1)];
Eccentricity = [short(2); long(2)];
Inclination = [short(3); long(3)];
LongitudeoftheAscendingNode = [short(4); long(4)];
ArgumentofPeriapsis = [short(5); long(5)];
OE = table(SemiMajorAxis, Eccentricity, Inclination, LongitudeoftheAscendingNode, ArgumentofPeriapsis, 'RowNames', {'Short Way','Long Way'});

writetable(OE,'OrbitalElements.xlsx','WriteRowNames',true)  
%% P-Iteration Method:
    function out = p_iter(delta_nu)
    %% Determine Initial Value of P:
        k = norm(r_i)*norm(r_f)*(1-cos(delta_nu));     % k, l, & m are intermediary values for calculation with no physical representation
        l = norm(r_i)+norm(r_f);
        m = norm(r_i)*norm(r_f)*(1+cos(delta_nu));
        
        p_i = k/(l+sqrt(2*m));   % lower bound of p for the "short way" below which there is no solution (open end of parabola at p_i and open end of hyperbola at p<p_i) if p->inf, tof->0 and is the straight line solution
        p_ii = k/(1-sqrt(2*m));  % upper bound of p for the "long way" above which there is no solution (open end of parabola at p_ii and open end of hyperbola at p>p_ii) as p->0, tof->0 and is degenerate hyperbola (travel along r_i to focus then along r_f)
        p = (p_i+p_ii)/2;      % Choose average value between p_i and p_ii as an initial starting value as it is guaranteed to have a solution
        i = 0;
        
    %% Iteration
        while i<=x
            a = m*k*p/((2*m-l^2)*p^2+2*k*l*p-k^2); % Elliptic if 0<a<inf, hyperbolic if -inf<a<0, parabolic if a->+/-inf
            f = 1-norm(r_f)/p*(1-cos(delta_nu));
            g = norm(r_i)*norm(r_f)*sin(delta_nu)/sqrt(p);
            f_dot = -sqrt(a)/(norm(r_i)*norm(r_f))*sin(delta_nu);
            
            if a<0 % hyperbolic
                delta_F = acosh(1-norm(r_i)/a*(1-f));
                t_n = g+sqrt((-a)^3)*(sinh(delta_F)-delta_F);
                dtdp = -g/(2*p)-3/2*a*(t_n-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))-sqrt((-a)^3)*(2*k*sinh(delta_F)/(p*(k-l*p)));
            else % elliptic (parabolic?)
                d_E_cos = 1-norm(r_i)/a*(1-f);
                d_E_sin = -norm(r_i)*norm(r_f)*f_dot/sqrt(a);
                delta_E = atan(d_E_sin/d_E_cos);
                if d_E_cos<0
                    delta_E = pi+delta_E;
                end
                t_n = g+sqrt(a^3)*(delta_E-sin(delta_E));
                dtdp = -g/(2*p)-3/2*a*(t_n-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))+sqrt(a^3)*(2*k*sin(delta_E)/(p*(k-l*p)));
            end
            
            if tof-t_n<=tol
                break
            elseif i==x
                sprintf("did not converge in %d iterations", x)
            end
            i=i+1;
            
            p=p+(tof-t_n)/(dtdp);
            
        end
        g_dot=1-norm(r_i)/p*(1-cos(delta_nu));
        v_i=(norm(r_f)-f*norm(r_i))/g;
        v_f=f_dot*norm(r_i)+g_dot*v_i;
        
    %% Calculate Orbital Elements:
        h=cross(r_i,v_i);
        e=1/mu*((norm(v_i)^2-mu/norm(r_i)).*r_i - dot(r_i,v_i)*v_i);
        ec=norm(e);
        inc=acosd(dot(h,[0 0 1])/norm(h));
        n=cross([0 0 1],h);
        if dot(n,[0 1 0])<0
            Omega=2*pi - acos(dot(n,[1 0 0])/norm(n));
        else
            Omega=acos(dot(n,[1 0 0])/norm(n));
        end
        if dot(e,[0 0 1])<0
            om=2*pi - acos(dot(n,e)/(norm(n)*norm(e)));
        else
            om = acos(dot(n,e)/(norm(n)*norm(e)));
        end
        if dot(r,v)<0
            nu=2*pi - acos(dot(e,r)/(norm(e)*norm(r)));
        else
            nu=acos(dot(e,r)/(norm(e)*norm(r)));
        end
        if dot(r,[0 0 1])<0
            u=2*pi - acos(dot(n,r)/(norm(n)*norm(r)));
        else
            u=acos(dot(n,r)/(norm(n)*norm(r)));
        end
        out = [p, ec, inc, Omega, om, nu, u, v_i, v_f];
    end

%% Plot:


end