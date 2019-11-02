function Gauss(r_i, r_f, start_date, end_date, CentralBody, options)

%% Gauss Problem:
%   Given r_initial, r_final, and time-of-flight determine the orbital
%   elements of a satellite.

%% Usage:
% Input format examples:
%   options = {'frame', 'J2000', 'tol', 1e-11, 'iter', 100, 'tstep', 60} key-value pairs with their default values shown here. If a key-value pair is omitted it uses the default value.
%   r_i/r_f: [r_x, r_y, r_z] 
% 	start_date/end_date: 'Jul 04, 2003 21:05:05.005 PST', 'MMM dd, yyyy HH:mm:ss.SSS z'
%   frame: 'J2000', etc
%   CentralBody: 'Mars', 'Earth', 'Sun'/'heliocentric', etc. This represents the body you are orbiting.
%   tol: tolerance of calculated tof from desired
%   iter: number of iterations to try for convergence
%   tstep: timestep for ode45 in seconds, default is 60 seconds
%
%% Constants & Variables:
%   
%   delta_nu = 'long way': largest angle between r_i and r_f; 'short way':
%   smallest angle between r_i and r_f.
%   dates = 
%
%% Examples:
%
clear; clc; close all

r_i = [-139034613.257526, -51514828.828285, -22329811.378710];
r_f = [-140167397.186301, -48736658.091816, -21125310.009550];
start_date = 'Apr 12, 2025 00:00:00.005 PST';
end_date = 'Apr 11, 2026 00:00:00.000 PST';
CentralBody = 'Sun';

%
%
%
%
%% Initialize:

cspice_furnsh('kernels/metakernel.tm')

if exist('options', 'var') && round(length(options)/2)~=length(options)/2
   error('options needs propertyName/propertyValue pairs')
end
defoptions = struct('frame', 'J2000', 'tol', 1e-14, 'iter', 100, 'tstep', 300);
if exist('options', 'var')
    for pair = reshape(options,2,[])
        inpName = lower(pair{1});
        if any(strcmp(inpName,fieldnames(defoptions)))
            defoptions.(inpName) = pair{2};
        else
            error('%s is not a recognized parameter name',inpName)
        end
    end
end
start_time = datetime(start_date, 'Format','MMM dd, yyyy HH:mm:ss.SSS z', 'TimeZone','UTC');
end_time = datetime(end_date, 'Format','MMM dd, yyyy HH:mm:ss.SSS z', 'TimeZone','UTC');
tof = milliseconds(end_time-start_time)/1000; % milliseconds will increase accuracy as the seconds function would round the result

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
x=floor(defoptions.('iter')); % number of iteration to attempt
short = p_iter(delta_nu_short);
long = p_iter(delta_nu_long);
SemiMajorAxis = [short{1}; long{1}];
SemiLatusRectum = [short{2}; long{2}];
Eccentricity = [short{3}; long{3}];
Inclination = [short{4}; long{4}];
LongitudeoftheAscendingNode = [short{5}; long{5}];
ArgumentofPeriapsis = [short{6}; long{6}];
OE = table(SemiMajorAxis, SemiLatusRectum, Eccentricity, Inclination, LongitudeoftheAscendingNode, ArgumentofPeriapsis, 'RowNames', {'Short Way','Long Way'});

