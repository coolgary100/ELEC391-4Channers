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
% Motor Unit Conversions
% ----------------------
%All the conversions were done during calculations

% ==========================
% Motor Parameters
% ==========================

% =============================
% Q0 : Rotation about y-axis
% =============================

% Amplifier Dynamics
% ------------------
%Calculations in the report
%Amp0n   = [0 0 0];               % Numerator 
%Amp0d   = [0 0 0];               % Denominator

%AmpSat0 = 0;                        

% Electrical Motor Dynamics
% -------------------------
%Elec0n  = [0 0 1];               % Numerator
%Elec0d  = [0 0 12/0.93];     % The denominator is sL + R where L is 0.362 mH and R is 5.39 Ohms

Elec0n = [0 0 1];
Elec0d = [0 0 1];

% Torque Const & Back EMF
% -----------------------
%TConst0  = (122.8/100000)/(0.93-0.19); %Max Torque/(stall current - no-load current)

TConst0 = 1;

%BackEMF0 = 1/(((4800/12)/60)*2*pi); 

% Inverse of the speed constant (875 rpm/v) after converting rpm to rad/s 
% in order to multiply output of mechanical dynamic to get voltage gain

% Mechanical Motor Dynamics
% -------------------------
Mech0n  = [0 0 2^2];               % Numerator
Mech0d  = [1 2*2 2^2];  

% Denominator is Js^2 + Bs + K (Spring constant (700 mNm/rev) converted to 
% Nm (Multiple by 10^(-3)) and rev to rad (Divide by 2pi))
% Inertia was calculated relative to the center of the link (9mm away from
% the counter weight and the motors) using superposition
% Friction was calculated using no load current and no load speed as it was
% assumed to be the friction the torque would need to overcome when there
% is no load on the motor

% Sensor Dynamics
% ---------------
%Sens0    =  0; % Sensor gain is the max/min sensor voltage (5V)
%SensSat0 =  0; % Angular range is 180 degrees which is equivalent to pi

% Static Friction
% ---------------

%StFric0 = 0; 

% static friction is calculated through uSF (converted to m from um) * mass of the entire sphereical wrist ignoring mass of Q0
% Q0 was ignored because it was assumed the only mass acting from this
% motor were the rotors which were of negligible mass.

% =============================
% Q1 : Rotation about x-axis
% =============================

% Amplifier Dynamics
% ------------------
%Amp0n   = [0 0 0];               % Numerator 
%Amp0d   = [0 0 0];               % Denominator

%AmpSat0 = 0;                        

% Electrical Motor Dynamics
% -------------------------
%Elec0n  = [0 0 1];               % Numerator
%Elec0d  = [0 0 0];     % The denominator is sL + R where L is 0.362 mH and R is 5.39 Ohms

% Torque Const & Back EMF
% -----------------------
%TConst0  = 0;

%BackEMF0 = 0; 

% Inverse of the speed constant (875 rpm/v) after converting rpm to rad/s 
% in order to multiply output of mechanical dynamic to get voltage gain

% Mechanical Motor Dynamics
% -------------------------
%Mech0n  = [0 1 0];               % Numerator
%Mech0d  = [0 0 0];  

% Denominator is Js^2 + Bs + K (Spring constant (700 mNm/rev) converted to 
% Nm (Multiple by 10^(-3)) and rev to rad (Divide by 2pi))
% Inertia was calculated relative to the center of the link (9mm away from
% the counter weight and the motors) using superposition
% Friction was calculated using no load current and no load speed as it was
% assumed to be the friction the torque would need to overcome when there
% is no load on the motor

% Sensor Dynamics
% ---------------
%Sens0    =  0; % Sensor gain is the max/min sensor voltage (5V)
%SensSat0 =  0; % Angular range is 180 degrees which is equivalent to pi

% Static Friction
% ---------------

%StFric0 = 0; 
% ==================
% TRANSFER FUNCTIONS
% ==================
% Compute transfer functions from above values and perform system analysis
% You may prefer to put this section in a separate .m file
