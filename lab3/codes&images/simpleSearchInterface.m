function varargout = simpleSearchInterface(varargin)
% SIMPLESEARCHINTERFACE MATLAB code for simpleSearchInterface.fig
%      SIMPLESEARCHINTERFACE, by itself, creates a new SIMPLESEARCHINTERFACE or raises the existing
%      singleton*.
%
%      H = SIMPLESEARCHINTERFACE returns the handle to a new SIMPLESEARCHINTERFACE or the handle to
%      the existing singleton*.
%
%      SIMPLESEARCHINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLESEARCHINTERFACE.M with the given input arguments.
%
%      SIMPLESEARCHINTERFACE('Property','Value',...) creates a new SIMPLESEARCHINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simpleSearchInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simpleSearchInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simpleSearchInterface

% Last Modified by GUIDE v2.5 29-May-2018 20:06:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simpleSearchInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @simpleSearchInterface_OutputFcn, ...
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


% --- Executes just before simpleSearchInterface is made visible.
function simpleSearchInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simpleSearchInterface (see VARARGIN)

% Choose default command line output for simpleSearchInterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simpleSearchInterface wait for user response (see UIRESUME)
% uiwait(handles.simpleSearchInterface);


% --- Outputs from this function are returned to the command line.
function varargout = simpleSearchInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in searchButton.
function searchButton_Callback(hObject, eventdata, handles)
% hObject    handle to searchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global queryImage;
global numberOfResults;
if(ischar(numberOfResults))
    numberOfResults = str2num(numberOfResults);
end
bestImages = imageSearch(queryImage,numberOfResults);
close(gcf);
resultReviewInterface(bestImages,queryImage);




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


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in openAdvancedSearch.
function openAdvancedSearch_Callback(hObject, eventdata, handles)
% hObject    handle to openAdvancedSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
advancedSearchInterface();


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over openAdvancedSearch.
function openAdvancedSearch_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to openAdvancedSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
