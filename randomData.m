function [in1,in2] = randomData(mdl)
    In = Simulink.SimulationInput(mdl);
    Ex17 = 'C:\Users\malth\Desktop\Vestas OpenFAST\openFAST\5MW_Land_DLL_WTurb17MPSExtreme\5MW_Land_DLL_WTurb.fst';
    No17 = 'C:\Users\malth\Desktop\Vestas OpenFAST\openFAST\5MW_Land_DLL_WTurb17MPSNormal\5MW_Land_DLL_WTurb.fst';
    No14 = 'C:\Users\malth\Desktop\Vestas OpenFAST\openFAST\5MW_Land_DLL_WTurb14MPSNormal\5MW_Land_DLL_WTurb.fst';
    Ex14 = 'C:\Users\malth\Desktop\Vestas OpenFAST\openFAST\5MW_Land_DLL_WTurb14MPSExtreme\5MW_Land_DLL_WTurb.fst';
    Or17 = 'C:\Users\malth\Desktop\Vestas OpenFAST\openFAST\5MW_Land_DLL_WTurb\5MW_Land_DLL_WTurb.fst';
    
    randomObs = [0.0232*rand();0.0154*rand();rand()*20;rand()*20;rand()*20;rand()*11;1000000*rand();1000000*rand()];
    choice = randi([1 5],1);
    if choice == 1
                link = Or17;
                load("Coefficients1.mat","FAST_InputFileName");
    elseif choice == 2
                link = No14;
                load("init14MPSNormal2.mat","FAST_InputFileName");
    elseif choice == 3
                link = No17;
                load("Coefficients3.mat","FAST_InputFileName");
    elseif choice == 4
                link = Ex17;
                load("Coefficients4.mat","FAST_InputFileName");
    elseif choice == 5
                link = Ex14;
                load("Coefficients5.mat","FAST_InputFileName");
    end
    in1 = In.setVariable('Fast_InputFileName',link,'Workspace',mdl+"/FAST Nonlinear Wind Turbine");
    in2 = In.setVariable('initialObs',randomObs,'Workspace',mdl);
end