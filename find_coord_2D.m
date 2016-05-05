function output_matrix = find_coord_2D(input_image)
% Give back the coordinates of the binary image
output_matrix = []; X1 = []; X2 = [];
for i = 1:size(input_image,1)
    for j = 1:size(input_image,2)
        if input_image(i,j) == 1
            % Offset of 1
            X1 = [X1; 1 i j];
        else

        end
        output_matrix = [X1;-X2];
    end
    
end
end
