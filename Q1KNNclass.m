function expected = Q1KNNclass(n,H1,H2,H3,H4,H5,H6,H7,maxNum,testOnly,k,numbers,C)
% Function to perform classification on random point with Q1 KNN
% And display confidence graph & accuracy graph per increase of maxNum
for maxNum = 0:1:9
% construct a single matrix containing all metrics for training
allMetricsTrain = [H1(C<=maxNum & ~testOnly) H2(C<=maxNum & ~testOnly) H3(C<=maxNum & ~testOnly) H4(C<=maxNum & ~testOnly) H5(C<=maxNum & ~testOnly) H6(C<=maxNum & ~testOnly) H7(C<=maxNum & ~testOnly)];
% construct a single matrix containing all metrics for testing
allMetricsTest = [H1(C<=maxNum & testOnly) H2(C<=maxNum & testOnly) H3(C<=maxNum & testOnly) H4(C<=maxNum & testOnly) H5(C<=maxNum & testOnly) H6(C<=maxNum & testOnly) H7(C<=maxNum & testOnly)];
% vector showing correct class for each image in test dataset
classTest = C(C<=maxNum & testOnly);
classTrain = C(C<=maxNum & ~testOnly);
% use built in function to build Kd-tree
kdTreeModel = KDTreeSearcher(allMetricsTrain);
% get a random point from the testing dataset
newPointInd = randi(length(classTest));
testImageH1 = allMetricsTest(newPointInd,1);
testImageH2 = allMetricsTest(newPointInd,2);
testImageH3 = allMetricsTest(newPointInd,3);
testImageH4 = allMetricsTest(newPointInd,4);
testImageH5 = allMetricsTest(newPointInd,5);
testImageH6 = allMetricsTest(newPointInd,6);
testImageH7 = allMetricsTest(newPointInd,7);
% find k-nearest neighbours and corresponding distances
[inds,dists] = knnsearch(kdTreeModel,[testImageH1 testImageH2 testImageH3 testImageH4 testImageH5 testImageH6 testImageH7],'k',k);
if maxNum ==9% only make prediction & confidence graph for maxNum = 9
%% Make prediction and calculate confidence
prediction = classTrain(inds(1,:));
expected = mode(prediction);
numCorrect0 = sum(expected==prediction);
pctCorrect0 = 100*numCorrect0/length(prediction);
confidence(1) = (100*(sum(0==prediction)))/length(prediction);
confidence(2) = (100*(sum(1==prediction)))/length(prediction);
confidence(3) = (100*(sum(2==prediction)))/length(prediction);
confidence(4) = (100*(sum(3==prediction)))/length(prediction);
confidence(5) = (100*(sum(4==prediction)))/length(prediction);
confidence(6) = (100*(sum(5==prediction)))/length(prediction);
confidence(7) = (100*(sum(6==prediction)))/length(prediction);
confidence(8) = (100*(sum(7==prediction)))/length(prediction);
confidence(9) = (100*(sum(8==prediction)))/length(prediction);
confidence(10) = (100*(sum(9==prediction)))/length(prediction);
end
%% Calculate accuracy per increase maxNum
preds = zeros(size(classTest));
for testNo = 1:length(classTest) % for each test image
    currentTestH1 = allMetricsTest(testNo,1); % extract Hu moments from test set
    currentTestH2 = allMetricsTest(testNo,2); 
    currentTestH3 = allMetricsTest(testNo,3);
    currentTestH4 = allMetricsTest(testNo,4); 
    currentTestH5 = allMetricsTest(testNo,5); 
    currentTestH6 = allMetricsTest(testNo,6);
    currentTestH7 = allMetricsTest(testNo,7);
    [inds,dists] = knnsearch(kdTreeModel,[currentTestH1 currentTestH2 currentTestH3 currentTestH4 currentTestH5 currentTestH6 currentTestH7],'k',k); % get closest neighbours
    prediction = classTrain(inds(1,:));
    preds(testNo) = mode(prediction); % predict class
end
%% Store accuracy
numCorrect = sum(preds==classTest);
pctCorrect = 100*numCorrect/length(classTest);
% display accuracy at each maxNum value
fprintf('KNN Accuracy = %d of %d (%.1f%%) for maxNum = %d \n',...
numCorrect,length(classTest),pctCorrect,maxNum);
accuracy(n) = pctCorrect;
n = n+1;
end
%% Plot confidence & accuracy graph & display
figure
bar(numbers,accuracy);
title('KNN accuracy per maxNum')
xlabel('maxNum')
ylabel('KNN Accuracy')
figure
bar(numbers,confidence);
title('Number confidence for prediction')
xlabel('Number')
ylabel('Percentage')
fprintf('Predicted number = %d \n',expected);
fprintf('Number confidence = %d of %d (%.1f%%)\n',...
numCorrect0,length(prediction),pctCorrect0);
end

