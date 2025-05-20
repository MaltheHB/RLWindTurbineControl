%% Neural Network
%% Deep Neural Network Predictor (regression)
% ------------------------------------------------------------

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

actor = rlContinuousGaussianActor(actorNet, obsInfo, actInfo, ActionMeanOutputNames="Scale",ActionStandardDeviationOutputNames="std");
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
    'AdvantageEstimateMethod', 'gae', ...
    'GAEFactor', 0.95, ...
    'SampleTime', 0.01);  

agent = rlPPOAgent(actor, critic, agentOpts);

Observations = [];

CostData = [];
%%
env = rlSimulinkEnv('SystemSimulationPPO','SystemSimulationPPO/RL Agent',obsInfo,actInfo,'UseFastRestart','on');
%env.UseFastRestart = "on";
trainOpts = rlTrainingOptions( ...
    MaxEpisodes = 1000, ...
    MaxStepsPerEpisode = 500, ...
    ScoreAveragingWindowLength = 20, ...
    Verbose = false, ...
    Plots = "training-progress");

trainingStats = train(agent, env, trainOpts);