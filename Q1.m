%Group 4, Q1- KNN to gather data of optimal parameters
%last modified 20/1/2021
%% Initialisation
clear
clc
close all
%%  Arrays for graph information, n for array indexing
n = 1;
accuracy =  zeros(1,10);
confidence = zeros(1,10);
numbers = [0 1 2 3 4 5 6 7 8 9];
%% KNN variables
% k value
k = 3;
% maximum numeral to recognise
maxNum = 9;
% fraction of images used for testing
testFrac = 0.25;
% get list of image file names
names = dir('imageData\0\*.png');
% total number of images for each class 
NClass = length(names);
% number of training and testing images
NTest = round(NClass*testFrac);
NTrain = NClass - NTest;
% initialise vectors that will contain metrics (Hu moments)
[H1,H2,H3,H4,H5,H6,H7,H8]=deal( nan(NClass*(maxNum+1),1));
% initialise vector to contain true class for each image
C = H1;
% indicate which images are for test only
%% Read dataset
testOnly = false(size(H1));
ind = 0;
for num = 0:maxNum % for each class
    % get path for images in current class 
    pathToIms = fullfile('imageData',num2str(num));
    % get list of image filenames for current class
    imFilenames = dir(fullfile(pathToIms,'*.png'));
    for imNo = 1:NClass % for each image of current class
        ind = ind + 1;
        % read next image
        im = imread(fullfile(pathToIms,imFilenames(imNo).name));
        % calculate Hu moments
        H = Hmoments(im);
        H1(ind) = H(1);
        H2(ind) = H(2);
        H3(ind) = H(3);
        H4(ind) = H(4);
        H5(ind) = H(5);
        H6(ind) = H(6);
        H7(ind) = H(7);
        % store corresponding class
        C(ind) = num;
        if imNo > NTrain
            testOnly(ind) = true;
        end
    end
end
%% Once trained, perform classification on random point
% And display confidence graph & accuracy graph per increase of maxNum
expected = Q1KNNclass(n,H1,H2,H3,H4,H5,H6,H7,maxNum,testOnly,k,numbers,C);