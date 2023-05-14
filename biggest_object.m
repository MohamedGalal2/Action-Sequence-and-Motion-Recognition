function [biggest] = biggest_object(i)

[labeledImage,~] = bwlabel(i);                           % all objects in img
measurements = regionprops(labeledImage, 'area');        % areas of each object in img

% Get all the areas
Areas = [measurements.Area]; 
[sortedAreas, sortIndices] = sort(Areas, 'descend');     %to detect the biggest object


biggestBlob = ismember(labeledImage, sortIndices(1));   %checks index of biggest object in labeled image
  
biggest = biggestBlob>0;      % Convert from integer labeled image into binary (logical) image.

%figure,imshow(biggest);

end