writetable(OE,'OrbitalElements.xlsx','WriteRowNames',true)  
%% P-Iteration Method:
    function out = p_iter(delta_nu)
    %% Determine Initial Value of P:
        k = norm(r_i)*norm(r_f)*(1-cos(delta_nu));     % k, l, & m are intermediary values for calculation with no physical representation
        l = norm(r_i)+norm(r_f);
        m = norm(r_i)*norm(r_f)*(1+cos(delta_nu));
        
        p_i = k/(l+sqrt(2*m));   % lower bound of p for the "short way" below which there is no solution (open end of parabola at p_i and open end of hyperbola at p<p_i) if p->inf, tof->0 and is the straight line solution
        p_ii = k/(l-sqrt(2*m));  % upper bound of p for the "long way" above which there is no solution (open end of parabola at p_ii and open end of hyperbola at p>p_ii) as p->0, tof->0 and is degenerate hyperbola (travel along r_i to focus then along r_f)
        p = (p_i+p_ii)/2;      % Choose average value between p_i and p_ii as an initial starting value as it is guaranteed to have a solution
        i = 0;
        
    %% Iteration
        while i<=x
            a = m*k*p/((2*m-l^2)*p^2+2*k*l*p-k^2); % Elliptic if 0<a<inf, hyperbolic if -inf<a<0, parabolic if a->+/-inf
            f = 1-norm(r_f)/p*(1-cos(delta_nu));
            g = norm(r_i)*norm(r_f)*sin(delta_nu)/sqrt(p);
            f_dot = -sqrt(a)/(norm(r_i)*norm(r_f))*sin(delta_nu);
            %f_dot = sqrt(1/p)*tan(delta_nu/2)*(1/p*(1-cos(delta_nu))-1/norm(r_f)-1/norm(r_i));
            
            if a<0 % hyperbolic
                delta_F = acosh(1-norm(r_i)/a*(1-f));
                t_n = g+sqrt((-a)^3)*(sinh(delta_F)-delta_F);
                dtdp = -g/(2*p)-3/2*a*(t_n-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))-sqrt((-a)^3)*(2*k*sinh(delta_F)/(p*(k-l*p)));
            else % elliptic/circular (parabolic?)
                if abs(a)==inf
                    delta_E=0;
                else
                    d_E_cos = 1-norm(r_i)/a*(1-f);
                    d_E_sin = -norm(r_i)*norm(r_f)*f_dot/sqrt(a);
                    delta_E = atan2(d_E_sin,d_E_cos);
                    if delta_E<0
                        delta_E = 2*pi+delta_E;
                    end
                end
                t_n = g+sqrt(a^3)*(delta_E-sin(delta_E));
                dtdp = -g/(2*p)-3/2*a*(t_n-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))+sqrt(a^3)*(2*k*sin(delta_E)/(p*(k-l*p)));
            end
            
            if abs(tof-t_n)<=defoptions.('tol')
                break
            elseif i==x
                sprintf("did not converge in %d iterations", x)
                exit
            end
            i=i+1;
            if delta_nu<pi %short way
                p=max(p+(tof-t_n)/dtdp,p_i+(p-p_i)/2);
            else % long way
                p=min(max(p+(tof-t_n)/dtdp,0),p_ii-(p-p_ii)/2);
            end
            % p=min(max(p+(tof-t_n)/(dtdp),p_i+(p-p_i)/2),p_ii-(p_ii-p)/2);
            
        end
        g_dot=1-norm(r_i)/p*(1-cos(delta_nu));
        v_i=(r_f-f*r_i)/g;
        v_f=f_dot*r_i+g_dot*v_i;
        
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
        if dot(r_i,v_i)<0
            nu=2*pi - acos(dot(e,r_i)/(ec*norm(r_i)));
        else
            nu=acos(dot(e,r_i)/(ec*norm(r_i)));
        end
        if dot(r_i,[0 0 1])<0
            u=2*pi - acos(dot(n,r_i)/(norm(n)*norm(r_i)));
        else
            u=acos(dot(n,r_i)/(norm(n)*norm(r_i)));
        end
        out = {a, p, ec, inc, Omega, om, nu, u, v_i, v_f};
    end

%% Plot:
y0 = [r_i short{9}];
y01 = [r_i long{9}];
t = 0:defoptions.('tstep')/TU:tof;
    function dydt=orbdyn(t,y) %#ok<INUSL>
        dydt=zeros(6,1);
        dydt(1)=y(4);
        dydt(2)=y(5);
        dydt(3)=y(6);
        dydt(4)=-y(1)/(sqrt(y(1)^2+y(2)^2+y(3)^2)^3);
        dydt(5)=-y(2)/(sqrt(y(1)^2+y(2)^2+y(3)^2)^3);
        dydt(6)=-y(3)/(sqrt(y(1)^2+y(2)^2+y(3)^2)^3);
    end

et = cspice_str2et( start_date ); %  Convert the epoch to ephemeris time.
abcorr   = 'LT+S'; % aberration correction LT+S (light time plus stellar aberration)
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[~,y1] = ode45(@(t,y) orbdyn(t,y), t, y0, options); % Transfer orbit short way
[~,yz] = ode45(@(t,y) orbdyn(t,y), t, y01, options); % Transfer orbit long way
y1=y1';
yz=yz';
G = max(max(sqrt(sum(y1(1:3,:).^2,1))),max(sqrt(sum(yz(1:3,:).^2,1))))*DU*1.2; % 120 percent of the maximum distance of transfer orbit from central body

