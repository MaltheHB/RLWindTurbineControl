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
%% PPO test: 17 MPS Normal
for o = 1:10
    filename3=sprintf("init17MPSNormal%1d.mat",o);
    load(filename3);
    sim SystemSimulationNoRL;
    CombinedSimOUT = cat(2,OutData,CostData,Observations);
    fname1 = sprintf('Result17MPSNormal%1d.mat',o);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedSimOUT");
    CombinedSimOUTLong = DEL;
    fname1 = sprintf('DELResults17MPSNormal%1d.mat',o);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedSimOUTLong");
end
%% PPO test: 17 MPS Extreme
for h = 1:10
    filename3=sprintf("init17MPSExtreme%1d.mat",h);
    load(filename3);
    sim SystemSimulationNoRL;
    CombinedSimOUT = cat(2,OutData,CostData,Observations);
    fname1 = sprintf('Result17MPSExtreme%1d.mat',h);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedSimOUT");
    CombinedSimOUTLong = DEL;
    fname1 = sprintf('DELResults17MPSExtreme%1d.mat',h);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\RLWindTurbineControl\SimulinkResults";
    filename1 = fullfile(destination,fname1);
    save(filename1,"CombinedSimOUTLong");
end