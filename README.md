# OrbitDetermination
Orbit determination from two position vectors and the time-of-flight between them.

## Dependencies
This code requires the local installation of The SPICE Toolkit developed and deployed by The Navigation and Ancillary Information Facility (NAIF), a department within JPL. The following section describes the steps needed to download and install the toolkit and kernels required by this code.

## SPICE Installation
* Step 1: Download the SPICE Matlab (MICE) toolkit relevant to your local machine from the following website: https://naif.jpl.nasa.gov/naif/toolkit_MATLAB.html
* Step 2: Unzip the downloaded file to your local machine
* Step 3: In the Windows Command Prompt, execute the following after '>>', replacing <Path to local MICE toolkit> with the relevant path on your local machine to the unzipped toolkit: >> set PATH=<Path to local MICE toolkit>\mice\mice\exe;%PATH%
* Step 4: Download the relevant kernels via ftp from NAIF's servers via the following:
    * Orbit Ephemeris binary kernel: ftp://ssd.jpl.nasa.gov/pub/eph/planets/bsp/de430t.bsp
    * Leapseconds text kernel: Windows: ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls.pc; Other: ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls
    * Gravitational parameters text kernel: ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/gm_de431.tpc
    * Planet orientation and radii text kernel: ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/pck00010.tpc
    * Step 5: We need to add the MICE library to Matlab's search path. In Matlab's Command Window, execute the following two commands:
        addpath('<Path to local MICE toolkit>\mice\mice\lib')
        addpath('<Path to local MICE toolkit>\mice\mice\src\mice')
* Step 5: Download and extract the OrbitDetermination repository on Github to your local machine. The 'Gauss.m' repository is dependent on the other files within the repository and requires all of them.
* Step 6: Not a step, but a handy list of SPICE/MICE resources:
    * https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/MATLAB/info/mostused.html#F
    * file:///<Path to local MICE toolkit>/mice/mice/doc/html/req/mice.html
    * file:///<Path to local MICE toolkit>/mice/mice/doc/html/mice/index.html

## Results:

There exist two solutions to the Gauss/Lambert problem named the "long
way" where delta_nu > pi and the "short way" where delta_nu < pi.

Note:
- If r_initial and r_final are colinear AND opposite (delta_nu = pi radians)
a unique solution does NOT exist. This is because the vectors r_initial
and r_final do not define a plane in this case. 
- If r_initial and r_final are colinear (delta_nu = 0,2*pi radians) the
solution is a degenerative conic (down r_initial to the focus then back
up r_final) but a solution exists (equations need modification as 'p'
in denominator results in a singularity).

## Iteration Method:

This code utilizes the "p-iteration" method where a guess of "p" is made
and the semi-major axis and change in mean anomaly are calculated.

This iteration method was chosen as it allows for the formulation of an
analytical expression for dt/dp, meaning a Newton iteration method can
be used for faster convergence, resulting in the direct manipulation of "p".

Looking at the graph of t vs p, the "long way" goes from the origin to 
an asymptote where t->inf, caused by it becoming a parabola (delta_E=0)
at p_ii. The "short way" goes from a parabola at p_i where t->inf to
p->inf where t approaches 0 (p_i < p_ii). Our starting value of p should
be between p_i and p_ii. The minimum of this graph between p_i and p_ii
corresponds to a_min, the "minimum energy ellipse".

## Algorithm:

* Step 1: Evaluate the constants k, l, and m from r_i, r_f, and delta_nu using equations (1), (2), and (3).
* Step 2: Determine the limits on the possible values of p by evaluating p_i and p_ii from equations (4) and (5).
* Step 3: Pick a trial value of p within the limits p_i and p_ii
* Step 4: Using the trial value of p, solve for 'a' from equation (6). The type of conic can be determined from the value of 'a'. Elliptic if 0<a<inf, hyperbolic if -inf<a<0, parabolic if a->+/-inf.
* Step 5: Solve for f, g, and f' from equations (7), (8), and (9).
* Step 6: Solve for delta_E or delta_F using equations (10) and (11) for delta_E or equation (12) for delta_F if a<0. You need two equations for delta_E to determine its sign.
* Step 7: Solve for t from equation (13) or, if a<0,(14) and compare it with the desired time-of-flight.
* Step 8: Adjust the trial value of p using the Newton iteration method until the desired time-of-flight is reached.
	- Step 8.1: Solve for the derivative dt/dp from equation (15) or, if hyperbolic, (16) using the intermediary iteration values.
    - Step 8.2: Solve for the adjusted value of p using equation (17)
* Step 9: Evaluate g' from equation (18) then solve for v_i and v_f using equations (19) and (20).
* Step 10: Calculate orbital elements from position and velocity vectors.

## Equations:
   
   (1): k=r_i*r_f*(1-cos(delta_nu))
   (2): l=r_i+r_f
   (3): m=r_i*r_f*(1+cos(delta_nu))
   (4): p_i=k/(l+sqrt(2*m))
   (5): p_ii=k/(1-sqrt(2*m))
   (6): a= m*k*p/((2*m-l^2)*p^2+2*k*l*p-k^2)
   (7): f=1-r_f/p*(1-cos(delta_nu))=1-a/r_i*(1-cos(delta_E))
   (8): g=r_i*r_f*sin(delta_nu)/sqrt(mu*p)=t-sqrt(a^3/mu)*(delta_E - sin(delta_E))
   (9): f'=sqrt(mu/p)*tan(delta_nu/2)*((1-cos(delta_nu))/p-1/r_i-1/r_f)=-sqrt(mu*a)/(r_i*r_f)*sin(delta_nu)
  (10): cos(delta_E)=1-r_i/a*(1-f)
  (11): sin(delta_E)=-r_i*r_f*f'/sqrt(mu*a)
  (12): cosh(delta_F)=1-r_i/a*(1-f)
  (13): t=g+sqrt(a^3/mu)*(delta_E-sin(delta_E))
  (14): t=g+sqrt((-a)^3/mu)*(sinh(delta_F)-delta_F)
  (15): dt/dp=-g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))+sqrt(a^3/mu)*(2*k*sin(delta_E)/(p*(k-l*p)))
  (16): dt/dp=-g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))-sqrt((-a)^3/mu)*(2*k*sinh(delta_F)/(p*(k-l*p)))
  (17): p_(n+1)=p_n+(t_desired-t_n)/(dt/dp_n)
  (18): g'=1-r_i/p*(1-cos(delta_nu))=1-a/r_f*(1-cos(delta_E))
  (19): v_i=(r_f-f*r_i)/g
  (20): v_f=f'*r_i+g'*v_i
