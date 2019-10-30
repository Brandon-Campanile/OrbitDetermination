%% Gauss Problem:
% =========================================================================
%   Given r_initial, r_final, and time-of-flight determine the orbital
%   elements of a satellite.

function Gauss(r_i, r_f, start_date, end_date, frame, CentralBody, tol, iter, tstep)
%% Usage:
% epoch    = 'July 4, 2003 11:00 AM PST';
% frame    = 'J2000';
%
%% Constants & Variables:
%   
%   delta_nu = 'long way': largest angle between r_i and r_f; 'short way':
%   smallest angle between r_i and r_f.
%   dates = 
%
%% Initialize:

clear; clc; close all
cspice_furnish('kernels\metakernel.tm')

start_date = datetime(start_date, 'Format','dd-MMM-yyyy HH:mm:ss:SSS');
end_date = datetime(end_date, 'Format','dd-MMM-yyyy HH:mm:ss:SSS');
tof = milliseconds(end_date-start_date)/1000; % milliseconds will increase accuracy as the seconds function would round the result

T = cspice_bodvrd(CentralBody, 'RADII', 3);
DU = norm(T);
if strcmpi(CentralBody, 'Sun') || strcmpi(CentralBody, 'Heliocentric')
    DU = 1.4960e+8; % 1 AU in km
end

r_i = r_i./DU; % first position in distance units
r_f = r_f./DU; % second position in distance units
mu = cspice_bodvrd( CentralBody, 'GM', 1 ); % km^3/s^2 gravitational constant of central body
TU = sqrt(DU^3/mu); % Time unit for heliocentric orbit
delta_nu_short = acos(dot(r_i,r_f)/(norm(r_i)*norm(r_f))); % Find angle between two vectors
delta_nu_long = 2*pi-delta_nu_short;
tof = tof/TU;
x=floor(iter); % number of iteration to attempt
long = p_iter(delta_nu_long);
short = p_iter(delta_nu_short);
SemiMajorAxis = [short(1); long(1)];
SemiLatusRectum = [short(2); long(2)];
Eccentricity = [short(3); long(3)];
Inclination = [short(4); long(4)];
LongitudeoftheAscendingNode = [short(5); long(5)];
ArgumentofPeriapsis = [short(6); long(6)];
OE = table(SemiMajorAxis, SemiLatusRectum, Eccentricity, Inclination, LongitudeoftheAscendingNode, ArgumentofPeriapsis, 'RowNames', {'Short Way','Long Way'});

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
        a = p/(1-ec^2);
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
        out = [a, p, ec, inc, Omega, om, nu, u, v_i, v_f];
    end

%% Plot:
y0 = [r_i out(9)]';
t = 0:tstep:tof;
    function dydt=orbdyn(t,y) %#ok<INUSL>
        dydt(1)=y(4);
        dydt(2)=y(5);
        dydt(3)=y(6);
        dydt(4)=-y(1)/(sqrt(y(1)^2+y(2)^2+y(3)^2))^3;
        dydt(5)=-y(2)/(sqrt(y(1)^2+y(2)^2+y(3)^2))^3;
        dydt(6)=-y(3)/(sqrt(y(1)^2+y(2)^2+y(3)^2))^3;
    end

et = cspice_str2et( start_date ); %  Convert the epoch to ephemeris time.
abcorr   = 'LT+S'; % aberration correction LT+S (light time plus stellar aberration)


[t,y1] = ode45(@orbdyn, t, y0); % Transfer orbit
G = max(sqrt(sum(y1.^2,1)))*1.2; % 120 percent of the maximum distance of transfer orbit from central body

[ y02, ~ ] = cspice_spkezr( 'Earth', et, frame, abcorr, CentralBody);
[~,y2] = ode45(@orbdyn, t, y02); % Earth orbit

[ y03, ~ ] = cspice_spkezr( 'Venus', et, frame, abcorr, CentralBody);
[~,y3] = ode45(@orbdyn, t, y03); % Venus orbit

[ y04, ~ ] = cspice_spkezr( 'Mercury', et, frame, abcorr, CentralBody);
[~,y4] = ode45(@orbdyn, t, y04); % Mercury orbit

[ y05, ~ ] = cspice_spkezr( 'Mars', et, frame, abcorr, CentralBody);
[~,y5] = ode45(@orbdyn, t, y05); % Mars orbit

[ y06, ~ ] = cspice_spkezr( 'Jupiter', et, frame, abcorr, CentralBody);
[~,y6] = ode45(@orbdyn, t, y06); % Jupiter orbit

[ y07, ~ ] = cspice_spkezr( 'Saturn', et, frame, abcorr, CentralBody);
[~,y7] = ode45(@orbdyn, t, y07); % Saturn orbit

[ y08, ~ ] = cspice_spkezr( 'Neptune', et, frame, abcorr, CentralBody);
[~,y8] = ode45(@orbdyn, t, y08); % Neptune orbit

[ y09, ~ ] = cspice_spkezr( 'Uranus', et, frame, abcorr, CentralBody);
[~,y9] = ode45(@orbdyn, t, y09); % Uranus orbit

[ y010, ~ ] = cspice_spkezr( 'Pluto', et, frame, abcorr, CentralBody);
[~,y10] = ode45(@orbdyn, t, y010); % Pluto orbit

plot3(y1(1,:),y1(2,:),y1(3,:), '-m',... % Transfer orbit
    r_i(1),r_i(2),r_i(3),'or', r_f(1),r_f(2),r_f(3),'or',... % Initial and starting positions
    0, 0, 0, 'oy','MarkerSize',12,'MarkerFaceColor','y',... % Sun marker
    y2(1,:),y2(2,:),y2(3,:),'-c',... % Plot Earth orbit
    y3(1,:),y3(2,:),y3(3,:),'-y',... % Plot Venus orbit
    y4(1,:),y4(2,:),y4(3,:),'-r',... % Plot Mercury orbit
    y5(1,:),y5(2,:),y5(3,:),'-r',... % Plot Mars orbit
    y6(1,:),y6(2,:),y6(3,:),'-w',... % Plot Jupiter orbit
    y7(1,:),y7(2,:),y7(3,:),'-b',... % Plot Saturn orbit
    y8(1,:),y8(2,:),y8(3,:),'-g',... % Plot Neptune orbit
    y9(1,:),y9(2,:),y9(3,:),'-y',... % Plot Uranus orbit
    y10(1,:),y10(2,:),y10(3,:),'-w') % Plot Pluto orbit
xlim([-G G])
axis equal
grid on

%% Unload Kernels
cspice_kclear
nx = cspice_ktotal( 'ALL' );
fprintf('Count of loaded kernels after cspice_kclear call: %d\n', nx);

end