%% PPO Algorithm
% ------------------------------------------------------------
clc
clear
load("Coefficients1.mat")
% Actor Network
obsDim = 9;
actDim = 2;

obsInfo = rlNumericSpec([obsDim 1], 'Name','observations');

% Example controller bounds (replace with your actual bounds)
KpBounds = [0.001 0.1];
KiBounds = [0.001 0.1];

actInfo = rlNumericSpec([actDim 1], ...
    'LowerLimit',[KpBounds(1); KiBounds(1)], ...
    'UpperLimit',[KpBounds(2); KiBounds(2)], ...
    'Name','controller_gains' );
actorLayers = [
    featureInputLayer(obsDim, 'Normalization','none',Name="state")
    fullyConnectedLayer(64, 'Name','fc1')
    tanhLayer('Name','tanh1')
    fullyConnectedLayer(64, 'Name','fc2')
    tanhLayer('Name','tanh2')
    fullyConnectedLayer(64, 'Name','fc3')
    tanhLayer('Name','tanh3')
];

% Output heads: mean and std (log sigma)
meanLayer = [
    fullyConnectedLayer(actDim, Name = 'mean')
    tanhLayer(Name="tanhMean")
    scalingLayer(Name = "Scale", ...
        Scale = [diff(KpBounds)/2; diff(KiBounds)/2], ...
        Bias = [sum(KpBounds)/2; sum(KiBounds)/2])
];

stdLayer = [
    fullyConnectedLayer(actDim, Name="logstd")
    softplusLayer(Name ="std")
];

actorNet = layerGraph(actorLayers);
actorNet = addLayers(actorNet, meanLayer);
actorNet = addLayers(actorNet, stdLayer);
actorNet = connectLayers(actorNet, "tanh3", "mean/in");
actorNet = connectLayers(actorNet, "tanh3", "logstd/in");

actor = rlContinuousGaussianActor(actorNet, obsInfo, actInfo, ActionMeanOutputNames="Scale",ActionStandardDeviationOutputNames="std");
% Value Network
criticNet = [
    featureInputLayer(obsDim,'Normalization','none','Name','state')
    fullyConnectedLayer(64, 'Name','fc1')
    tanhLayer('Name','tanh1')
    fullyConnectedLayer(64, 'Name','fc2')
    tanhLayer('Name','tanh2')
    fullyConnectedLayer(64, 'Name','fc3')
    tanhLayer('Name','tanh3')
    fullyConnectedLayer(1, 'Name','value')
];
critic = rlValueFunction(criticNet,obsInfo);

agentOpts = rlPPOAgentOptions( ...
    'ClipFactor', 0.2, ...
    'EntropyLossWeight', 0.01, ...
    'MiniBatchSize',5, ...
    'ExperienceHorizon',10, ...
    'AdvantageEstimateMethod', 'gae', ...
    'GAEFactor', 0.95, ...
    'SampleTime', 10);  

agent = rlPPOAgent(actor, critic, agentOpts);


%%
TMax  = 10000;       % total duration in wind file (s) ― see `AnalysisTime`
env = rlSimulinkEnv('SystemSimulationPPONew','SystemSimulationPPONew/RL Agent',obsInfo,actInfo);
%env.ResetFcn = @(in) setModelParameter(in,'StopTime',num2str(Tend));
env.UseFastRestart = "on";
trainOpts = rlTrainingOptions( ...
    MaxEpisodes = 10, ...
    MaxStepsPerEpisode = 20, ...
    StopOnError= "off", ...
    ScoreAveragingWindowLength = 25, ...
    Verbose = true, ...
    Plots = "training-progress");
    %StopTrainingCriteria="GlobalStepCount",...
    %StopTrainingValue=4000,...
trainingStats = train(agent, env, trainOpts);
%%
trainingStats.TrainingOptions.MaxEpisodes = 20;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 30;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 40;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 50;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 60;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 70;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 80;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 90;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 100;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
trainingStats.TrainingOptions.MaxEpisodes = 110;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 120;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 130;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 140;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 150;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 160;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 170;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 180;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 190;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
trainingStats.TrainingOptions.MaxEpisodes = 200;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 210;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 220;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 230;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 240;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 250;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
trainingStats.TrainingOptions.MaxEpisodes = 260;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
trainingStats.TrainingOptions.MaxEpisodes = 270;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
trainingStats.TrainingOptions.MaxEpisodes = 280;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 290;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 300;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 310;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 320;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 330;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 340;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 350;
load("Coefficients3.mat")
TMax = 10000;
%%
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 360;
load("Coefficients1.mat")
TMax = 10000;

trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 370;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 380;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 390;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 400;
load("Coefficients5.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 410;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 420;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 430;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 440;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 450;
load("Coefficients1.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 460;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 470;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 480;
load("Coefficients3.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 490;
load("Coefficients4.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
trainingStats.TrainingOptions.MaxEpisodes = 500;
load("Coefficients2.mat")
TMax = 10000;
trainingStats = train(agent, env,trainingStats);
%%
%%
for i=1:100
 trainingStats = train(agent, env,trainingStats);
end
%%
for i=1:889
 trainingStats = train(agent, env,trainingStats);
end
%%
save("NewAgent.mat", "agent");
%%
plot(OutData(:,24))
%% Deep Neural Network Predictor (regression)
% ------------------------------------------------------------
Ts    = 0.05;     % sample time in wind file (s)  ― see TimeStep  in *.inp
SampleData = load("baselineControllerOutput.mat");

% Actor Network
obsDim = 5;
actDim = 2;

obsInfo = rlNumericSpec([obsDim 1], 'Name','observations');

% Example controller bounds (replace with your actual bounds)
KpBounds = [0.01 1.0];
KiBounds = [0.01 1.0];

actInfo = rlNumericSpec([actDim 1], ...
    'LowerLimit',[KpBounds(1); KiBounds(1)], ...
    'UpperLimit',[KpBounds(2); KiBounds(2)], ...
    'Name','controller_gains' );
actorLayers = [
    featureInputLayer(obsDim, 'Normalization','none',Name="state")
    fullyConnectedLayer(128, 'Name','fc1')
    tanhLayer('Name','tanh1')
    fullyConnectedLayer(128, 'Name','fc2')
    tanhLayer('Name','tanh2')
];

% Output heads: mean and std (log sigma)
meanLayer = [
    fullyConnectedLayer(actDim, Name = 'mean')
    tanhLayer(Name="tanhMean")
    scalingLayer(Name = "Scale", ...
        Scale = [diff(KpBounds)/2; diff(KiBounds)/2], ...
        Bias = [sum(KpBounds)/2; sum(KiBounds)/2])
];

stdLayer = [
    fullyConnectedLayer(actDim, Name="logstd")
    softplusLayer(Name ="std") % ensures std > 0
];

actorNet = layerGraph(actorLayers);
actorNet = addLayers(actorNet, meanLayer);
actorNet = addLayers(actorNet, stdLayer);
actorNet = connectLayers(actorNet, "tanh2", "mean/in");
actorNet = connectLayers(actorNet, "tanh2", "logstd/in");

actor = rlContinuousGaussianActor(actorNet, obsInfo, actInfo, ...
    ActionMeanOutputNames="Scale", ...
    ActionStandardDeviationOutputNames="std");

% Value Network
criticNet = [
    featureInputLayer(obsDim,'Normalization','none','Name','state')
    fullyConnectedLayer(128, 'Name','fc1')
    reluLayer('Name','relu1')
    fullyConnectedLayer(128, 'Name','fc2')
    reluLayer('Name','relu2')
    fullyConnectedLayer(1, 'Name','value')
];

criticOpts = rlRepresentationOptions('LearnRate',3e-4);

critic = rlValueRepresentation(criticNet, obsInfo, ...
    'Observation','state', criticOpts );

agentOpts = rlPPOAgentOptions( ...
    'ClipFactor', 0.2, ...
    'EntropyLossWeight', 0.01, ...
    'MiniBatchSize', 1, ...
    'ExperienceHorizon', 1000, ...
    'AdvantageEstimateMethod','gae', ...
    'GAEFactor',0.95, ...
    'SampleTime',Ts);

agent = rlPPOAgent(actor, critic, agentOpts);

Observations = [];
CostData     = [];

% Simulation environment setup
Tend     = 30;                           % total duration (s)
MaxSteps = round(Tend/Ts);              % number of steps
simOpts  = rlSimulationOptions(MaxSteps=MaxSteps);

mdl      = "SystemSimulationPPO";
agentBlk = mdl + "/RL Agent";

% Disable fast restart so that the InflowWind S-Function reloads the .inp file
env = rlSimulinkEnv(mdl, agentBlk, obsInfo, actInfo, ...
                   'UseFastRestart','off');

% Custom reset function to set stop time and force a full model reload
env.ResetFcn = @(in)localReset(in, Tend);

% Training options
trainOpts = rlTrainingOptions( ...
    MaxEpisodes = 400, ...
    MaxStepsPerEpisode = MaxSteps, ...
    ScoreAveragingWindowLength = 20, ...
    Verbose = false, ...
    Plots = "training-progress");

trainingStats = train(agent, env, trainOpts);

% Local helper function for environment reset
function in = localReset(in, Tend)
    % 1) Update the Simulink stop time
    in = setModelParameter(in, 'StopTime', num2str(Tend));
    % 2) Close & reopen the model to force the S-Function to reload the wind file
    bdclose('SystemSimulationPPO');
    open_system('SystemSimulationPPO');
end