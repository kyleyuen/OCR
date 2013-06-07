function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 31-May-2013 09:58:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);
addpath('functions');


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% function edit1_Callback(hObject, eventdata, handles)
% % hObject    handle to edit1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit1 as text
% %        str2double(get(hObject,'String')) returns contents of edit1 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function edit2_Callback(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit2 as text
% %        str2double(get(hObject,'String')) returns contents of edit2 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit2_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on button press in selectFileButton.
function selectFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picture path

[fileName, pathName] = uigetfile;
if isempty(fileName)
end

set(handles.filePathEdit, 'String', fileName);
path = strcat(pathName, fileName);
picture = imread(path);



function filePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filePathEdit as text
%        str2double(get(hObject,'String')) returns contents of filePathEdit as a double


% --- Executes during object creation, after setting all properties.
function filePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in doOCRButton.
function doOCRButton_Callback(hObject, eventdata, handles)
% hObject    handle to doOCRButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path

% Load the weights into variables Theta1 and Theta2
load('../data/weights.mat');

characters = scanImage(path);
characters = recognizeCharacters(Theta1, Theta2, characters);

text = constructText(characters);
for i = 1:length(text)
    for j = 1:length(text{i})
        text{i}{j} = spellCheck(text{i}{j});
    end
end
printText(text, handles);

% --- Executes on button press in showImageButton.
function showImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to showImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picture

figure(2);
imshow(picture);

function printText(text, handles)
resultMessage = {};

for i = 1:length(text)
    message = '';
    for j = 1:length(text{i})
        message = [message, text{i}{j}, ' '];
    end
    resultMessage = [resultMessage, message];
end
set(handles.OCRResultText, 'String', resultMessage);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over OCRResultText.
function OCRResultText_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to OCRResultText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function OCRResultText_Callback(hObject, eventdata, handles)
% hObject    handle to OCRResultText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OCRResultText as text
%        str2double(get(hObject,'String')) returns contents of OCRResultText as a double


% --- Executes during object creation, after setting all properties.
function OCRResultText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OCRResultText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
