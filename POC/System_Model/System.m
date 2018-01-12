% This script sets the model parameters for the SLS 3-D Printer

% Example: Specifying a Dynamics Block
% n = [1 2 3];
% d = [4 5 6];
% Transfer Function = (s^2 + 2s + 3) / (4s^2 + 5s + 6)

% ========================
% PHYSICAL UNIT CONVERSION
% ========================
% Example: if you decide to work in (Kg), all masses must be represented
%          in (Kg) but the spec sheet may provide masses in (g)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Over-write the default values from DEFAULT.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ==========================
% Choose Motors
% ==========================
%
%AMAX22_5W_SB;                % Default Maxon motor
%AMAX22_6W_SB;
%AMAX19_2p5W_SB;
%AMAX16_2W_SB;
%AMAX12_p75W_SB;

AMAX22_5W_SB;
Q0 = MotorParam;
AMAX12_p75W_SB;
Q1 = MotorParam;

% Motor Unit Conversions
% ----------------------
%All the conversions were done during calculations

% ==========================
% Motor Parameters
% ==========================

% Maximum Current
% ---------------
%AMAX22_5W_SB
NomI0   = 0.586;                 % Max average current
StallI0 = 2.23;                 % Max peak current
%NomI1   = 0.586;                 % Max average current
%StallI1 = 2.23;                 % Max peak current

%AMAX22_6W_SB
%NomI0 = 0.681;
%StallI0 = 2.17;
%NomI1 = 0.681;
%StallI1 = 2.17;

%AMAX19_2p5W_SB
%NomI0 = 0.397;
%StallI0 = 0.867;
%NomI1 = 0.397;
%StallI1 = 0.867;

%AMAX16_2W_SB
%NomI0 = 0.394;
%StallI0 = 0.704;
%NomI1 = 0.394;
%StallI1 = 0.704;

%AMAX12_p75W_SB
%NomI0 = 0.141;
%StallI0 = 0.22;
NomI1 = 0.141;
StallI1 = 0.22;

%JMotor for which Q1 motor it is 
%AMAX22_5W_SB
%JMotor = 7.67162*10^(-5)

%AMAX22_6W_SB
%JMotor = 7.67162*10^(-5)

%AMAX19_2p5W_SB
%JMotor = 5.84892*10^(-5);

%AMAX16_2W_SB
%JMotor = 2.222036*10^(-5);

%AMAX12_p75W_SB
JMotor = 9.2752*10^(-6);

JLink = 1.8091*10^(-6);
RotJQ0 = Q0(16)*10^(-7);
RotJQ1 = Q1(16)*10^(-7);

JTotal=JMotor+JLink+RotJQ0;

% =============================
% Q0 : Rotation about y-axis
% =============================

% Amplifier Dynamics
% ------------------
%Calculations in the report
Amp0n   = [0 0 207.5600];               % Numerator 
Amp0d   = [0 4.2240 207.6800];               % Denominator

%Same for AMAX22_5W_SB, AMAX22_6W_SB, AMAX19_2p5W_SB
AmpSat0 = 12;                          % Nominal Voltage of the Motor

%Same for AMAX16_2W_SB AMAX12_p75W_SB
%AmpSat0 = 9;

% Electrical Motor Dynamics
% -------------------------
Elec0n  = [0 0 1];               % Numerator

%AMAX22_5W_SB
Elec0d  = [0 0.000362 5.39];     % The denominator is sL + R where L is 0.362 mH and R is 5.39 Ohms

%AMAX22_6W_SB
%Elec0d = [0 0.000363 5.53];

%AMAX19_2p5W_SB
%Elec0d = [0 0.000719 13.8];

%AMAX16_2W_SB
%Elec0d = [0 0.000467 12.8];

%AMAX12_p75W_SB
%Elec0d = [0 0.00101 40.9];

% Torque Const & Back EMF
% -----------------------
%Same for AMAX22_5W_SB, AMAX22_6W_SB, AMAX19_2p5W_SB
TConst0  = 0.0109;

%AMAX16_2W_SB
%TConst0 = 0.00688;

%AMAX12_p75W_SB
%TConst0 = 0.00692;

% Torque constant taken off from the data sheet 10.9 mNm/A converted to Nm/A

%Same for AMAX22_5W_SB, AMAX22_6W_SB
BackEMF0 = 1/((875/60)*2*pi); 

%AMAX19_2p5W_SB
%BackEMF0 = 1/((874/60)*2*pi);

%AMAX16_2W_SB
%BackEMF0 = 1/((1390/60)*2*pi);

%AMAX12_p75W_SB
%BackEMF0 = 1/((1380/60)*2*pi);

% Inverse of the speed constant (875 rpm/v) after converting rpm to rad/s 
% in order to multiply output of mechanical dynamic to get voltage gain

% Mechanical Motor Dynamics
% -------------------------
Mech0n  = [0 1 0];               % Numerator

%AMAX22_5W_SB
Mech0d  = [JTotal 3.3628*10^(-7) 1.1140846*10^(-3)];  

%AMAX22_6W_SB
%Mech0d = [JTotal 9.347*10^(-7) 1.1140846*10^(-3)];

