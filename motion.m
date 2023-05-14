function I1 = motion(background,original)

[h, w, c] = size(background);

diff1=abs(original-background);          % locates the upper body of object in original img


diff2=abs(background-original);          % locates the lower body of object in original img

I1 = zeros(h,w,c);

for i=1:h
    for j = 1:w
        
        if(diff1(i,j,1)>30||diff1(i,j,2)>30||diff1(i,j,3)>30)    % diff > 30 -> pixel of object
            I1(i,j,:) = original(i,j,:);                         % set original pixel in black back.
        end
        if(diff2(i,j,1)>30||diff2(i,j,2)>30||diff2(i,j,3)>30)
           I1(i,j,:) = original(i,j,:);
        end

    end
end

%figure, imshow(I1);


I1=im2bw(I1);       % final img of object with black background -> changed to binary

end

