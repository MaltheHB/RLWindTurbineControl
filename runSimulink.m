% PPO test: 14 MPS Normal
for i = 1:10
filename=sprintf("init14MPSNormal%1d.mat",i);
load(filename);
sim SystemSimulationPPONew;
CombinedPPOSimOUT = cat(2,OutData,CostData,Observations,Actions);
fname1 = sprintf('PPOagentResult14MPSNormal%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUT");
CombinedPPOSimOUTLong = DEL;
fname1 = sprintf('PPOagentDELResults14MPSNormal%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUTLong");
end
%% PPO test: 14 MPS Extreme
for i = 1:10
filename=sprintf("init14MPSExtreme%1d.mat",i);
load(filename);
sim SystemSimulationPPONew;
CombinedPPOSimOUT = cat(2,OutData,CostData,Observations,Actions);
fname1 = sprintf('PPOagentResult14MPSExtreme%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUT");
CombinedPPOSimOUTLong = DEL;
fname1 = sprintf('PPOagentDELResults14MPSExtreme%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUTLong");
end
%% PPO test: 17 MPS Normal
for o = 1:10
    filename3=sprintf("init17MPSNormal%1d.mat",o);
    load(filename3);
    sim SystemSimulationPPONew;
    CombinedPPOSimOUT = cat(2,OutData,CostData,Observations,Actions);
    fname1 = sprintf('PPOagentResult17MPSNormal%1d.mat',o);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedPPOSimOUT");
    CombinedPPOSimOUTLong = DEL;
    fname1 = sprintf('PPOagentDELResults17MPSNormal%1d.mat',o);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedPPOSimOUTLong");
end
%% PPO test: 17 MPS Extreme
for h = 1:10
    filename3=sprintf("init17MPSExtreme%1d.mat",h);
    load(filename3);
    sim SystemSimulationPPONew;
    CombinedPPOSimOUT = cat(2,OutData,CostData,Observations,Actions);
    fname1 = sprintf('PPOagentResult17MPSExtreme%1d.mat',h);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedPPOSimOUT");
    CombinedPPOSimOUTLong = DEL;
    fname1 = sprintf('PPOagentDELResults17MPSExtreme%1d.mat',h);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedPPOSimOUTLong");
end
%%
sim SystemSimulationNoRL;
CombinedBaselineSimOut = cat(2,CostData,Observations);
fname2 = sprintf('CombinedBaselineSimOut.mat');
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename2 = fullfile(destination,fname2);
save(filename2,"CombinedBaselineSimOut");
CombinedBaselineSimOutLong = cat(2,OutData,Gains);
fname2 = sprintf('CombinedBaselineSimOutLong.mat');
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename2 = fullfile(destination,fname2);
save(filename2,"CombinedBaselineSimOutLong");
%%
load("Coefficients1.mat")
%%
load("Coefficients2.mat")
