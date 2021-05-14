function [ima,numberOfObject] = Q3Read_separate(im)
% Function to separate double or triple digit numbers for Q3
% and output all digits in cell array and number of digits detected
%% If the image is wrongly rotated
[x y channel] = size(im);
if x>y
    im = imrotate(im,-90);%correct rotation
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
            % convert digits to required format for Alexnet
            I3 = convertBin2RGB(I3);
            I3 = imresize(I3,[227 227]);
            se = strel('line',5,15);
            I3 = imdilate(I3,se);
            I4 = convertBin2RGB(I4);
            I4 = imresize(I4,[227 227]);
            se = strel('line',5,15);
            I4 = imdilate(I4,se);
            % & store in cell array
            ima{1,1} = I3;
            ima{1,2} = I4;
            end
             %% If number is triple digit
            if numberOfObject==3
            [I1,I2,I3] = separateNums(im);% separate digits
            % convert digits to required format for Alexnet
            % & store in cell array
            ima{1,1} =  convertBin2RGB(I1);
            ima{1,1} =  imresize(ima{1,1},[227 227]);
            ima{1,2} =  convertBin2RGB(I2);
            ima{1,2} =  imresize(ima{1,2},[227 227]);
            ima{1,3} =  convertBin2RGB(I3);
            ima{1,3} =  imresize(ima{1,3},[227 227]);
            end
end

