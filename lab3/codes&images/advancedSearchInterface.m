function varargout = advancedSearchInterface(varargin)
% ADVANCEDSEARCHINTERFACE MATLAB code for advancedSearchInterface.fig
%      ADVANCEDSEARCHINTERFACE, by itself, creates a new ADVANCEDSEARCHINTERFACE or raises the existing
%      singleton*.
%
%      H = ADVANCEDSEARCHINTERFACE returns the handle to a new ADVANCEDSEARCHINTERFACE or the handle to
%      the existing singleton*.
%
%      ADVANCEDSEARCHINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADVANCEDSEARCHINTERFACE.M with the given input arguments.
%
%      ADVANCEDSEARCHINTERFACE('Property','Value',...) creates a new ADVANCEDSEARCHINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before advancedSearchInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to advancedSearchInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help advancedSearchInterface

% Last Modified by GUIDE v2.5 29-May-2018 20:07:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @advancedSearchInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @advancedSearchInterface_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before advancedSearchInterface is made visible.
function advancedSearchInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to advancedSearchInterface (see VARARGIN)

% Choose default command line output for advancedSearchInterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes advancedSearchInterface wait for user response (see UIRESUME)
% uiwait(handles.advancedSearchInterface);


% --- Outputs from this function are returned to the command line.
function varargout = advancedSearchInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browsePic.
function browsePic_Callback(hObject, eventdata, handles)
% hObject    handle to browsePic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global queryImage;

[query_fname, query_pathname] = uigetfile('*.jpg; *.png; *.bmp', 'Select query image');
axes(handles.imgPanel);
fpath=[query_pathname query_fname];% 路径+文件名
queryImage=imread(fpath);  % 读入文件
imshow(queryImage);% 显示图片


% --- Executes on button press in advancedSearch.
function advancedSearch_Callback(hObject, eventdata, handles)
% hObject    handle to advancedSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global queryImage;
global numberOfResults;
global category;
if(ischar(numberOfResults))
    numberOfResults = str2num(numberOfResults);
end
bestImages = imageSearchFilter(queryImage,numberOfResults,category);

close(gcf);
resultReviewInterface(bestImages,queryImage,category);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1



function inputKeywords_Callback(hObject, eventdata, handles)
% hObject    handle to inputKeywords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputKeywords as text
%        str2double(get(hObject,'String')) returns contents of inputKeywords as a double


% --- Executes during object creation, after setting all properties.
function inputKeywords_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputKeywords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in setResultsNumber.
function setResultsNumber_Callback(hObject, eventdata, handles)
% hObject    handle to setResultsNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns setResultsNumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from setResultsNumber
global numberOfResults;
contents = cellstr(get(hObject,'String'));
numberOfResults = contents{get(hObject,'Value')};




% --- Executes during object creation, after setting all properties.
function setResultsNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to setResultsNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global numberOfResults;
contents = cellstr(get(hObject,'String'));
numberOfResults = contents{get(hObject,'Value')};


% --- Executes on selection change in setCategory.
function setCategory_Callback(hObject, eventdata, handles)
% hObject    handle to setCategory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns setCategory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from setCategory
global category;
contents = cellstr(get(hObject,'String'));
category = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function setCategory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to setCategory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global category;
contents = cellstr(get(hObject,'String'));
category = contents{get(hObject,'Value')};
