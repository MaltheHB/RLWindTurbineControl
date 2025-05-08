
testData = load("Baseline.mat");
testData = testData.OutData;

[baselineTowerDEL, baselineRotorDEL, baselineBladeDEL] = RainflowCountBaseline(testData);