[ y02, ~ ] = cspice_spkezr( 'Earth', et, defoptions.('frame'), abcorr, CentralBody);
y02=[y02(1:3)./DU; y02(4:6).*TU./DU]';
[~,y2] = ode45(@(t,y) orbdyn(t,y), t, y02, options); % Earth orbit
y2=y2';

[ y03, ~ ] = cspice_spkezr( 'Venus', et, defoptions.('frame'), abcorr, CentralBody);
y03=[y03(1:3)./DU; y03(4:6).*TU./DU]';
[~,y3] = ode45(@(t,y) orbdyn(t,y), t, y03, options); % Venus orbit
y3=y3';

[ y04, ~ ] = cspice_spkezr( 'Mercury', et, defoptions.('frame'), abcorr, CentralBody);
y04=[y04(1:3)./DU; y04(4:6).*TU./DU]';
[~,y4] = ode45(@(t,y) orbdyn(t,y), t, y04, options); % Mercury orbit
y4=y4';

% [ y05, ~ ] = cspice_spkezr( 'Mars', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y5] = ode45(@orbdyn, t, y05); % Mars orbit

% [ y06, ~ ] = cspice_spkezr( 'Jupiter', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y6] = ode45(@orbdyn, t, y06); % Jupiter orbit

% [ y07, ~ ] = cspice_spkezr( 'Saturn', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y7] = ode45(@orbdyn, t, y07); % Saturn orbit
% 
% [ y08, ~ ] = cspice_spkezr( 'Neptune', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y8] = ode45(@orbdyn, t, y08); % Neptune orbit
% 
% [ y09, ~ ] = cspice_spkezr( 'Uranus', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y9] = ode45(@orbdyn, t, y09); % Uranus orbit
% 
% [ y010, ~ ] = cspice_spkezr( 'Pluto', et, defoptions.('frame'), abcorr, CentralBody);
% [~,y10] = ode45(@orbdyn, t, y010); % Pluto orbit

plot3(y1(1,:),y1(2,:),y1(3,:), '-m',... % Transfer orbit short way
    yz(1,:),yz(2,:),yz(3,:), '-m',... % Transfer orbit long way
    r_i(1),r_i(2),r_i(3),'*r', r_f(1),r_f(2),r_f(3),'*b',... % Initial and starting positions
    y2(1,:),y2(2,:),y2(3,:),'-c',... % Plot Earth orbit
    y3(1,:),y3(2,:),y3(3,:),'-y',... % Plot Venus orbit
    y4(1,:),y4(2,:),y4(3,:),'-r',... % Plot Mercury orbit
    0, 0, 0, 'oy','MarkerSize',12,'MarkerFaceColor','y') % Sun marker)
%     y5(1,:),y5(2,:),y5(3,:),'-r',... % Plot Mars orbit
%     y6(1,:),y6(2,:),y6(3,:),'-w',... % Plot Jupdefoptions.('iter') orbit
%     y7(1,:),y7(2,:),y7(3,:),'-b',... % Plot Saturn orbit
%     y8(1,:),y8(2,:),y8(3,:),'-g',... % Plot Neptune orbit
%     y9(1,:),y9(2,:),y9(3,:),'-y',... % Plot Uranus orbit
%     y10(1,:),y10(2,:),y10(3,:),'-w') % Plot Pluto orbit
xlim([-2 2])
ylim([-2 2])
zlim([-.5 .5])
%axis equal
grid on
hold on

xt = cspice_str2et( 'Apr 16, 2027 00:00:00.000 PST' );
j = cspice_spkezr( 'Earth', xt, defoptions.('frame'), abcorr, CentralBody);
j = j(1:3)./DU;
b = cspice_spkezr( 'Venus', xt, defoptions.('frame'), abcorr, CentralBody);
b = b(1:3)./DU;
vector = b-j;
plot3([r_f(1), b(1)],[r_f(2), b(2)],[r_f(3), b(3)])

%% Unload Kernels
cspice_kclear
nx = cspice_ktotal( 'ALL' );
fprintf('Count of loaded kernels after cspice_kclear call: %d\n', nx);

end