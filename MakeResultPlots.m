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


%% calc Mean Gen Pwr
dat1 = TestResults14MPSNormal.OutData_1(:,24);
dat2 = TestResults14MPSNormal.OutData_2(:,24);
dat3 = TestResults14MPSNormal.OutData_3(:,24);
dat4 = TestResults14MPSNormal.OutData_4(:,24);
dat5 = TestResults14MPSNormal.OutData_5(:,24);
dat6 = TestResults14MPSNormal.OutData_6(:,24);
dat7 = TestResults14MPSNormal.OutData_7(:,24);
dat8 = TestResults14MPSNormal.OutData_8(:,24);
dat9 = TestResults14MPSNormal.OutData_9(:,24);
dat10 = TestResults14MPSNormal.OutData_10(:,24);
CombinedGenPwr = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestGenPwr = mean(CombinedGenPwr,2);
%% calc Mean Rotor Speed
dat1 = TestResults14MPSNormal.OutData_1(:,6);
dat2 = TestResults14MPSNormal.OutData_2(:,6);
dat3 = TestResults14MPSNormal.OutData_3(:,6);
dat4 = TestResults14MPSNormal.OutData_4(:,6);
dat5 = TestResults14MPSNormal.OutData_5(:,6);
dat6 = TestResults14MPSNormal.OutData_6(:,6);
dat7 = TestResults14MPSNormal.OutData_7(:,6);
dat8 = TestResults14MPSNormal.OutData_8(:,6);
dat9 = TestResults14MPSNormal.OutData_9(:,6);
dat10 = TestResults14MPSNormal.OutData_10(:,6);
CombinedRotSpd = cat(2,dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10);
mean10TestRotSpd = mean(CombinedRotSpd,2);
meanmean10TestRotSpd = mean(CombinedRotSpd,1);  
std10TestRotSpd = std(CombinedRotSpd,0,2);
%%
RotSpdstdlower = mean10TestRotSpd-std10TestRotSpd;
RotSpdstdupper = mean10TestRotSpd+std10TestRotSpd;
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,CombinedGenPwr,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
legend('Runs','','','','','','','','','','Mean')
xlabel('Time[s]')
ylabel('Generator Power[kW]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Generator Power(10 Runs+Mean)')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,CombinedRotSpd,Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
legend('Runs','','','','','','','','','','Mean')
xlabel('Time[s]')
ylabel('Rotor Speed[RPM]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Rotor Speed(10 Runs+Mean)')
hold off
%%
time = TestResults14MPSNormal.OutData_1(:,1);
RGB = [0.7 0.7 0.7];
figure
plot(time,RotSpdstdlower,':',Color=RGB,LineWidth=0.5)
hold on
plot(time,mean10TestRotSpd,'r',LineWidth=1)
plot(time,RotSpdstdupper,':',Color=RGB,LineWidth=0.5)
legend('Upper Confidence','Mean','Lower Confidence')
xlabel('Time[s]')
ylabel('Rotor Speed[RPM]')
xlim([0 3600])
title('PPO NTM 14 m/s Scenario: Rotor Speed(Confidence interval)')
hold off
%% Make plots PPO 14m/s Normal
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


%% calc Mean Gen Pwr
dat12 = TestResults14MPSExtreme.OutData_1(:,24);
dat22 = TestResults14MPSExtreme.OutData_2(:,24);
dat32 = TestResults14MPSExtreme.OutData_3(:,24);
dat42 = TestResults14MPSExtreme.OutData_4(:,24);
dat52 = TestResults14MPSExtreme.OutData_5(:,24);
dat62 = TestResults14MPSExtreme.OutData_6(:,24);
dat72 = TestResults14MPSExtreme.OutData_7(:,24);
dat82 = TestResults14MPSExtreme.OutData_8(:,24);
dat92 = TestResults14MPSExtreme.OutData_9(:,24);
dat102 = TestResults14MPSExtreme.OutData_10(:,24);
CombinedGenPwr2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestGenPwr2 = mean(CombinedGenPwr2,2);
%% calc Mean Rotor Speed
dat12 = TestResults14MPSExtreme.OutData_1(:,6);
dat22 = TestResults14MPSExtreme.OutData_2(:,6);
dat32 = TestResults14MPSExtreme.OutData_3(:,6);
dat42 = TestResults14MPSExtreme.OutData_4(:,6);
dat52 = TestResults14MPSExtreme.OutData_5(:,6);
dat62 = TestResults14MPSExtreme.OutData_6(:,6);
dat72 = TestResults14MPSExtreme.OutData_7(:,6);
dat82 = TestResults14MPSExtreme.OutData_8(:,6);
dat92 = TestResults14MPSExtreme.OutData_9(:,6);
dat102 = TestResults14MPSExtreme.OutData_10(:,6);
CombinedRotSpd2 = cat(2,dat12,dat22,dat32,dat42,dat52,dat62,dat72,dat82,dat92,dat102);
mean10TestRotSpd2 = mean(CombinedRotSpd2,2);
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);


plot(time2,CombinedGenPwr2,Color=RGB,LineWidth=0.5)
RGB = [0.7 0.7 0.7];
hold on
plot(time2,mean10TestGenPwr2,'r',LineWidth=1)
legend('Runs','','','','','','','','','','Mean')
xlabel('Time[s]')
ylabel('Generator Power[kW]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Generator Power(10 Runs+Mean)')
hold off
%%
time2 = TestResults14MPSExtreme.OutData_1(:,1);


plot(time2,CombinedRotSpd2,Color=RGB,LineWidth=0.5)
RGB = [0.7 0.7 0.7];
hold on
plot(time2,mean10TestRotSpd2,'r',LineWidth=1)
legend('Runs','','','','','','','','','','Mean')
xlabel('Time[s]')
ylabel('Rotor Speed[RPM]')
xlim([0 3600])
title('PPO ETM 14 m/s Scenario: Rotor Speed(10 Runs+Mean)')
hold off