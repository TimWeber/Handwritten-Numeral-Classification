function [ima,numberOfObject] = singleDigit(im)
%% Code to reduce noise & light
%  and convert to binary
im =rgb2gray(im);
im = imresize(im,[235 235]);
im = imbinarize(im);
im =~im;
im = imclearborder(im);
im = bwareaopen(im,60);
[labeledImage, numberOfObject] = bwlabel(im);
ima{1,1} = im;
% outputs the image as cell array and the number of blobs detected for Q2
end

