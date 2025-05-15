
testData = load("baselineControllerOutput.mat");
testData = testData.OutData;
%%
[baselineTowerDEL, baselineRotorDEL, baselineBladeDEL] = RainflowCountBaseline(testData);

BaselineDEL = [baselineTowerDEL, baselineRotorDEL, baselineBladeDEL];

%%
TowerDELpartial = [];
RotorDELpartial = [];
BladeDELpartial = [];
for i= 1:1000
    [baselineTowerDEL, baselineRotorDEL, baselineBladeDEL] = RainflowCountBaseline(testData(((i-1)*10+1):(i*10),:));
    TowerDELpartial(i) = baselineTowerDEL;
    RotorDELpartial(i) = baselineRotorDEL;
    BladeDELpartial(i) = baselineBladeDEL;
end

BaselineDEL = [mean(TowerDELpartial), mean(RotorDELpartial), mean(BladeDELpartial)];

