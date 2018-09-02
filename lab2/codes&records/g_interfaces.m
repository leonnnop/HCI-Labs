function varargout = g_interfaces(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @g_interfaces_OpeningFcn, ...
                   'gui_OutputFcn',  @g_interfaces_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before g_interfaces is made visible.
function g_interfaces_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

hmm = load('myhmm.mat');

[ans len] = size(hmm.hmm);
test_len = num2str(len);

text = {'模板库中有10个单词：', '你好','谢谢','再见','晚安','早安','抱歉','梦想','奇迹','疾病','灾难'};

set(handles.edit1, 'string', text);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = g_interfaces_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tag1_1_Callback(hObject, eventdata, handles)
[FileName,PathName]= uigetfile('*.wav');
if ~isequal(FileName, 0)
[y fs] = audioread([PathName FileName]);
end
handles.data = y;
handles.sample = fs;
t = length(handles.data)/fs;
tt = 0: t/length(handles.data): t;
handles.t = tt(1:length(tt) - 1);
guidata(hObject, handles);    
axes(handles.axes1);   
plot(handles.t,y);
ylabel('signal Magnitude ');
xlabel('time(s)');

text = '';
set(handles.edit2, 'string', text);

function axes1_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in recognizeButton.
function recognizeButton_Callback(hObject, eventdata, handles)
hmm = load('myhmm.mat');

[ans,len] = size(hmm.hmm);
x = handles.data;
x(find(abs(x)<0.01)) = [];

m = mfcc(x);

for j=1:len
	pout(j) = viterbi(hmm.hmm{j}, m);
end
% disp(pout);
[d,n] = max(pout);
text = num2str(n);

word = {'你好','谢谢','再见','晚安','早安','抱歉','梦想','奇迹','疾病','灾难'};

set(handles.edit2, 'string', word{n});

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)

function playButton_Callback(hObject, eventdata, handles)
x = handles.data;
player = audioplayer(x,8000);
play(player);
pause(3);

function tag1_Callback(hObject, eventdata, handles)

function start_Callback(hObject, eventdata, handles)
global recObj;
recObj = audiorecorder;
disp('start speaking.');
set(handles.recordInfoEdit, 'string', 'Start speaking.');
record(recObj);

function end_Callback(hObject, eventdata, handles)
global recObj;
stop(recObj);
myRecording = getaudiodata(recObj);
set(handles.recordInfoEdit, 'string', 'End of Recording.');
disp('end speaking.');
myRecording = getaudiodata(recObj);
audiowrite('test.wav',myRecording, recObj.SampleRate);

[y,fs] = audioread('test.wav');
handles.data = y;
handles.sample = fs;
t = length(handles.data)/fs;
tt = 0: t/length(handles.data): t;
handles.t = tt(1:length(tt) - 1);
guidata(hObject, handles);    
axes(handles.axes1);   
plot(handles.t,y);
ylabel('signal Magnitude ');
xlabel('time(s)');



function recordInfoEdit_Callback(hObject, eventdata, handles)
% hObject    handle to recordInfoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recordInfoEdit as text
%        str2double(get(hObject,'String')) returns contents of recordInfoEdit as a double


% --- Executes during object creation, after setting all properties.
function recordInfoEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordInfoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
