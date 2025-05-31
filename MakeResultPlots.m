%% Make plots
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


%% calc Mean
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
%%
time = TestResults14MPSNormal.OutData_1(:,1);


plot(time,CombinedGenPwr,Color=RGB,LineWidth=0.5)
RGB = [0.7 0.7 0.7];
hold on
plot(time,mean10TestGenPwr,'r',LineWidth=1)
legend('Runs','','','','','','','','','','Mean')
xlabel('Time[s]')
ylabel('Generator Power[kW]')
title('PPO 14 m/s Scenario: Generator Power(10 Runs+Mean)')
hold off
%%