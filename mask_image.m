function output_image = mask_image(input_image)
% Make a 2-D binary image
output_image = zeros(size(input_image,1),size(input_image,2));
% Find the dimension of the image
for i = 1:size(input_image,1);
    for j = 1:size(input_image,2);
        if input_image(i,j) > 0
            output_image(i,j) = 1;
        else
            output_image(i,j) = 0;
        end
    end
end

end

