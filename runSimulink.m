

sim SystemSimulationPPOTrained;
CombinedPPOSimOUT = cat(2,CostData,Observations,Actions);
fname1 = sprintf('CombinedPPOSimOUT.mat');
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUT");
CombinedPPOSimOUTLong = cat(2,OutData,Gains);
fname1 = sprintf('CombinedPPOSimOUTLong.mat');
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename1 = fullfile(destination,fname1);
save(filename1,"CombinedPPOSimOUTLong");
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
