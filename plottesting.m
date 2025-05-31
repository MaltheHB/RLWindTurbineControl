% Test Agent
load("Coefficients1.mat")
load("Agent140.mat","saved_agent")
%%
mdl_rl = "SystemSimulationPPONew";
open_system(mdl_rl);
%%
agentblk = mdl_rl + "/RL Agent";
open_system(get_param(agentblk,"Parent"));
%%
load("Coefficients2.mat")
TMax = 3600;
