%directory name
f=dir("C:/Users/arnab/Desktop/Sem7/BE Project/CNN/Datas/normal/*.png");
files={f.name};
for k=1:numel(files)
   fullName = strcat('C:/Users/arnab/Desktop/Sem7/BE Project/CNN/Datas/normal/',files{k});
   img = imread(fullName);
   img = rgb2gray(img);
   I1 = imnoise(img,'speckle',0.15);
   I2 = imdiffusefilt(I1);
   I = medfilt2(I2);
   
    imwrite(I,sprintf(strcat('input/',files{k})));
   disp("DONE executing");
 end