function im = cleanUp(im)
%Function that performs some morphological operations
% to process image in order to reduce noise, light, etc
        figure
        subplot(131)
        imshow(im)
        title('Original image')
        axis image
        im =rgb2gray(im);
        im = imresize(im,[235 235]);
        im = imbinarize(im);
        im =~im;
        se = strel('line',15,90);
        im = imdilate(im,se);
        subplot(132)
        imshow(im)
        title('Binary image')
        axis image
        im = bwareaopen(im,60);
        subplot(133)
        imshow(im)
        title('Processed image')
        axis image
end