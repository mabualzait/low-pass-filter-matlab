clc;
clear all;
close all;

images.original = imread('cameraman.tif');
images.filteredImage = images.original; % to be modified 
kernel.kernal_start = 1;
kernel.kernal_size = 3;
[images.length, images.height] = size(images.original);
kernel.kernel_array = zeros(kernel.kernal_size,kernel.kernal_size);%a 3X3 zeros array we will use it to add the values every time from the original image then calculate the average /9 then we will clear it again.
modified_centers = zeros(images.length,images.length);%this matrix will have all the new values then we will add them to filtered image.
counters.column =1;
counters.column_end = 3;
counters.row =1;
counters.row_end = 3;
while(counters.row_end <= images.length)
    while(counters.column_end <= images.length)
        for i = counters.row:counters.row_end
            for j = counters.column:counters.column_end
                 kernel.kernel_array(i, j) = images.original(i, j);
            end
        end
        modified_centers(counters.row+1,(counters.column+1)) = sum(kernel.kernel_array,'all')/9;
        kernel.kernel_array = zeros(kernel.kernal_size,kernel.kernal_size);
        counters.column = counters.column+1;
        counters.column_end = counters.column_end+1;
    end
    counters.column = 1;
    counters.column_end = kernel.kernal_size;
    counters.row =counters.row+1;
    counters.row_end = counters.row_end+1;
end

for i =1 :length(images.filteredImage)
    for j = 1: length(images.filteredImage)
        if not(modified_centers(i,j) == 0)
            images.filteredImage(i,j) = modified_centers(i,j);
        end
    end
end
figure; 
subplot(1,2,2);
imshow(images.filteredImage, []);title('filtered');
subplot(1,2,1);
imshow(images.original); title('original');

   