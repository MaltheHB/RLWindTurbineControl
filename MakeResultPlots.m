%% Make plots PPO 14m/s Normal
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    temp_var2 = strcat('DEL_',num2str(i));
    datafile1 = sprintf("PPOagentResult14MPSNormal%1d.mat",i);
    datafile2 = sprintf("PPOagentDELResults14MPSNormal%1d.mat",i);
    TestData = load(datafile1);
    DELData = load(datafile2);
    TestData = TestData.CombinedPPOSimOUT;
    DELData = DELData.CombinedPPOSimOUTLong;
    TestResults14MPSNormal.(temp_var1) = TestData;
    DEL14MPSNormal.(temp_var2) = DELData;
end
%% DEL Results 14MPS Normal
del1 = DEL14MPSNormal.DEL_1;
del2 = DEL14MPSNormal.DEL_2;
del3 = DEL14MPSNormal.DEL_3;
del4 = DEL14MPSNormal.DEL_4;
del5 = DEL14MPSNormal.DEL_5;
del6 = DEL14MPSNormal.DEL_6;
del7 = DEL14MPSNormal.DEL_7;
del8 = DEL14MPSNormal.DEL_8;
del9 = DEL14MPSNormal.DEL_9;
del10 = DEL14MPSNormal.DEL_10;
PPODELNTM14 = cat(1,del1,del2,del3,del4,del5,del6,del7,del8,del9,del10);
meanPPODELNTM14 = mean(PPODELNTM14,1,"omitmissing");

