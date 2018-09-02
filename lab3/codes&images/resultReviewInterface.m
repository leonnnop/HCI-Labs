function varargout = resultReviewInterface(varargin)
% RESULTREVIEWINTERFACE MATLAB code for resultReviewInterface.fig
%      RESULTREVIEWINTERFACE, by itself, creates a new RESULTREVIEWINTERFACE or raises the existing
%      singleton*.
%
%      H = RESULTREVIEWINTERFACE returns the handle to a new RESULTREVIEWINTERFACE or the handle to
%      the existing singleton*.
%
%      RESULTREVIEWINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTREVIEWINTERFACE.M with the given input arguments.
%
%      RESULTREVIEWINTERFACE('Property','Value',...) creates a new RESULTREVIEWINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resultReviewInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resultReviewInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resultReviewInterface

% Last Modified by GUIDE v2.5 29-May-2018 20:36:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resultReviewInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @resultReviewInterface_OutputFcn, ...
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


% --- Executes just before resultReviewInterface is made visible.
function resultReviewInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resultReviewInterface (see VARARGIN)

% Choose default command line output for resultReviewInterface
global hs;
handles.output = hObject;
if(size(varargin,2)>0)
    
    handles.bestImages = varargin{1};
    handles.queryImage = varargin{2};
    
    if size(varargin,2)>=3
        handles.initialCate = varargin{3};
        contents = cellstr(get(handles.categorySelect,'String'));
        for i=1:size(contents,1)
            if strcmp(handles.initialCate,contents{i})==true %如果字符串匹配
                set(handles.categorySelect,'Value',i);
                break;
            end
        end
    end

    numOfResults = size(handles.bestImages,2);

    set(handles.numText,'String',"The total number of returned results is " + num2str(numOfResults) + ".");
    
    axes(handles.quertImagePanel);
    imshow(handles.queryImage);
    
    if numOfResults == 0
        return;
    end
    
    axes(handles.retrievedimages);
    disp(handles.bestImages)
    hs = cell(1,numOfResults);
    for i = 1:numOfResults
        hs{i} = subplot(floor(numOfResults/3)+1,3,i);
        temp=imread(handles.bestImages{i});
        imshow(temp);
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resultReviewInterface wait for user response (see UIRESUME)
% uiwait(handles.resultReviewInterface);


% --- Outputs from this function are returned to the command line.
function varargout = resultReviewInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in searchRefine.
function searchRefine_Callback(hObject, eventdata, handles)
% hObject    handle to searchRefine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
simpleSearchInterface();

% --- Executes on selection change in sizeSelect.
function sizeSelect_Callback(hObject, eventdata, handles)
% hObject    handle to sizeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sizeSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sizeSelect


% --- Executes during object creation, after setting all properties.
function sizeSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizeSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in advancedSearchRefine.
function advancedSearchRefine_Callback(hObject, eventdata, handles)
% hObject    handle to advancedSearchRefine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
advancedSearchInterface();


% --- Executes on selection change in categorySelect.
function categorySelect_Callback(hObject, eventdata, handles)
% hObject    handle to categorySelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns categorySelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from categorySelect
% contents = cellstr(get(hObject,'String'));
% contents{get(hObject,'Value')};
global hs;
numOfResults = size(handles.bestImages,2);
bestMatch = cell(1,numOfResults);
contents = cellstr(get(hObject,'String'));
category = contents{get(hObject,'Value')};

if category == "null"
    for i=1:size(hs,2)
        %     cla(hs{i},'reset');
        delete(hs{i});
    end
    axes(handles.retrievedimages);
    
    hs = cell(1,numOfResults);
    
    for i = 1:numOfResults
        hs{i} = subplot(floor(numOfResults/3)+1,3,i);
        temp=imread(handles.bestImages{i});
        imshow(temp);
    end
    return;
end

index = 1;
for i = 1:numOfResults
    if size(strfind(handles.bestImages{i},category),1)~=0 % 如果属于当前类别
    bestMatch{index}  = handles.bestImages{i};
    index=index+1;
    end
end

if index==1
    bestImages = cell(0);
else
    bestImages = cell(index-1);
    for i = 1:index-1
        bestImages{i} = bestMatch{i};
    end
end

for i=1:size(hs,2)
    delete(hs{i});
end

if index~=1
   axes(handles.retrievedimages);
end

hs = cell(1,index-1);

for i = 1:index-1
    hs{i} = subplot(floor(index-1/3)+1,3,i);
    temp=imread(bestImages{i});
    imshow(temp);
end

set(handles.numText,'String',"The total number of returned results is " + num2str(index-1) + ".");


% --- Executes during object creation, after setting all properties.
function categorySelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to categorySelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

