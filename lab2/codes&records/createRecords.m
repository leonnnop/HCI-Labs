recObj = audiorecorder;
typeName = input('Input the type:[record/test] ','s');

for  j = 1 : 10
    name = input('Input a dir name: ','s');
    mkdir(char(string(typeName) + '/' + string(name)));

    for i = 1 : 10
        disp('Start speaking: ' + string(i))
        recordblocking(recObj, 2);
        disp('End of Recording: ' + string(i));

        myRecording = getaudiodata(recObj);

        audiowrite(char(string(typeName) + '/' + string(name) + '/' + string(name)...
            + string(i) + '.wav'), myRecording, recObj.SampleRate);
    end
end
