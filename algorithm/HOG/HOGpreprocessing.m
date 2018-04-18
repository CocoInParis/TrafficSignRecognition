function HOGpreprocessing()
% MATLAB Version 7.11.0.584 (R2010b)
%
% Traffic Sign Recognition Benchmark
%
% This function provides a base to train the classifier that will later
% compete in the traffic sign recognition benchmark. You should download
% and extract the benchmark data and keep the file structure that it
% provides.
%
% Change the lines that are marked with a TODO to your needs.


% TODO!
% replace this string by the path you saved the benchmark data in
sBasePath = 'E:\DEEPLEARNING\dataset\GTSRB_Origin\Final_Training\Images'; 
m = 1;
t = 1;
k = 0;		%for base only
g = 0;

for nNumFolder = 0		% adjust the nNumFolder

    nNumFolder   
    sFolder = num2str(nNumFolder, '%05d');	%?¨nNumFolder??è¡??ï¼Œè¾¾??ä½???
    sPath = [sBasePath, '\', sFolder, '\'];
    if isdir(sPath)
        [ImgFiles, Rois, Classes] = readSignData([sPath, '\GT-', num2str(nNumFolder, '%05d'), '.csv']);	

			Benchtrain = Classes;
			p = sprintf('A%d', m);
			xlswrite('E:\DEEPLEARNING\dataset\GTSRB_Final_Training_HOG\DataProcessingFiles\HOGspeedall.xlsx', Benchtrain, 1,p);
			m = m + numel(ImgFiles);
		
            for i = 1:numel(ImgFiles)   
				k = k + 1;
				ImgFile = [sPath, '\', ImgFiles{i}];
				I = imread(ImgFile);
 				img = imresize(I,[48 48],'bilinear');
 				gray = rgb2gray(img);
 				J = imadjust(gray,[],[],0.454);
                 
                imwrite(J,ImgFile,'ppm');
[featureVector, hogVisualization] = extractHOGFeatures(J,'CellSize',[4 4],'BlockSize',[2 2],'BlockOverlap',[1 1],'NumBins',14,'UseSignedOrientation',360);

				s = sprintf('B%d',k);
				xlswrite('E:\DEEPLEARNING\dataset\GTSRB_Final_Training_HOG\DataProcessingFiles\HOGspeedall.xlsx',featureVector,1,s);
			end                  
   end  
end

function [rImgFiles, rRois, rClasses] = readSignData(aFile)
% Reads the traffic sign data.
%
% aFile         Text file that contains the data for the traffic signs
%
% rImgFiles     Cell-Array (1 x n) of Strings containing the names of the image
%               files to operate on
% rRois         (n x 4)-Array containing upper left column, upper left row,
%               lower left column, lower left row of the region of interest
%               of the traffic sign image. The image itself can have a
%               small border so this data will give you the exact bounding
%               box of the sign in the image
% rClasses      (n x 1)-Array providing the classes for each traffic sign

    fID = fopen(aFile, 'r');
    
    fgetl(fID); % discard line with column headers
    
    f = textscan(fID, '%s %*d %*d %d %d %d %d %d', 'Delimiter', ';');
    
    rImgFiles = f{1}; 
    rRois = [f{2}, f{3}, f{4}, f{5}];
    rClasses = f{6};
    
    fclose(fID);
    
    

    
   
   
function MyTrainingFunction(aImg, aClasses)

fprintf(1, 'You should replace the function MyTrainingFunction() by your own training function.\n');
