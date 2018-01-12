% This script sets the controller parameters for the SLS 3-D Printer

% ================
% CONTROLLER GAINS
% ================

% Enter optimized PID values here.
% No more than 3 significant figures per gain value.

%Gain Values 
%AMAX22_6W
%KD0 = 306.234809608;
%KP0 = KD0*0.284894;
%KI0 = KD0*14.1105;
%KD1 = 3.45754867624;
%KP1 = KD1*49.1667;
%KI1 = 0;

%AMAX22_5W
%KD0 = 291.774293895;
%KP0 = KD0*0.283768;
%KI0 = KD0*14.1096;
%KD1 = 1.66587007903;
%KP1 = KD1*49.1667;
%KI1 = 0;

%AMAX12_p75W
%KD0 = 1331.6282266;
%KP0 = KD0*0.11117;
%KI0 = KD0*100.295;
%KD1 = 2.92871968155;
%KP1 = KD1*49.1667;
%KI1 = 0;

%AMAX19_2p5W
%KD0 = 737.546654685;
%KP0 = KD0*0.15805;
%KI0 = KD0*18.4129;
%KD1 = 27.7079401902;
%KP1 = KD1*49.1667;
%KI1 = 0;

%AMAX16_2W
%KD0 = 550.84128487;
%KP0 = KD0*0.180378;
%KI0 = KD0*46.5546;
%KD1 = 2.18860465759;
%KP1 = 46.6921*KD1;
%KI1 = 0;

%Tscale0 = 1963.432e-4;
%Tscale1 = 5.234e-3;

%KD0 = 85.1717;
%KP0 = KD0*1.945;
%KI0 = KD0*96.72;
%KD1 = 5.8589;
%KP1 = 49.17*KD1;
%KI1 = 0;

Tscale0 = 90.2e-3;
Tscale1 = 2.67e-3;
KP0 = 1.945;
KI0 = 96.72;
KP1 = 49.17;
KI1 = 0;

%KP0 = 0.9159;
%KI0 = 45.54;
%KP1 = 49.17;
%KI1 = 0;

PID0 = [0.175 8.72 90.2e-3]; %Yellow Graph
PID1 = [0.131 0 2.67e-3];                      %Blue Graph

%PID0 = [148.037109958*10^(-4) 133555.652993*10^(-4) 1331.6282266*10^(-4)];
%PID1 = [143.995481967*10^(-3) 0 2.92871968155*10^(-3)];

% Enter feedback sensor values here.

FB0 = 1/Sens0;
FB1 = 1/Sens1;


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
