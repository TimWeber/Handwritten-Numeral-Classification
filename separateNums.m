function varargout  = separateNums(im)
%Function used to separate numbers 
               subplot(133)
               imshow(im)
               axis image%show original image
               [labeledImage, numberOfObject] = bwlabel(im);
               %% If double digit number
            if numberOfObject==2
            I1 = bwareafilt(im,1);%find largest blob
            I2 = bwareafilt(im,1,'smallest');%find smallest blob
            stats = regionprops('table',I1,'Centroid');%find centroids
            stats1 = regionprops('table',I2,'Centroid');
            if stats.Centroid(1)>stats1.Centroid(1)
                %arrange digits based on X centroid value
                I3 =I2;
                I4 = I1;
            else
                I3 = I1;
                I4 = I2;
            end
            %Store each image as cell array & display
            varargout{1} = I3;
            varargout{2,1} = I4;
            figure
            subplot(121)
            imshow(I3)
            title('First digit')
            axis image
            subplot(122)
            imshow(I4)
            title('Second digit')
            axis image
            end
            %% If triple digit number
            if numberOfObject==3
            I1 = bwareafilt(im,2);%find 2 largest blobs
            I2 = bwareafilt(I1,1,'smallest');% find smallest of those blobs
            I3 = bwareafilt(im,1,'smallest');%find smallest of all 3 blobs
            I1 = bwareafilt(im,1);% find largest blob of all 3
            ima = cell(numberOfObject,1);
            ima{1} = I1;
            ima{2} = I2;
            ima{3} = I3;
            % Arange digits based on X centroid value
            stats = regionprops('table',I1,'Centroid');
            stats1 = regionprops('table',I2,'Centroid');
            stats2 = regionprops('table',I3,'Centroid');
            cen = [stats.Centroid(1) stats1.Centroid(1) stats2.Centroid(1)];
            [first,in] = min(cen);
            second = min(cen(cen>min(cen)));
            inde = find(second==cen);
            [last,ind] = max(cen);
            I1 = cell2mat(ima(in));
            I2 = cell2mat(ima(inde));
            I4 = cell2mat(ima(ind));
            %Store each image as cell array & display
            varargout{1} = I1;
            varargout{2} = I2;
            varargout{3} = I4;
            figure
            subplot(131)
            imshow(I1)
            title('First digit')
            axis image
            subplot(132)
            imshow(I2)
            title('Second digit')
            axis image
            subplot(133)
            imshow(I4)
            title('Third digit')
            axis image
            end
end
