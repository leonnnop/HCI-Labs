% Refere to the example of "Image Retrieval Using Customized Bag of Features"
% from the HELP document

dataDir = './img';
imgDataset = imageSet(dataDir);
trainingSet = partition(imgDataset, 0.4, 'randomized');
colorBag = bagOfFeatures(trainingSet, ...
  'CustomExtractor', @exampleBagOfFeaturesColorExtractor, ...
  'VocabularySize', 10000);
imageIndex = indexImages(imgDataset, colorBag, 'SaveFeatureLocations', false);
% save('savedColorBagOfFeatures.mat','colorBag');
save('savedImageIndex.mat','imageIndex');