%% calc Mean Gen Pwr
dat1 = TestResults14MPSNormal.OutData_1(:,24)/1000;
dat2 = TestResults14MPSNormal.OutData_2(:,24)/1000;
dat3 = TestResults14MPSNormal.OutData_3(:,24)/1000;
dat4 = TestResults14MPSNormal.OutData_4(:,24)/1000;
dat5 = TestResults14MPSNormal.OutData_5(:,24)/1000;
dat6 = TestResults14MPSNormal.OutData_6(:,24)/1000;
dat7 = TestResults14MPSNormal.OutData_7(:,24)/1000;
dat8 = TestResults14MPSNormal.OutData_8(:,24)/1000;
dat9 = TestResults14MPSNormal.OutData_9(:,24)/1000;
dat10 = TestResults14MPSNormal.OutData_10(:,24)/1000;
CombinedGenPwr = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestGenPwr = mean(CombinedGenPwr,2);
std10TestGenPwr = std(CombinedGenPwr,0,2);
overallStdGenPwr = std(CombinedGenPwr,0,"all");
overallMeanGenPwr = mean(CombinedGenPwr,"all");
STDErr10TestGenPwr = std10TestGenPwr/sqrt(10);
CI9510TestGenPwr = tinv([0.025 0.975],10-1);
GenPwr10TestCI95 = bsxfun(@times,STDErr10TestGenPwr,CI9510TestGenPwr);
%% calc Mean Rotor Speed
dat1 = TestResults14MPSNormal.OutData_1(:,6)*(pi/30);
dat2 = TestResults14MPSNormal.OutData_2(:,6)*(pi/30);
dat3 = TestResults14MPSNormal.OutData_3(:,6)*(pi/30);
dat4 = TestResults14MPSNormal.OutData_4(:,6)*(pi/30);
dat5 = TestResults14MPSNormal.OutData_5(:,6)*(pi/30);
dat6 = TestResults14MPSNormal.OutData_6(:,6)*(pi/30);
dat7 = TestResults14MPSNormal.OutData_7(:,6)*(pi/30);
dat8 = TestResults14MPSNormal.OutData_8(:,6)*(pi/30);
dat9 = TestResults14MPSNormal.OutData_9(:,6)*(pi/30);
dat10 = TestResults14MPSNormal.OutData_10(:,6)*(pi/30);
CombinedRotSpd = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestRotSpd = mean(CombinedRotSpd,2);
std10TestRotSpd = std(CombinedRotSpd,0,2);
overallMeanRotSpd = mean(CombinedRotSpd,"all");
overallStdRotSpd = std(CombinedRotSpd,0,"all");
STDErr10TestRotSpd = std10TestRotSpd/sqrt(10);
CI9510TestRotSpd = tinv([0.025 0.975],10-1);
RotSpd10TestCI95 = bsxfun(@times,STDErr10TestRotSpd,CI9510TestRotSpd);
%%
RotSpdstdlower = mean10TestRotSpd-std10TestRotSpd;
RotSpdstdupper = mean10TestRotSpd+std10TestRotSpd;
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure(Name='PPO14NTMGenPower')
plot(time,CombinedGenPwr,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
plot(time,ones(length(time),1).*(overallMeanGenPwr+overallStdGenPwr),LineStyle='--',Color='b')
plot(time,ones(length(time),1).*overallMeanGenPwr,LineStyle='--',Color='g')
plot(time,ones(length(time),1).*(overallMeanGenPwr-overallStdGenPwr),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Generator Power[MW]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Generator Power(10 runs+mean, overall mean \pm std )')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,mean10TestGenPwr-GenPwr10TestCI95,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')

ylabel('Generator Power[kW]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Generator Power(Confidence Interval)')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure(Name='PPO14NTMRotSpeed')
plot(time,CombinedRotSpd,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
plot(time,ones(length(time),1).*(overallMeanRotSpd+overallStdRotSpd),LineStyle='--',Color='b')
plot(time,ones(length(time),1).*overallMeanRotSpd,LineStyle='--',Color='g')
plot(time,ones(length(time),1).*(overallMeanRotSpd-overallStdRotSpd),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Rotor Speed(10 runs+mean, overall mean \pm std )')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,mean10TestRotSpd+RotSpd10TestCI95,':',Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Rotor Speed(Confidence interval)')
hold off
%% Make plots PPO 14m/s Extreme
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    temp_var2 = strcat('DEL_',num2str(i));
    datafile1 = sprintf("PPOagentResult14MPSExtreme%1d.mat",i);
    datafile2 = sprintf("PPOagentDELResults14MPSExtreme%1d.mat",i);
    TestData = load(datafile1);
    DELData = load(datafile2);
    TestData = TestData.CombinedPPOSimOUT;
    DELData = DELData.CombinedPPOSimOUTLong;
    TestResults14MPSExtreme.(temp_var1) = TestData;
    DEL14MPSExtreme.(temp_var2) = DELData;
end
%% DEL Results 14MPS Extreme
del1 = DEL14MPSExtreme.DEL_1;
del2 = DEL14MPSExtreme.DEL_2;
del3 = DEL14MPSExtreme.DEL_3;
del4 = DEL14MPSExtreme.DEL_4;
del5 = DEL14MPSExtreme.DEL_5;
del6 = DEL14MPSExtreme.DEL_6;
del7 = DEL14MPSExtreme.DEL_7;
del8 = DEL14MPSExtreme.DEL_8;
del9 = DEL14MPSExtreme.DEL_9;
del10 = DEL14MPSExtreme.DEL_10;
PPODELETM14 = cat(1,del1,del2,del3,del4,del5,del6,del7,del8,del9,del10);
meanPPODELETM14 = mean(PPODELETM14,1,"omitmissing");


%% calc Mean Gen Pwr
dat12 = TestResults14MPSExtreme.OutData_1(:,24)/1000;
dat22 = TestResults14MPSExtreme.OutData_2(:,24)/1000;
dat32 = TestResults14MPSExtreme.OutData_3(:,24)/1000;
dat42 = TestResults14MPSExtreme.OutData_4(:,24)/1000;
dat52 = TestResults14MPSExtreme.OutData_5(:,24)/1000;
dat62 = TestResults14MPSExtreme.OutData_6(:,24)/1000;
dat72 = TestResults14MPSExtreme.OutData_7(:,24)/1000;
dat82 = TestResults14MPSExtreme.OutData_8(:,24)/1000;
dat92 = TestResults14MPSExtreme.OutData_9(:,24)/1000;
dat102 = TestResults14MPSExtreme.OutData_10(:,24)/1000;
CombinedGenPwr2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestGenPwr2 = mean(CombinedGenPwr2,2);
std10TestGenPwr2 = std(CombinedGenPwr2,0,2);
overallMeanGenPwr2 = mean(mean10TestGenPwr2);
overallStdGenPwr2 = std(CombinedGenPwr2,0,"all");
STDErr10TestGenPwr2 = std10TestGenPwr2/sqrt(10);
CI9510TestGenPwr2 = tinv([0.025 0.975],10-1);
GenPwr210TestCI95 = bsxfun(@times,STDErr10TestGenPwr2,CI9510TestGenPwr2);
%% calc Mean Rotor Speed
dat12 = TestResults14MPSExtreme.OutData_1(:,6)*(pi/30);
dat22 = TestResults14MPSExtreme.OutData_2(:,6)*(pi/30);
dat32 = TestResults14MPSExtreme.OutData_3(:,6)*(pi/30);
dat42 = TestResults14MPSExtreme.OutData_4(:,6)*(pi/30);
dat52 = TestResults14MPSExtreme.OutData_5(:,6)*(pi/30);
dat62 = TestResults14MPSExtreme.OutData_6(:,6)*(pi/30);
dat72 = TestResults14MPSExtreme.OutData_7(:,6)*(pi/30);
dat82 = TestResults14MPSExtreme.OutData_8(:,6)*(pi/30);
dat92 = TestResults14MPSExtreme.OutData_9(:,6)*(pi/30);
dat102 = TestResults14MPSExtreme.OutData_10(:,6)*(pi/30);
CombinedRotSpd2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestRotSpd2 = mean(CombinedRotSpd2,2);
std10TestRotSpd2 = std(CombinedRotSpd2,0,2);
overallMeanRotSpd2 = mean(mean10TestRotSpd2);
overallStdRotSpd2 = std(CombinedRotSpd2,0,"all");
STDErr10TestRotSpd2 = std10TestRotSpd2/sqrt(10);
CI9510TestRotSpd2 = tinv([0.025 0.975],10-1);
RotSpd210TestCI95 = bsxfun(@times,STDErr10TestRotSpd2,CI9510TestRotSpd2);
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);

RGB = [0.7 0.7 0.7];
plot(time2,CombinedGenPwr2,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestGenPwr2,'r',LineWidth=1)
plot(time2,ones(length(time2),1).*(overallMeanGenPwr2+overallStdGenPwr2),LineStyle='--',Color='b')
plot(time2,ones(length(time2),1).*overallMeanGenPwr2,LineStyle='--',Color='g')
plot(time2,ones(length(time2),1).*(overallMeanGenPwr2-overallStdGenPwr2),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Generator Power[MW]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Generator Power(10 runs+mean, overall mean \pm std )')
hold off
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);

RGB = [0.7 0.7 0.7];
plot(time2,mean10TestGenPwr2+GenPwr210TestCI95,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestGenPwr2,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')
ylabel('Generator Power[kW]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Generator Power(Confidence Interval)')
hold off
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);
RGB = [0.7 0.7 0.7];

plot(time2,CombinedRotSpd2,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestRotSpd2,'r',LineWidth=1)
plot(time,ones(length(time),1).*(overallMeanRotSpd2+overallStdRotSpd2),LineStyle='--',Color='b')
plot(time,ones(length(time),1).*overallMeanRotSpd2,LineStyle='--',Color='g')
plot(time,ones(length(time),1).*(overallMeanRotSpd2-overallStdRotSpd2),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Rotor Speed(10 runs+mean, overall mean \pm std )')
hold off
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);
RGB = [0.7 0.7 0.7];

plot(time2,mean10TestRotSpd2+RotSpd210TestCI95,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestRotSpd2,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Rotor Speed(Confidence Interval)')
hold off

%% Make plots PPO 17m/s Normal
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    temp_var2 = strcat('DEL_',num2str(i));
    datafile1 = sprintf("PPOagentResult17MPSNormal%1d.mat",i);
    datafile2 = sprintf("PPOagentDELResults17MPSNormal%1d.mat",i);
    TestData = load(datafile1);
    DELData = load(datafile2);
    TestData = TestData.CombinedPPOSimOUT;
    DELData = DELData.CombinedPPOSimOUTLong;
    TestResults17MPSNormal.(temp_var1) = TestData;
    DEL17MPSNormal.(temp_var2) = DELData;
end
%% DEL Results 17MPS Normal
del1 = DEL17MPSNormal.DEL_1;
del2 = DEL17MPSNormal.DEL_2;
del3 = DEL17MPSNormal.DEL_3;
del4 = DEL17MPSNormal.DEL_4;
del5 = DEL17MPSNormal.DEL_5;
del6 = DEL17MPSNormal.DEL_6;
del7 = DEL17MPSNormal.DEL_7;
del8 = DEL17MPSNormal.DEL_8;
del9 = DEL17MPSNormal.DEL_9;
del10 = DEL17MPSNormal.DEL_10;
PPODELNTM17 = cat(1,del1,del2,del3,del4,del5,del6,del7,del8,del9,del10);
meanPPODELNTM17 = mean(PPODELNTM17,1,"omitmissing");
%% calc Mean Gen Pwr
dat1 = TestResults17MPSNormal.OutData_1(:,24)/1000;
dat2 = TestResults17MPSNormal.OutData_2(:,24)/1000;
dat3 = TestResults17MPSNormal.OutData_3(:,24)/1000;
dat4 = TestResults17MPSNormal.OutData_4(:,24)/1000;
dat5 = TestResults17MPSNormal.OutData_5(:,24)/1000;
dat6 = TestResults17MPSNormal.OutData_6(:,24)/1000;
dat7 = TestResults17MPSNormal.OutData_7(:,24)/1000;
dat8 = TestResults17MPSNormal.OutData_8(:,24)/1000;
dat9 = TestResults17MPSNormal.OutData_9(:,24)/1000;
dat10 = TestResults17MPSNormal.OutData_10(:,24)/1000;
CombinedGenPwr = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestGenPwr = mean(CombinedGenPwr,2);
std10TestGenPwr = std(CombinedGenPwr,0,2);
overallMeanGenPwr = mean(mean10TestGenPwr);
overallStdGenPwr = std(CombinedGenPwr,0,"all");
STDErr10TestGenPwr = std10TestGenPwr/sqrt(10);
CI9510TestGenPwr = tinv([0.025 0.975],10-1);
GenPwr10TestCI95 = bsxfun(@times,STDErr10TestGenPwr,CI9510TestGenPwr);
%% calc Mean Rotor Speed
dat1 = TestResults17MPSNormal.OutData_1(:,6)*(pi/30);
dat2 = TestResults17MPSNormal.OutData_2(:,6)*(pi/30);
dat3 = TestResults17MPSNormal.OutData_3(:,6)*(pi/30);
dat4 = TestResults17MPSNormal.OutData_4(:,6)*(pi/30);
dat5 = TestResults17MPSNormal.OutData_5(:,6)*(pi/30);
dat6 = TestResults17MPSNormal.OutData_6(:,6)*(pi/30);
dat7 = TestResults17MPSNormal.OutData_7(:,6)*(pi/30);
dat8 = TestResults17MPSNormal.OutData_8(:,6)*(pi/30);
dat9 = TestResults17MPSNormal.OutData_9(:,6)*(pi/30);
dat10 = TestResults17MPSNormal.OutData_10(:,6)*(pi/30);
CombinedRotSpd = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestRotSpd = mean(CombinedRotSpd,2);
std10TestRotSpd = std(CombinedRotSpd,0,2);
overallMeanRotSpd = mean(mean10TestRotSpd);
overallStdRotSpd = std(CombinedRotSpd,0,"all");
STDErr10TestRotSpd = std10TestRotSpd/sqrt(10);
CI9510TestRotSpd = tinv([0.025 0.975],10-1);
RotSpd10TestCI95 = bsxfun(@times,STDErr10TestRotSpd,CI9510TestRotSpd);
%%
time = TestResults17MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure(Name='PPO17NTMGenPower')
plot(time,CombinedGenPwr,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
plot(time,ones(length(time),1).*(overallMeanGenPwr+overallStdGenPwr),LineStyle='--',Color='b')
plot(time,ones(length(time),1).*overallMeanGenPwr,LineStyle='--',Color='g')
plot(time,ones(length(time),1).*(overallMeanGenPwr-overallStdGenPwr),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Generator Power[MW]')
xlim([0 3600])
title('PPO NTM 17 m/s Scenario: Generator Power(10 runs+mean, overall mean \pm std )')
hold off
%%
time = TestResults17MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,mean10TestGenPwr-GenPwr10TestCI95,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')

ylabel('Generator Power[kW]')
xlim([0 3600])
title('PPO NTM 17 m/s Scenario: Generator Power(Confidence Interval)')
hold off
%%
time = TestResults17MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure(Name='PPO17NTMRotSpeed')
plot(time,CombinedRotSpd,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
plot(time,ones(length(time),1).*(overallMeanRotSpd+overallStdRotSpd),LineStyle='--',Color='b')
plot(time,ones(length(time),1).*overallMeanRotSpd,LineStyle='--',Color='g')
plot(time,ones(length(time),1).*(overallMeanRotSpd-overallStdRotSpd),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO NTM 17 m/s Scenario: Rotor Speed(10 runs+mean, overall mean \pm std )')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,mean10TestRotSpd+RotSpd10TestCI95,':',Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
legend('Upper Confidence','Lower Confidence','Mean')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO NTM 17 m/s Scenario: Rotor Speed(Confidence interval)')
hold off
%% Make plots PPO 17m/s Extreme
for i=1:10
    temp_var1 = strcat('OutData_',num2str(i));
    temp_var2 = strcat('DEL_',num2str(i));
    datafile1 = sprintf("PPOagentResult17MPSExtreme%1d.mat",i);
    datafile2 = sprintf("PPOagentDELResults17MPSExtreme%1d.mat",i);
    TestData = load(datafile1);
    DELData = load(datafile2);
    TestData = TestData.CombinedPPOSimOUT;
    DELData = DELData.CombinedPPOSimOUTLong;
    TestResults17MPSExtreme.(temp_var1) = TestData;
    DEL17MPSExtreme.(temp_var2) = DELData;
end
%% calc Mean Gen Pwr
dat12 = TestResults17MPSExtreme.OutData_1(:,24)/1000;
dat22 = TestResults17MPSExtreme.OutData_2(:,24)/1000;
dat32 = TestResults17MPSExtreme.OutData_3(:,24)/1000;
dat42 = TestResults17MPSExtreme.OutData_4(:,24)/1000;
dat52 = TestResults17MPSExtreme.OutData_5(:,24)/1000;
dat62 = TestResults17MPSExtreme.OutData_6(:,24)/1000;
dat72 = TestResults17MPSExtreme.OutData_7(:,24)/1000;
dat82 = TestResults17MPSExtreme.OutData_8(:,24)/1000;
dat92 = TestResults17MPSExtreme.OutData_9(:,24)/1000;
dat102 = TestResults17MPSExtreme.OutData_10(:,24)/1000;
CombinedGenPwr2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestGenPwr2 = mean(CombinedGenPwr2,2);
std10TestGenPwr2 = std(CombinedGenPwr2,0,2);
overallMeanGenPwr2 = mean(mean10TestGenPwr2);
overallStdGenPwr2 = std(CombinedGenPwr2,0,"all");
STDErr10TestGenPwr2 = std10TestGenPwr2/sqrt(10);
CI9510TestGenPwr2 = tinv([0.025 0.975],10-1);
GenPwr210TestCI95 = bsxfun(@times,STDErr10TestGenPwr2,CI9510TestGenPwr2);
%% calc Mean Rotor Speed
dat12 = TestResults17MPSExtreme.OutData_1(:,6)*(pi/30);
dat22 = TestResults17MPSExtreme.OutData_2(:,6)*(pi/30);
dat32 = TestResults17MPSExtreme.OutData_3(:,6)*(pi/30);
dat42 = TestResults17MPSExtreme.OutData_4(:,6)*(pi/30);
dat52 = TestResults17MPSExtreme.OutData_5(:,6)*(pi/30);
dat62 = TestResults17MPSExtreme.OutData_6(:,6)*(pi/30);
dat72 = TestResults17MPSExtreme.OutData_7(:,6)*(pi/30);
dat82 = TestResults17MPSExtreme.OutData_8(:,6)*(pi/30);
dat92 = TestResults17MPSExtreme.OutData_9(:,6)*(pi/30);
dat102 = TestResults17MPSExtreme.OutData_10(:,6)*(pi/30);
CombinedRotSpd2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestRotSpd2 = mean(CombinedRotSpd2,2);
std10TestRotSpd2 = std(CombinedRotSpd2,0,2);
overallMeanRotSpd2 = mean(mean10TestRotSpd2);
overallStdRotSpd2 = std(CombinedRotSpd2,0,"all");
STDErr10TestRotSpd2 = std10TestRotSpd2/sqrt(10);
CI9510TestRotSpd2 = tinv([0.025 0.975],10-1);
RotSpd210TestCI95 = bsxfun(@times,STDErr10TestRotSpd2,CI9510TestRotSpd2);
%%
time2 = TestResults17MPSExtreme.OutData_1(:,1);

RGB = [0.7 0.7 0.7];
plot(time2,CombinedGenPwr2,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestGenPwr2,'r',LineWidth=1)
plot(time2,ones(length(time),1).*(overallMeanGenPwr2+overallStdGenPwr2),LineStyle='--',Color='b')
plot(time2,ones(length(time),1).*overallMeanGenPwr2,LineStyle='--',Color='g')
plot(time2,ones(length(time),1).*(overallMeanGenPwr2-overallStdGenPwr2),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Generator Power[MW]')
xlim([0 3600])
title('PPO ETM 17 m/s Scenario: Generator Power(10 runs+mean, overall mean \pm std )')
hold off
%%
time2 = TestResults17MPSExtreme.OutData_1(:,1);
RGB = [0.7 0.7 0.7];

plot(time2,CombinedRotSpd2,Color=RGB,LineWidth=0.5)
hold on
plot(time2,mean10TestRotSpd2,'r',LineWidth=1)
plot(time2,ones(length(time),1).*(overallMeanRotSpd2+overallStdRotSpd2),LineStyle='--',Color='b')
plot(time2,ones(length(time),1).*overallMeanRotSpd2,LineStyle='--',Color='g')
plot(time2,ones(length(time),1).*(overallMeanRotSpd2-overallStdRotSpd2),LineStyle='--',Color='b')
legend('Runs','','','','','','','','','','Mean','','Overall mean','Overall \pm Std')
xlabel('Time[s]')
ylabel('Rotor Speed[rad/s]')
xlim([0 3600])
title('PPO ETM 17 m/s Scenario: Rotor Speed(10 runs+mean, overall mean \pm std )')
hold off
%% DEL Results 17MPS Extreme
del1 = DEL17MPSExtreme.DEL_1;
del2 = DEL17MPSExtreme.DEL_2;
del3 = DEL17MPSExtreme.DEL_3;
del4 = DEL17MPSExtreme.DEL_4;
del5 = DEL17MPSExtreme.DEL_5;
del6 = DEL17MPSExtreme.DEL_6;
del7 = DEL17MPSExtreme.DEL_7;
del8 = DEL17MPSExtreme.DEL_8;
del9 = DEL17MPSExtreme.DEL_9;
del10 = DEL17MPSExtreme.DEL_10;
PPODELETM17 = cat(1,del1,del2,del3,del4,del5,del6,del7,del8,del9,del10);
meanPPODELETM17 = mean(PPODELETM17,1,"omitmissing");
%%
fi = "PPODELFullResults.mat";
save(fi,"meanPPODELNTM14","meanPPODELETM14","meanPPODELNTM17","meanPPODELETM17","PPODELNTM14","PPODELETM14","PPODELNTM17","PPODELETM17")
