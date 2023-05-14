clear,clc,close all;

myFolder='C:\Users\DELL\Videos\Uni 3rd year\IP\project\TestCases\BONUSES\Complex BG';

outputFolder = fullfile(myFolder,'*.jpg'); 
images = dir(outputFolder);

for k = 1:length(images)
    
  baseFileName = images(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', baseFileName);
  ImageArray{k} = imread(fullFileName);
  
end


w1=ImageArray{1};


for k=length(images):-1:2          % loops on images from end to start-1 -> last img in array is all zeroes

     avg= fspecial('average',9);
     h=imfilter(ImageArray{k},avg);     


     bck=imfilter(ImageArray{1},avg);
     
     f = motion(bck,h);
 
     SE= strel('square',4);
     f=imerode(f,SE);                        % boat pixels merges with sea -> separate them
     
     SE= strel('rectangle',[10 40]);
     f=imclose(f,SE);                         % to fill gaps from erosion
     
     f=biggest_object(f);

     f= bwmorph(f, 'bridge');
     SE= strel('disk',6);
      
     f=imdilate(f,SE);                        % to enlarge object parts that were eroded

        
     avg= fspecial('average',4);
     f=imfilter(f,avg);
        

w1=place_object(f,ImageArray{k},w1);          % (segmented,original,back) 

end

w1= imresize(w1,3);                           % enhances quality of img

 figure,imshow(w1);
 
 