% Plot Results
ShortBaseData = load("CombinedBaselineSimOut.mat");
ShortBaseData = ShortBaseData.CombinedBaselineSimOut;
LongBaseData = load("CombinedBaselineSimOutLong.mat");
LongBaseData = LongBaseData.CombinedBaselineSimOutLong;
ShortPPOData = load("CombinedPPOSimOUT.mat");
ShortPPOData = ShortPPOData.CombinedPPOSimOUT;
LongPPOData = load("CombinedPPOSimOUTLong.mat");
LongPPOData = LongPPOData.CombinedPPOSimOUTLong;



%%
plot(LongPPOData(:,2))
hold on
plot(LongPPOData(:,2))
plot(LongPPOData(:,3))
plot(LongPPOData(:,3))
%plot(LongBaseData(:,26))
%plot(LongBaseData(:,27))