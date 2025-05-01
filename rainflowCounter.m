
TurbineLoads = OutData(:,[1 8 9 16 17 18 19 2 24 6]);
% 1 = time, 2 = wind speed,
% 8 = Rotor Torque, 9 Rotor Thrust,
% 16 = Tower base moment, 17 = Out-of-phase moment
% 18 = flapwise bending moment, 19 = edgewise bending moment
% 24 Generator power,
%plot(Mbase)
%[CountTowerBase, hist, edges, rmm, idx] = rainflow(TurbineLoads(:,4),10);
%histogram(BinEdges=edges', BinCounts=sum(hist,2))
%% Rainflow count Tower
% Tower base geometry
R1 = 3.0;                        % Outer radius [m]
t1 = 0.027;                      % Wall thickness [m]
r1 = R1-t1;
D1 = 2 * R1;                      % Outer diameter [m]
d1 = D1 - 2 * t1;                  % Inner diameter [m]
y1 = D1 / 2;                      % Distance to outer fiber [m]
%I1 = (pi/64) * (D1^4 - d1^4);      % Second moment of area [m^4]
I1 = (pi/4) * (R1^4 - r1^4);
TowerStress = (TurbineLoads(:,4)*1000*y1)/I1;

rf_tower = rainflow(TowerStress,100);

mT1 = 3;% S-N curve slope factor for steel
mT2 = 5;
N_ref = 5*10^6; % Cycles to failure at stress of 90e6 Pa
stress_ref = 355e6; % Stress range leading to failure at 5*10^6 cycles(assumed)
C = N_ref*(stress_ref);           % Fatigue Strength Coefficient
Towerdamage_combined = 0;
TowerdamageTime = [];
for i = 1:height(rf_tower)
    rangeT = rf_tower(i,2);
    meanT = rf_tower(i,3);
    countT = rf_tower(i,1);
    N_iT = N_ref*(stress_ref/rangeT)^mT2;
    if rangeT>stress_ref
        N_iT = N_ref*(stress_ref/rangeT)^mT1;
    end
    %N_iT = ((X_t+X_c-abs(2*lambda_ma*meanT-X_t+abs(X_c)))/(2*(lambda_mb)*rangeT))^m
    Towerdamage_combined = Towerdamage_combined + countT / N_iT;
    TowerdamageTime(i) =  Towerdamage_combined; 
end

towerLifetime = ((1/Towerdamage_combined)*200)/(60*60*24*365)
%% Rainflow count Rotor
% Rotor Hub geometry
D3 = 1.5;                        % Outer diameter [m]
t3 = 0.1;                         % Wall thickness [m]
d3 = D3 - 2*t3;                    % Inner diameter [m]
y3 = D3 / 2;                      % Distance from neutral axis to outer fiber [m]
I3 = (pi/64) * (D3^4 - d3^4);      % Second moment of area [m^4]

rotorStress = (TurbineLoads(:,2)*1000*y3)/I3;

rf_rotor = rainflow(rotorStress,100);

mR = 3;% S-N curve slope factor for steel
N_refR = 10^7; % Cycles to failure at stress of 90e6 Pa
stress_refR = 90e6; % Stress range leading to failure at 5*10^6 cycles(assumed)
C = N_refR*(stress_refR);           % Fatigue Strength Coefficient
rotordamage_combined = 0;
rotordamageTime = [];
for i = 1:height(rf_rotor)
    rangeR = rf_rotor(i,2);
    meanR = rf_rotor(i,3);
    countR = rf_rotor(i,1);
    N_iR = N_refR*(stress_refR/rangeR)^mR;
    %N_iT = ((X_t+X_c-abs(2*lambda_ma*meanT-X_t+abs(X_c)))/(2*(lambda_mb)*rangeT))^m
    rotordamage_combined = rotordamage_combined + countR / N_iR;
    rotordamageTime(i) =  rotordamage_combined; 
end

rotorLifetime = ((1/rotordamage_combined)*200)/(60*60*24*365)
%% Rainflow edgewise and flapwise
% blade geometry
% Blade root geometry from NREL 5-MW model
D2 = 3.0;                        % Outer diameter [m]
t2 = 0.05;                       % Wall thickness [m]
d2 = D2 - 2*t2;                    % Inner diameter [m]
y2 = D2 / 2;                      % Distance from neutral axis to outer fiber [m]
I2 = (pi/64) * (D2^4 - d2^4);      % Second moment of area [m^4]

flapwiseMoment = TurbineLoads(:,6).*1000;
edgewiseMoment = TurbineLoads(:,7).*1000;
% Convert moments to stress time series (in Pa)
stress_flap = (flapwiseMoment * y2) / I2;
stress_edge = (edgewiseMoment * y2) / I2;
% Optional: Total stress or worst-case
stress_combined = sqrt(stress_flap.^2 + stress_edge.^2);  % conservative

% Now perform rainflow counting and fatigue for each
rf_flap = rainflow(stress_flap,100);
rf_edge = rainflow(stress_edge,100);
rf_combined = rainflow(stress_combined,100);
[CountBlade, hist2, edges2, rmm2, idx2] = rainflow(stress_combined,100);  % optional
bladeCount = sum(hist2,2);
bladeBin = edges2;
bladeBinEdges = bladeBin(1:end-1);
% Define S-N curve parameters
m = 9;             % typical for composites (higher than steel)
X_t = 793.05*10^6; % Tension strenght in Pa
X_c = 542.49*10^6; % Compression strength in Pa
lambda_ma = 1.35*1.35*1.1*1.1*1; % partial safety factor short term strength
lambda_mb = 1.35*1.1*1.2; % partial safety factor fatigue strength
%C = 10^(20);           % example value — material-specific
totalCycles=sum(bladeCount)
% Compute damage (example for combined)
damage_combined = 0;
damageTime = [];
for i = 1:height(rf_combined)
    range = rf_combined(i,2);
    mean = rf_combined(i,3);
    amplitude = mean+(range/2);
    count = rf_combined(i,1);
    N_i = ((X_t+X_c-abs(2*lambda_ma*mean-X_t+abs(X_c)))/(2*(lambda_mb)*amplitude))^m
    damage_combined = damage_combined + count / N_i;
    damageTime(i) = damage_combined; 
end

fprintf('Fatigue damage (combined): %.5e\n', damage_combined);
lifetime = ((1/damage_combined)*200)/(60*60*24*365)
%histogram(BinEdges=edges2', BinCounts=sum(hist2,2))
plot(damageTime)
%%
plot(flapwiseMoment)
hold on
plot(stress_flap)
%%
% Parameters
m = 3;
sigma_D = 45;       % MPa
N_D = 1e7;          % cycles
C = sigma_D^m * N_D;

% Create N vector: from 1e4 to 1e10
N = logspace(4, 10, 200);

% Initialize stress
stress = zeros(size(N));

% Apply S-N curve with endurance limit
for i = 1:length(N)
    if N(i) <= N_D
        stress(i) = (C / N(i))^(1/m);
    else
        stress(i) = sigma_D;
    end
end

% Plot
figure;
loglog(N, stress, 'r-', 'LineWidth', 2);
grid on;
xlabel('Number of Cycles to Failure (N)');
ylabel('Stress Range (MPa)');
title('S–N Curve with Endurance Limit (Tower Steel)');