% PPO test: 14 MPS Normal
for i = 1:10
filename=sprintf("init14MPSNormal%1d.mat",i);
load(filename);
sim SystemSimulationNoRL;
CombinedSimOUT = cat(2,OutData,CostData,Observations);
fname1 = sprintf('Result14MPSNormal%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedSimOUT");
CombinedSimOUTLong = DEL;
fname1 = sprintf('DELResults14MPSNormal%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedSimOUTLong");
end
%% PPO test: 14 MPS Extreme
for i = 1:10
filename=sprintf("init14MPSExtreme%1d.mat",i);
load(filename);
sim SystemSimulationNoRL;
CombinedSimOUT = cat(2,OutData,CostData,Observations);
fname1 = sprintf('Result14MPSExtreme%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedSimOUT");
CombinedSimOUTLong = DEL;
fname1 = sprintf('DELResults14MPSExtreme%1d.mat',i);
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedSimOUTLong");
end