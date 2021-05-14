%% Script to read image data colected
% do some image processing and convert them to binary
% as to expand dataset
clear
clc
close all
names = dir('minimal dataset\1\*.jpg');
% total number of images for each class
NClass = length(names);
maxNum = 0;
for num = 0:maxNum % for each class
    % get path for images in current class 
    pathToIms = fullfile('minimal dataset',num2str(num));
    % get list of image filenames for current class
    imFilenames = dir(fullfile(pathToIms,'*.jpg'));
    for imNo = 1:NClass % for each image of current class
        % read next image
        im = imread(fullfile(pathToIms,imFilenames(imNo).name));
        % do some image processing
        im =rgb2gray(im);
        im = imresize(im,[235 235]);
        im = imbinarize(im);
        im =~im;
        im = imclearborder(im);
        im = bwareaopen(im,60);
        se = strel('line',15,90);
        im = imdilate(im,se);
        figure
        imshow(im);
        % store processed image as png
        filename = ['0000' num2str(imNo) '.png'];
        imwrite(im,filename);
    end
end