%AMAX19_2p5W_SB
%Mech0d = [JTotal 9.35*10^(-7) 1.1140846*10^(-3)];

%AMAX16_2W_SB
%Mech0d = [JTotal 6.239*10^(-7) 1.1140846*10^(-3)];

%AMAX12_p75W_SB
%Mech0d = [JTotal 6.41*10^(-8) 1.1140846*10^(-3)];

% Denominator is Js^2 + Bs + K (Spring constant (700 mNm/rev) converted to 
% Nm (Multiple by 10^(-3)) and rev to rad (Divide by 2pi))
% Inertia was calculated relative to the center of the link (9mm away from
% the counter weight and the motors) using superposition
% Friction was calculated using no load current and no load speed as it was
% assumed to be the friction the torque would need to overcome when there
% is no load on the motor

% Sensor Dynamics
% ---------------
Sens0    =  1.5915; % Sensor gain is the max/min sensor voltage (5V)
SensSat0 =  5; % Angular range is 180 degrees which is equivalent to pi

% Static Friction
% ---------------

%Same for AMAX22_5W_SB, AMAX22_6W_SB
StFric0 = 8.0804*10^(-4); 

%AMAX19_2p5W_SB
%StFric0 = 5.333587*10^(-4);

%AMAX16_2W_SB
%StFric0 = 3.548166*10^(-4);

%AMAX12_p75W_SB
%StFric0 = 2.174767*10^(-4);

% static friction is calculated through uSF (converted to m from um) * mass of the entire sphereical wrist ignoring mass of Q0
% Q0 was ignored because it was assumed the only mass acting from this
% motor were the rotors which were of negligible mass.

% =============================
% Q1 : Rotation about x-axis
% =============================

% Amplifier Dynamics
% ------------------
Amp1n   = [0 0 207.5600];               % Numerator
Amp1d   = [0 4.2240 207.6800];               % Denominator

%Same for AMAX22_5W_SB, AMAX22_6W_SB, AMAX19_2p5W_SB
%AmpSat1 = 12;

%Same for AMAX16_2W_SB AMAX12_p75W_SB
AmpSat1 = 9;

% Electrical Motor Dynamics
% -------------------------

Elec1n  = [0 0 1];

%AMAX22_5W_SB
%Elec1d  = [0 0.000362 5.39];     % The denominator is sL + R where L is 0.362 mH and R is 5.39 Ohms

%AMAX22_6W_SB
%Elec1d = [0 0.000363 5.53];

%AMAX19_2p5W_SB
%Elec1d = [0 0.000719 13.8];

%AMAX16_2W_SB
%Elec1d = [0 0.000467 12.8];

%AMAX12_p75W_SB
Elec1d = [0 0.00101 40.9];

% Torque Const & Back EMF
% -----------------------
%Same for AMAX22_5W_SB, AMAX22_6W_SB, AMAX19_2p5W_SB
%TConst1  = 0.0109;              

%AMAX16_2W_SB
%TConst1 = 0.00688;

%AMAX12_p75W_SB
TConst1 = 0.00692;

% Torque constant taken off from the data sheet 10.9 mNm/A converted to Nm/A

%Same for AMAX22_5W_SB and AMAX22_6W_SB
%BackEMF1 = 1/((875/60)*2*pi);   

%AMAX19_2p5W_SB
%BackEMF1 = 1/((874/60)*2*pi);

%AMAX16_2W_SB
%BackEMF1 = 1/((1390/60)*2*pi);

%AMAX12_p75W_SB
BackEMF1 = 1/((1380/60)*2*pi);

% Inverse of the speed constant (875 rpm/v) after converting rpm to rad/s 
% in order to multiply output of mechanical dynamic to get voltage gain

% Mechanical Motor Dynamics
% -------------------------
Mech1n  = [0 0 1];               % Numerator

%AMAX22_5W
%Mech1d  = [RotJQ1 1.6814*10^(-7)];       

%AMAX22_6W
%Mech1d = [RotJQ1 4.67*10^(-7)];

%AMAX19_2p5W_SB
%Mech1d = [RotJQ1 4.675*10^(-5)];

%AMAX16_2W_SB
%Mech1d = [RotJQ1 3.11928188*10^(-7)];

%%AMAX12_p75W_SB
Mech1d = [RotJQ1 3.21*10^(-8)]; 

% Denominator is Js^2 + Bs + K. No spring so K = 0 and the inertia is the rotational inertia of the motor RotJ (4.39 gcm^2 converted to kgm^2))
% The friction was kept the same as Q0
JntSat1 = pi/3; %Joint limit is 60 degress which is equivalent to pi/3

% Sensor Dynamics
% ---------------
Sens1    =  1.5915;   % Sensor gain is the max/min sensor voltage (5V)
SensSat1 =  5;  % Angular range is 180 degrees which is equivalent to pi

% Static Friction
% ---------------


% ==================
% TRANSFER FUNCTIONS
% ==================
% Compute transfer functions from above values and perform system analysis
% You may prefer to put this section in a separate .m file
