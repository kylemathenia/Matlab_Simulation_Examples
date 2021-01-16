clear

%This numerically solves the swinging atwood machine with ode45. 

%Swinging Atwood Machine: 
%   https://en.wikipedia.org/wiki/Swinging_Atwood%27s_machine
%   http://aquahue.net/aquahue/papers/sam_00.pdf


%parameters
theta0 = -pi/2;     %Initial angle of swinging mass in radians
theta_dot0 = 0;     %Initial angular velocity of swinging mass in radians/sec
r0 = 1;             %Initial radius 
r_dot0=0;           %Initial rate of change of radius
m1=4.5;             %Mass of larger vertical motion body
m2=1;               %Mass of smaller swinging body
duration = 100;     %seconds


%Calls the swinging_atwood function below. Returns time as column vector and state variable values
%as a matrix. 
[time,state_values] = swinging_atwood(theta0,theta_dot0,r0, r_dot0, m1, m2, duration);

%The first state variable is for theta, and the theta values are the first column in the state_values matrix.
theta = state_values(:,1);  %radians
%The second state variable is for theta_dot, and the theta_dot values are the second column in the state_values matrix.
theta_dot = state_values(:,2);
%Store radius values in column vector.
r = state_values(:,3);
%Store r_dot values in column vector.
r_dot = state_values(:,4);

%Get x and y position from r and theta. 
x_pos=r.*sin(theta);
y_pos=-r.*cos(theta);

figure()
%Get a plot of swinging mass position:
plot(x_pos,y_pos)




function [time,state_values] = swinging_atwood(theta0,theta_dot0,r0, r_dot0, m1, m2, duration)
time_span = [0,duration];
initial_conditions = [theta0 , theta_dot0,r0,r_dot0];
g=9.81;
mu=m1/m2;

%Create the state equation function as a function of the state variable vector s, and time, t. 
%See the swinging atwood machine paper for details on equations. http://aquahue.net/aquahue/papers/sam_00.pdf
s_dot = @(t,s) [s(2);
                (((-2*s(4)*s(2)/s(3)))-(g*sin(s(1))/s(3)));
                s(4);
                ((s(3)*(s(2)^2))+(g*(cos(s(1))-mu)))/(1+mu)];
            
options=odeset('RelTol',1e-5,'AbsTol',1e-10);   %Just making the simulation higher resolution than default.

[time,state_values] = ode45(s_dot, time_span, initial_conditions,options);

end

