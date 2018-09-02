names = {'hello', 'thanks', 'goodbye', 'goodnight', 'goodmorning',...
    'sorry', 'dream', 'miracle', 'disease', 'disaster'};
[l1,l2] = size(names);
hmm = load('myhmm.mat');
path = fullfile(pwd ,'record');

for i = 1:l2
    accuracy = 0;
    for j = 1:10
        filename = char(string(names{i}) + '/' + ...
            string(names{i}) + string(j) + '.wav');
        filename = fullfile(path, filename);
        [x,fs] = audioread(filename);

        x(abs(x)<0.01) = [];
        [x1,x2] = vad(x);
        m = mfcc(x);
        for j=1:l2
            pout(j) = viterbi(hmm.hmm{j}, m);
        end
        [d,n] = max(pout);
        if n == i
            accuracy= accuracy + 1;
        end
    end
    fprintf('The accuracy of "%s" is %f\n', ...
        string(names{i}), double(accuracy) / 10); 
end