
for i=1:2
    sim SystemSimulationPPO;
    fnameKp = sprintf('KpDeltas%03d.mat',i);
    fnameKi = sprintf('KiDeltas%03d.mat',i);
    fname = sprintf('RandomizedGainsOutput%03d.mat',i);
    destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
    Kpfilename = fullfile(destination,fnameKp);
    Kifilename = fullfile(destination,fnameKi);
    filename = fullfile(destination,fname);
    save(Kpfilename,"OutKp");
    save(Kifilename,"OutKi");
    save(filename,"OutData");
end
%%
sim SystemSimulation;
fname = sprintf('baselineControllerOutput.mat');
destination = "C:\Users\malth\Desktop\Vestas OpenFast\RLWindTurbineControl\SimulinkResults";
filename = fullfile(destination,fname);
save(filename,"OutData");
data = load('baselineControllerOutput.mat');
data = data.OutData;
[TowerDEL, RotorDEL, BladeDEL] = RainflowCountBaseline(data);
GainsDELResults = zeros(3,5);
GainsDELResults(1,1) = TowerDEL;
GainsDELResults(1,2) = RotorDEL;
GainsDELResults(1,3) = BladeDEL;
GainsDELResults(1,4) = 0;
GainsDELResults(1,5) = 0;
for i=1:2
    fnameKp = sprintf('KpDeltas%03d.mat',i);
    fnameKi = sprintf('KiDeltas%03d.mat',i);
    fname = sprintf('RandomizedGainsOutput%03d.mat',i);
    data = load(fname);
    data = data.OutData;
    Kpdata = load(fnameKp);
    Kidata = load(fnameKi);
    Kpdata = Kpdata.OutKp(1,1);
    Kidata = Kidata.OutKi(1,1);
    [TowerDEL, RotorDEL, BladeDEL] = RainflowCountBaseline(data);
    GainsDELResults(i+1,1) = TowerDEL;
    GainsDELResults(i+1,2) = RotorDEL;
    GainsDELResults(i+1,3) = BladeDEL;
    GainsDELResults(i+1,4) = Kpdata;
    GainsDELResults(i+1,5) = Kidata;
end