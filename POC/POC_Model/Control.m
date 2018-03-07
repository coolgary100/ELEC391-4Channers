% This script sets the controller parameters for the SLS 3-D Printer

% ================
% CONTROLLER GAINS
% ================

% Enter optimized PID values here.
% No more than 3 significant figures per gain value.

%Kd = 11.2;
%Kp = 1.2*Kd;
%Ki = 0.7*Kd;

%Kd = 0.10;
%Kp = 54*Kd;
%Ki = 0;

Kd = 0.11;
Kp = 6*Kd;
Ki = 0;

%Kd = 0.08;
%Kp = 1*Kd;

%Kd = 0.23;
%Kp = 1.98*Kd;
%Ki = 0.03*Kd;

%Kd = 0.018;
%Kp = 51*Kd;

PID0 = [Kp Ki Kd]; %Yellow Graph
%PID1 = [0 0 0];                      %Blue Graph

% Enter feedback sensor values here.

%FB0 = 1/Sens0;
%FB1 = 1/Sens1;


% =====================
% Set-Point Time Vector
% =====================

% The Time Vector is stored in a variable called "Time".
% It's initial value is equally spaced for all samples and is
% set in TRAJECTORY.M
%
% Redefine this vector here to optimize the build time of the part.
% You can define it analytically or type in the elements manually but
% you must not change the length because it must contain one value for
% each Xd/Yd position pair.
% In the Matlab window, enter "length(Time)" to see how big it is.

% The Time vector must range from 0 to TotalTime

% Set the time vector to have the shape of a sin curve in order to sample
% more points towards the center, which would theoretically reduce the
% number of position errors, as most of the error was seen at the very
% beginning of the simulation.

%Time = zeros(1, 161);
%xxx = 0:(pi/40):pi;
%yyy = sin(xxx);
%Distance =0;
%i = 2;
%c = 1;
%while i <= length(Time)
%    if(i<=40) 
%        Distance = yyy(i);
%    end 
%    Time(i) = Time(i-1) + Distance;
%    i = i+1;
%end

%Time       = 0:SampleTime:TotalTime;       % DO NOT CHANGE TotalTime
