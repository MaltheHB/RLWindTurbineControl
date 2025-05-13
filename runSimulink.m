
for i=1:5
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