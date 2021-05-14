function result = classKNN(ima,classTrain,kdTreeModel,numberOfObject,k,numbers,confidence)
%% Code to perfrorm KNN clasification for Q2 , for numbers of 1 to 3 digits
for i=1:1:numberOfObject
I3 = cell2mat(ima(1,i));%convert cell to normal array
HI3 =  Hmoments(I3);%calculate moments
H1I3 = HI3(1);
H2I3 = HI3(2);
H3I3 = HI3(3);
H4I3 = HI3(4);
H5I3 = HI3(5);
H6I3 = HI3(6);
H7I3 = HI3(7);
%% find k-nearest neighbours and corresponding distances
[inds,dists] = knnsearch(kdTreeModel,[H1I3 H2I3 H3I3 H4I3 H5I3 H6I3 H7I3],'k',k);
%% make prediction of digit
prediction = classTrain(inds(1,:));
expected(i) = mode(prediction);
%% Create information for confidence bar graph
numCorrect0 = sum(expected(i)==prediction);
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
%% Plot confidence graph for digit
figure
bar(numbers,confidence);
title('Digit confidence for prediction')
xlabel('Number')
ylabel('Percentage')
fprintf('Digit confidence = %d of %d (%.1f%%)\n',...
numCorrect0,length(prediction),pctCorrect0);
end
%% Make final prediction for image & display
if numberOfObject==1%single digit number
expected1 = expected(1);
result = expected1; 
fprintf('Predicted number = %d \n',expected1);
end
if numberOfObject==2%double digit number
expected1 = expected(1);
expected2 = expected(2);
result = strcat(num2str(expected1),num2str(expected2));
result = str2num(result);
fprintf('Predicted number = %d \n',result);
end
if numberOfObject==3%triple digit number
expected1 = expected(1);
expected2 = expected(2);
expected3 = expected(3);
result = strcat(num2str(expected1),num2str(expected2),num2str(expected3));
result = str2num(result);
fprintf('Predicted number = %d \n',result);
end
end

