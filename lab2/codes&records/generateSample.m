names = {'hello', 'thanks', 'goodbye', 'goodnight', 'goodmorning',...
    'sorry', 'dream', 'miracle', 'disease', 'disaster'};
[l1, l] = size(names);
training = cell(1,l);
path = fullfile(pwd ,'record');
disp(path)
for i = 1:l
    mycell = cell(1,3);
    for j = 1:3
        filename = char(string(names{i}) ...
            + '/' + string(names{i}) +string(j) + '.wav');
        filename = fullfile(path, filename);
        disp(filename);
        [x,fs] = audioread(filename);

        x(abs(x)<0.01) = [];
        mycell{j}=x;
    end
    training{i} = mycell;
end
save('training.mat', 'training')
        

    