function bestMatch = imageSearchFilter(queryImage, numberOfResults, category)
% For test: 
% queryImage = imread('airplane_test.jpg');
% imageSearch(queryImage, 5)
bestImages = cell(1,numberOfResults);

load('savedImageIndex.mat'); % database for searching

[imageIDs, scores] = retrieveImages(queryImage, imageIndex); % search database using the query image

bestMatch = cell(1,numberOfResults);

resultsCount = length(imageIDs);
index = 1;
for i = 1:resultsCount
    if index<=numberOfResults
        tempStr = imageIndex.ImageLocation{imageIDs(i)};
%         disp(category)
        if size(strfind(tempStr,category),1)~=0 % 如果属于当前类别
            bestMatch{index}  = tempStr;
            index=index+1;
        end
    else
        break;
    end
end

if index==1
    bestMatch = cell(0);
end
