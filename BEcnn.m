clc
clear all
close all

% % load data
imds = imageDatastore ("C:/Users/arnab/Desktop/Sem7/BE Project/CNN/input",...
"IncludeSubfolders",true,...
    "LabelSource","foldernames");

dnds = denoisingImageDatastore(imds,...
    "PatchesPerImage",512,...
    "PatchSize",50,...
    "GaussianNoiseLevel",[0.01 0.1],...
    "ChannelFormat","grayscale")

% % layer design
layers = [...
imageInputLayer([50 50 1])

convolution2dLayer(3,64,"Stride",1,"Padding",[1 1 1 1])
reluLayer

convolution2dLayer(3,64,"Stride",1,"Padding",[2 2 2 2])
reluLayer

convolution2dLayer(3,64,"Stride",1,"Padding",[1 1 1 1])
reluLayer

convolution2dLayer(3,1)
regressionLayer
]

options = trainingOptions("adam",...
    "MiniBatchSize",32,...
    "MaxEpochs",20,...
    "ValidationFrequency",5,...
    "InitialLearnRate",1e-4,"Plots","training-progress");

% % network training
[convnet, traininfo] = trainNetwork(dnds,layers,options);

inp=imread('normal.png');


denoisedR = denoiseImage(inp,convnet);

figure,
subplot(2,1,1)
imshow(noise);
title("noisy")

subplot(2,1,2)
imshow(denoisedR)
title("denoised")

psnrvalue=psnr(inp,denoisedR);

uqivalue = UniversalImageQualityIndex(inp, denoisedR);

ssimvalue = ssim(inp,denoisedR);


