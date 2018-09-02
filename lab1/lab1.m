figure
I = imread('./earth.jpg');
I = flip(I, 1);
[x,y,z] = sphere(100);
hSurface = surf(x,y,z, 'FaceColor', 'texturemap', 'CData', I, 'EdgeColor', 'none');
direction = [0 0 1];
rotate3d on
axis vis3d
hold on
light('Position', [-100 0 0], 'Style', 'local');

% You can change the speed of rotation 
% by modifying the degree.
degree = 1; 

while(true)
    rotate(hSurface,direction,degree);
    pause(0.1);
end


