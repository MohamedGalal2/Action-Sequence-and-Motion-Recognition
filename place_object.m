function background = place_object(segmented,original,background)
[h, w, c] = size(background);

for i=1:h
    for j = 1:w
        for k =1 : c
            
        if segmented(i,j,:)>0                          % any non-black pixel value -> object
            background(i,j,:) = original(i,j,:);       % return original object pixel in back
            
        else
            
        end
        end 
    end
end
end

