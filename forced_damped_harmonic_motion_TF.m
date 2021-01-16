clear

%This shows the response of a hanging mass damped harmonic motion system through Matlab's transfer
%function method. 

%Rough illustration of system: https://imgur.com/a/s3uIY2S
%Missing the input force. 

%Matlab documentation about transfer functions:
%https://www.mathworks.com/help/control/ug/plotting-system-responses.html

%parameters
k=1;    %stiffness
m=1;    %mass
c=10;   %damping coefficient


%This is the transfer function for a hanging damped harmonic oscillator. 
% 1/(ms^2 + cs + k)

%In matlab form the transfer function is:
sys = tf([1],[m c k])

figure()
bode(sys)   %The frequency response. 

figure()
step(sys)   %The step response. 

%See the response to an arbitrary function, like cos(t).
figure()
t = 0:0.01:30;   %time duration.
u = cos(t);  %input signal.
lsim(sys,u,t)   % u,t define the input signal.
legend('System Response')



