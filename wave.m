clear,clc,close all;

myFolder='C:\Users\DELL\Videos\Uni 3rd year\IP\project\TestCases\Case3 - Full body - dynamic BG';

outputFolder = fullfile(myFolder,'*.jpg'); 
images = dir(outputFolder);                   % array carrying each image in an index

for k = 1:length(images)                               % reads all the images in the file
    
  baseFileName = images(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', baseFileName);
  ImageArray{k} = imread(fullFileName);
  
end

w={};                           % ????????
w1=ImageArray{1};               % background


for k=length(images):-1:1        % loops on images from end to start to avoid overlapping and noise

f = motion(ImageArray{1},ImageArray{k});         %(back,img) outputs -> object w/ black back. 

[~,n_labels]=bwlabel(f);                       % returns an array with all objects detected in img

if n_labels<400                         % not dynamic -> actual object w/o noise
    
     SE= strel('square',2);
     f=imclose(f,SE);
     f= bwmorph(f, 'bridge');            % closes the opened edges
     f = imfill(f,'holes');              % fills the holes
     
    
else                                   % dynamic -> moving background -> extra detected objects & noise

     avg= fspecial('average',14);
     h=imfilter(ImageArray{k},avg);         % alters pixel values of img

     
     bck=imfilter(ImageArray{1},avg);       % apply filter on img & back -> minimize diff range

     
     f= bwmorph(f, 'bridge');               % unnecassary -> we don't use f
     
     f = motion(bck,h);     
     
     SE= strel('square',4);
     f=imerode(f,SE);                         % object + noise
     
     SE= strel('square',40);
     f=imclose(f,SE);                          % to fill gaps from erosion
  
     
      avg= fspecial('average',4);        % further smoothing for segmented object to reduce noise
      f=imfilter(f,avg);
        

end

w1=place_object(f,ImageArray{k},w1);       % (segmented_object,original_img,back)

end


w1= imresize(w1,3);                       % enhances quality of img

figure,imshow(w1);
