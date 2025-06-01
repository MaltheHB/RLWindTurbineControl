clc
clear
%%
load("Coefficients.mat");
for k = 1:9
    load("Coefficients.mat");
    foldername=sprintf('C:\\Users\\malth\\Desktop\\Vestas OpenFast\\Vestas OpenFAST\\openFAST\\5MW_Land_DLL_WTurb14MPSNormal%1d\\5MW_Land_DLL_WTurb.fst',k);
    FAST_InputFileName = foldername;
    TMax = 3600;
    fname1 = sprintf('init14MPSNormal%1d.mat',k);
    destination = "C:\Users\malth\Desktop\Vestas OpenFast\Vestas OpenFAST\simulinkModels";
    filename1 = fullfile(destination,fname1);
    save(filename1);
end
%%
for k = 1:10
    load("Coefficients.mat");
    foldername=sprintf('C:\\Users\\malth\\Desktop\\Vestas OpenFast\\Vestas OpenFAST\\openFAST\\5MW_Land_DLL_WTurb14MPSExtreme%1d\\5MW_Land_DLL_WTurb.fst',k);
    FAST_InputFileName = foldername;
    TMax = 3600;
    fname1 = sprintf('init14MPSExtreme%1d.mat',k);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\simulinkModels";
    filename1 = fullfile(destination,fname1);
    save(filename1);
end
%%
clc
clear
    load("Coefficients.mat");
    foldername=sprintf('C:\\Users\\malth\\Desktop\\Vestas OpenFast\\Vestas OpenFAST\\openFAST\\5MW_Land_DLL_WTurb14MPSNormal%1d\\5MW_Land_DLL_WTurb.fst',10);
    FAST_InputFileName = foldername;
    TMax = 3600;
    fname1 = sprintf('init14MPSNormal%1d.mat',10);
    destination = "C:\Users\malth\Desktop\Vestas OpenFast\Vestas OpenFAST\simulinkModels";
    filename1 = fullfile(destination,fname1);
    save(filename1);
%%
for j = 1:10
    load("Coefficients.mat");
    foldername=sprintf('C:\\Users\\malth\\Desktop\\Vestas OpenFAST\\openFAST\\5MW_Land_DLL_WTurb17MPSNormal%1d\\5MW_Land_DLL_WTurb.fst',j);
    FAST_InputFileName = foldername;
    TMax = 3600;
    fname1 = sprintf('init17MPSNormal%1d.mat',j);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\simulinkModels";
    filename1 = fullfile(destination,fname1);
    save(filename1);
end
%%
for l = 1:10
    load("Coefficients.mat");
    foldername=sprintf('C:\\Users\\malth\\Desktop\\Vestas OpenFAST\\openFAST\\5MW_Land_DLL_WTurb17MPSExtreme%1d\\5MW_Land_DLL_WTurb.fst',l);
    FAST_InputFileName = foldername;
    TMax = 3600;
    fname1 = sprintf('init17MPSExtreme%1d.mat',l);
    destination = "C:\Users\malth\Desktop\Vestas OpenFAST\simulinkModels";
    filename1 = fullfile(destination,fname1);
    save(filename1);
end