clear

%This shows the response of a hanging mass damped harmonic motion system using numerical methods
%through Matlab's ode45 solver. 

%Rough illustration of system: https://imgur.com/a/s3uIY2S
%Missing the input force. 

%Relevant Matlab documentation:
%https://www.mathworks.com/help/control/ug/plotting-system-responses.html

%parameters
k=1;        %stiffness
m=1;        %mass
c=10;       %damping coefficient
x0=0;       %initial position
x_dot0=0;   %initial velocity
duration=30; 

%This calls the function which has ODE45 inside of it and returns a time as a column vector, and
%the state values of the state equation as a matrix. 
[time,state_values] = forced_damped_harmonic_motion(k,m,c,x0, x_dot0,duration);

%The first state variable is for x, and the x values are the first column in the state_values matrix.
x = state_values(:,1);
%The second state varibale is for x_dot, and the x_dot values are the first column in the state_values matrix.
x_dot = state_values(:,2);
%Create the input signal using the input signal function below. 
input_signal=input_signal_function(time);

figure()
%Plot position vs time. 
plot(time,x)
hold on
%Plot input signal vs time. 
plot(time,input_signal)
legend('System Response','Input Signal: cos(t)')

%This function numerically solves forced damped harmonic motion given relevant parameters. 
function [time,state_values] = forced_damped_harmonic_motion(k,m,c,x0,x_dot0,duration)
%Create timespan row vector for simulation.
time_span = [0,duration];   
%Create initial condition row vector in the correct order corresponding to the state equation below.
initial_conditions = [x0 , x_dot0];


%Create the state equation function as a function of the state variable vector s, and time, t.
%The part in the brackets are your state equations. 
%Great Youtube video on what is going on here: https://www.youtube.com/watch?v=hR9O7sVOArE
%If you want to see where the state equations below come from: https://imgur.com/CgwYFpP
s_dot = @(t,s) [s(2);
                (input_signal_function(t) - c*s(2) - k*s(1)) / m];

%Run ode45 with the state equation function, timespan, and initial conditions. Return values. 
[time,state_values] = ode45(s_dot, time_span, initial_conditions);

end

%Change the input function easily with this function. 
function input_signal = input_signal_function(time)
input_signal=cos(time);
end
