%Created By Group 2 

function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 13-Dec-2021 18:15:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn. 
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
[rawname, rawpath] = uigetfile({'*.jpg'},'Select Image Data');
global fullname
fullname = [rawpath rawname];
set(handles.edit1,'String',rawname);
set(handles.edit2,'String',rawpath);

inputI = imread(fullname);
axes(handles.a1);
imshow(inputI);

% --- Executes on button press in find.
function find_Callback(hObject, eventdata, handles)

%clearing the fields before running again
cla(handles.a2);
cla(handles.a3);
cla(handles.a4);
cla(handles.a5);
set(handles.edit3,'String','');
set(handles.edit4,'String','');

%Declaring and Intializing Variables
global fullname
RGB = imread(fullname);

%Converting RGB Input Image to Grayscale
grayI = rgb2gray(RGB);
axes(handles.a2);
imshow(grayI);

%Displaying Edge Detected for the input Image
im1 = edge(grayI,'canny');
im2 = bwmorph(im1,'dilate',3);
axes(handles.a4);
imshow(im2);

%Converting Grayscale Input Image to 
inputImage = medfilt2(grayI);

%Creating a cell array
c = cell(1,6);

x = 0;
axes(handles.a3);
for i = 1:6
    c{i}=imread(sprintf('%d.JPG',i));
    foundImage = medfilt2(rgb2gray(c{i}));
    r = corr2(inputImage,foundImage);
    if r>0.8500
        set(handles.edit3,'String','Found');
        x=x+1;
        dd = num2str(r);
        set(handles.edit4,'String',dd);
        imshow(c{i});
        
        %Displaying Edge Detected Image
        im3 = edge(foundImage,'canny');
        %dilation
        im4 = bwmorph(im3,'dilate',3);
        axes(handles.a5);
        imshow(im4);
        break;
    end
end

if x == 0
    set(handles.edit3,'String','Not Found');
end 

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
cla(handles.a1);
cla(handles.a2);
cla(handles.a3);
cla(handles.a4);
cla(handles.a5);
set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');
set(handles.edit4,'String','');

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
