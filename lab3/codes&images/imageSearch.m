function bestImages = imageSearch(queryImage, numberOfResults)
% For test: 
% queryImage = imread('airplane_test.jpg');
% imageSearch(queryImage, 5)
bestImages = cell(1,numberOfResults);

load('savedImageIndex.mat'); % database for searching

[imageIDs, scores] = retrieveImages(queryImage, imageIndex); % search database using the query image

resultsCount = length(imageIDs);
if resultsCount>=numberOfResults
    bestMatch  = imageIDs(1:numberOfResults);
end

for i = 1:length(bestMatch)
    bestImage = imageIndex.ImageLocation{bestMatch(i)};
    bestImages{i} = bestImage;
end
