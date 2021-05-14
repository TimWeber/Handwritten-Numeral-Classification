function [ima,numberOfObject] = Read_separate(im)
% Function to separate double or triple digit numbers for Q2
% and output all digits in cell array and number of digits detected
%% If the image is wrongly rotated
[x y channel] = size(im);
if x>y
    im = imrotate(im,90);%correct rotation
end
%% If image is not in binary
        if channel>1
        im = cleanUp(im);% Process and convert to binary
        end
        %% If numbers are touching
            [labeledImage, numberOfObject] = bwlabel(im);
            if numberOfObject == 1
            se = strel('line',21,98);
            im = imerode(im,se);% separate with erosion
            [labeledImage, numberOfObject] = bwlabel(im);
            ima{1,1} = im;
            if numberOfObject<2%if they are still touching
            se = strel('line',5,54);
            im = imerode(im,se);% apply more erosion & dilation
            se = strel('line',15,15);
            im = imdilate(im,se);
            [labeledImage, numberOfObject] = bwlabel(im);
            ima{1,1} = im;
            end
            end
            %% If number is double digit
            if numberOfObject==2
            [I3,I4] = separateNums(im);% separate digits 
            ima{1,1} = I3;% & store in cell array
            ima{1,2} = I4;
            end
            %% If number is triple digit
            if numberOfObject==3
            [I1,I2,I3] = separateNums(im);% separate digits
            ima{1} = I1;%& store in cell array
            ima{2} = I2;
            ima{3} = I3;
            end
end

