clc
clear
%%
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    datafile1 = sprintf("Result14MPSNormal%1d.mat",i);
    TestData = load(datafile1);
    TestData = TestData.CombinedSimOUT;
    TestResults14MPSNormal.(temp_var1) = TestData;
end
%% Make plots PPO 14m/s Extreme
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    datafile1 = sprintf("Result14MPSExtreme%1d.mat",i);
    TestData = load(datafile1);
    TestData = TestData.CombinedSimOUT;
    TestResults14MPSExtreme.(temp_var1) = TestData;
end
%% Make plots PPO 17m/s Normal
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    datafile1 = sprintf("Result17MPSNormal%1d.mat",i);
    TestData = load(datafile1);
    TestData = TestData.CombinedSimOUT;
    TestResults17MPSNormal.(temp_var1) = TestData;
end
%% Make plots PPO 14m/s Extreme
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    datafile1 = sprintf("Result17MPSExtreme%1d.mat",i);
    TestData = load(datafile1);
    TestData = TestData.CombinedSimOUT;
    TestResults17MPSExtreme.(temp_var1) = TestData;
end
%%
testN14p1 = TestResults14MPSNormal.OutData_1(:,8);
testN14p2 = TestResults14MPSNormal.OutData_1(:,8);
testN14p3 = TestResults14MPSNormal.OutData_1(:,8);
testN14p4 = TestResults14MPSNormal.OutData_1(:,8);
testN14p5 = TestResults14MPSNormal.OutData_1(:,8);
testN14p6 = TestResults14MPSNormal.OutData_1(:,8);
testN14p7 = TestResults14MPSNormal.OutData_1(:,8);
testN14p8 = TestResults14MPSNormal.OutData_1(:,8);
testN14p9 = TestResults14MPSNormal.OutData_1(:,8);
testN14p10 = TestResults14MPSNormal.OutData_1(:,8);
testN14fullRotorTorque = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN14fullRotorTorque = mean(testN14fullRotorTorque,"all");
sigmatestN14fullRotorTorque = std(testN14fullRotorTorque,0,"all");
%%
testN14p1 = TestResults14MPSNormal.OutData_1(:,16);
testN14p2 = TestResults14MPSNormal.OutData_1(:,16);
testN14p3 = TestResults14MPSNormal.OutData_1(:,16);
testN14p4 = TestResults14MPSNormal.OutData_1(:,16);
testN14p5 = TestResults14MPSNormal.OutData_1(:,16);
testN14p6 = TestResults14MPSNormal.OutData_1(:,16);
testN14p7 = TestResults14MPSNormal.OutData_1(:,16);
testN14p8 = TestResults14MPSNormal.OutData_1(:,16);
testN14p9 = TestResults14MPSNormal.OutData_1(:,16);
testN14p10 = TestResults14MPSNormal.OutData_1(:,16);
testN14fullTower = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN14fullTower = mean(testN14fullTower,"all");
sigmatestN14fullTower = std(testN14fullTower,0,"all");
%%
testN14p1 = TestResults14MPSNormal.OutData_1(:,18);
testN14p2 = TestResults14MPSNormal.OutData_1(:,18);
testN14p3 = TestResults14MPSNormal.OutData_1(:,18);
testN14p4 = TestResults14MPSNormal.OutData_1(:,18);
testN14p5 = TestResults14MPSNormal.OutData_1(:,18);
testN14p6 = TestResults14MPSNormal.OutData_1(:,18);
testN14p7 = TestResults14MPSNormal.OutData_1(:,18);
testN14p8 = TestResults14MPSNormal.OutData_1(:,18);
testN14p9 = TestResults14MPSNormal.OutData_1(:,18);
testN14p10 = TestResults14MPSNormal.OutData_1(:,18);
testN14fullflap = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN14fullflap = mean(testN14fullflap,"all");
sigmatestN14fullflap = std(testN14fullflap,0,"all");
%%
testN14p1 = TestResults14MPSNormal.OutData_1(:,19);
testN14p2 = TestResults14MPSNormal.OutData_1(:,19);
testN14p3 = TestResults14MPSNormal.OutData_1(:,19);
testN14p4 = TestResults14MPSNormal.OutData_1(:,19);
testN14p5 = TestResults14MPSNormal.OutData_1(:,19);
testN14p6 = TestResults14MPSNormal.OutData_1(:,19);
testN14p7 = TestResults14MPSNormal.OutData_1(:,19);
testN14p8 = TestResults14MPSNormal.OutData_1(:,19);
testN14p9 = TestResults14MPSNormal.OutData_1(:,19);
testN14p10 = TestResults14MPSNormal.OutData_1(:,19);
testN14fulledge = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN14fulledge = mean(testN14fulledge,"all");
sigmatestN14fulledge = std(testN14fulledge,0,"all");
%%
testN14p1 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p2 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p3 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p4 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p5 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p6 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p7 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p8 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p9 = TestResults14MPSExtreme.OutData_1(:,8);
testN14p10 = TestResults14MPSExtreme.OutData_1(:,8);
testE14fullRotorTorque = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE14fullRotorTorque = mean(testE14fullRotorTorque,"all");
sigmatestE14fullRotorTorque = std(testE14fullRotorTorque,0,"all");
%%
testN14p1 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p2 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p3 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p4 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p5 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p6 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p7 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p8 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p9 = TestResults14MPSExtreme.OutData_1(:,16);
testN14p10 = TestResults14MPSExtreme.OutData_1(:,16);
testE14fullTower = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE14fullTower = mean(testE14fullTower,"all");
sigmatestE14fullTower = std(testE14fullTower,0,"all");
%%
testN14p1 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p2 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p3 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p4 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p5 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p6 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p7 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p8 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p9 = TestResults14MPSExtreme.OutData_1(:,18);
testN14p10 = TestResults14MPSExtreme.OutData_1(:,18);
testE14fullflap = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE14fullflap = mean(testE14fullflap,"all");
sigmatestE14fullflap = std(testE14fullflap,0,"all");
%%
testN14p1 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p2 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p3 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p4 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p5 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p6 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p7 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p8 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p9 = TestResults14MPSExtreme.OutData_1(:,19);
testN14p10 = TestResults14MPSExtreme.OutData_1(:,19);
testE14fulledge = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE14fulledge = mean(testE14fulledge,"all");
sigmatestE14fulledge = std(testE14fulledge,0,"all");
%%
testN14p1 = TestResults17MPSNormal.OutData_1(:,8);
testN14p2 = TestResults17MPSNormal.OutData_1(:,8);
testN14p3 = TestResults17MPSNormal.OutData_1(:,8);
testN14p4 = TestResults17MPSNormal.OutData_1(:,8);
testN14p5 = TestResults17MPSNormal.OutData_1(:,8);
testN14p6 = TestResults17MPSNormal.OutData_1(:,8);
testN14p7 = TestResults17MPSNormal.OutData_1(:,8);
testN14p8 = TestResults17MPSNormal.OutData_1(:,8);
testN14p9 = TestResults17MPSNormal.OutData_1(:,8);
testN14p10 = TestResults17MPSNormal.OutData_1(:,8);
testN17fullRotorTorque = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN17fullRotorTorque = mean(testN17fullRotorTorque,"all");
sigmatestN17fullRotorTorque = std(testN17fullRotorTorque,0,"all");
%%
testN14p1 = TestResults17MPSNormal.OutData_1(:,16);
testN14p2 = TestResults17MPSNormal.OutData_1(:,16);
testN14p3 = TestResults17MPSNormal.OutData_1(:,16);
testN14p4 = TestResults17MPSNormal.OutData_1(:,16);
testN14p5 = TestResults17MPSNormal.OutData_1(:,16);
testN14p6 = TestResults17MPSNormal.OutData_1(:,16);
testN14p7 = TestResults17MPSNormal.OutData_1(:,16);
testN14p8 = TestResults17MPSNormal.OutData_1(:,16);
testN14p9 = TestResults17MPSNormal.OutData_1(:,16);
testN14p10 = TestResults17MPSNormal.OutData_1(:,16);
testN17fullTower = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN17fullTower = mean(testN17fullTower,"all");
sigmatestN17fullTower = std(testN17fullTower,0,"all");
%%
testN14p1 = TestResults17MPSNormal.OutData_1(:,18);
testN14p2 = TestResults17MPSNormal.OutData_1(:,18);
testN14p3 = TestResults17MPSNormal.OutData_1(:,18);
testN14p4 = TestResults17MPSNormal.OutData_1(:,18);
testN14p5 = TestResults17MPSNormal.OutData_1(:,18);
testN14p6 = TestResults17MPSNormal.OutData_1(:,18);
testN14p7 = TestResults17MPSNormal.OutData_1(:,18);
testN14p8 = TestResults17MPSNormal.OutData_1(:,18);
testN14p9 = TestResults17MPSNormal.OutData_1(:,18);
testN14p10 = TestResults17MPSNormal.OutData_1(:,18);
testN17fullflap = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN17fullflap = mean(testN17fullflap,"all");
sigmatestN17fullflap = std(testN17fullflap,0,"all");
%%
testN14p1 = TestResults17MPSNormal.OutData_1(:,19);
testN14p2 = TestResults17MPSNormal.OutData_1(:,19);
testN14p3 = TestResults17MPSNormal.OutData_1(:,19);
testN14p4 = TestResults17MPSNormal.OutData_1(:,19);
testN14p5 = TestResults17MPSNormal.OutData_1(:,19);
testN14p6 = TestResults17MPSNormal.OutData_1(:,19);
testN14p7 = TestResults17MPSNormal.OutData_1(:,19);
testN14p8 = TestResults17MPSNormal.OutData_1(:,19);
testN14p9 = TestResults17MPSNormal.OutData_1(:,19);
testN14p10 = TestResults17MPSNormal.OutData_1(:,19);
testN17fulledge = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestN17fulledge = mean(testN17fulledge,"all");
sigmatestN17fulledge = std(testN17fulledge,0,"all");
%%
testN14p1 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p2 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p3 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p4 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p5 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p6 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p7 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p8 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p9 = TestResults17MPSExtreme.OutData_1(:,8);
testN14p10 = TestResults17MPSExtreme.OutData_1(:,8);
testE17fullRotorTorque = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE17fullRotorTorque = mean(testE17fullRotorTorque,"all");
sigmatestE17fullRotorTorque = std(testE17fullRotorTorque,0,"all");
%%
testN14p1 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p2 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p3 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p4 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p5 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p6 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p7 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p8 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p9 = TestResults17MPSExtreme.OutData_1(:,16);
testN14p10 = TestResults17MPSExtreme.OutData_1(:,16);
testE17fullTower = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE17fullTower = mean(testE17fullTower,"all");
sigmatestE17fullTower = std(testE17fullTower,0,"all");
%%
testN14p1 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p2 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p3 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p4 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p5 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p6 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p7 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p8 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p9 = TestResults17MPSExtreme.OutData_1(:,18);
testN14p10 = TestResults17MPSExtreme.OutData_1(:,18);
testE17fullflap = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE17fullflap = mean(testE17fullflap,"all");
sigmatestE17fullflap = std(testE17fullflap,0,"all");
%%
testN14p1 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p2 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p3 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p4 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p5 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p6 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p7 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p8 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p9 = TestResults17MPSExtreme.OutData_1(:,19);
testN14p10 = TestResults17MPSExtreme.OutData_1(:,19);
testE17fulledge = cat(2,testN14p1,testN14p2,testN14p3,testN14p4,testN14p5,testN14p6,testN14p7,testN14p8,testN14p9,testN14p10);
mutestE17fulledge = mean(testE17fulledge,"all");
sigmatestE17fulledge = std(testE17fulledge,0,"all");