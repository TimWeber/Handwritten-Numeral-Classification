function result = Q3Prediction(numberOfObject,charNet,imsTest,ima)
%Function to make prediction with Alexnet
%% If numbers is single digit
if numberOfObject==1
Pred = classify(charNet,cell2mat(ima(1,1)));%classify digit
result = char(Pred);
result = str2num(result);
fprintf('Predicted number = %d \n',result);%display prediction
end
%% If numbers is double digit
if numberOfObject==2
Pred = classify(charNet,cell2mat(ima(1,1)));%classify first digit
accu = sum(Pred == imsTest.Labels)/numel(imsTest.Labels);
Prediction1 = char(Pred);
Pred2 = classify(charNet,cell2mat(ima(1,2)));%classify second digit
Prediction2 = char(Pred2);
result = strcat(num2str(Prediction1),num2str(Prediction2));%join both numbers as string
result = str2num(result);% convert back to number
fprintf('Predicted number = %d \n',result);%display prediction
end
%% If numbers is triple digit
if numberOfObject==3
Pred = classify(charNet,cell2mat(ima(1,1)));%classify first digit
accu = sum(Pred == imsTest.Labels)/numel(imsTest.Labels);
Prediction1 = char(Pred);
Pred2 = classify(charNet,cell2mat(ima(1,2)));%classify second digit
Prediction2 = char(Pred2);
Pred3 = classify(charNet,cell2mat(ima(1,3)));%classify third digit
Prediction3 = char(Pred3);
result = strcat(num2str(Prediction1),num2str(Prediction2),num2str(Prediction3));%join numbers as string
result = str2num(result);% convert back to number
fprintf('Predicted number = %d \n',result);%display prediction
end
end

