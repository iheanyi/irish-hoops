function varargout = iHoops3(varargin)
% IHOOPS3 MATLAB code for iHoops3.fig
%      IHOOPS3, by itself, creates a new IHOOPS3 or raises the existing
%      singleton*.
%
%      H = IHOOPS3 returns the handle to a new IHOOPS3 or the handle to
%      the existing singleton*.
%
%      IHOOPS3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IHOOPS3.M with the given input arguments.
%
%      IHOOPS3('Property','Value',...) creates a new IHOOPS3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iHoops3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iHoops3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iHoops3

% Last Modified by GUIDE v2.5 25-Apr-2011 16:07:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @iHoops3_OpeningFcn, ...
    'gui_OutputFcn',  @iHoops3_OutputFcn, ...
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


% --- Executes just before iHoops3 is made visible.
function iHoops3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iHoops3 (see VARARGIN)
loadHighScore(handles)                      % Loads high score

set(handles.powerSlider, 'Enable', 'off')
set(handles.angleSlider, 'Enable', 'off')
axes(handles.backgroundAxes);
background=imread('back.jpg');
imagesc([0 1],[0 1],background);
axis off

start=imread('start.jpg');
set(handles.startButton,'CData',start)

shoot=imread('shoot.jpg');
set(handles.shootButton,'CData',shoot)
% Choose default command line output for iHoops3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iHoops3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iHoops3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in shootButton.
function shootButton_Callback(hObject, eventdata, handles)
% hObject    handle to shootButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.shootButton, 'Enable', 'inactive');
a=str2double(get(handles.attText,'String'));
attempts=a+1;
set(handles.attText,'String',num2str(attempts))
ball(handles);

% --- Executes on slider movement.
function powerSlider_Callback(hObject, eventdata, handles)
% hObject    handle to powerSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(handles.powerSlider, 'Value');
b = num2str(a);
set(handles.powerValue, 'String', b)
% --- Executes during object creation, after setting all properties.
function powerSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to powerSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angleSlider_Callback(hObject, eventdata, handles)
% hObject    handle to angleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(handles.angleSlider, 'Value');
b = num2str(a);
set(handles.angleValue, 'String', b)

% --- Executes during object creation, after setting all properties.
function angleSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in venueMenu.
function venueMenu_Callback(hObject, eventdata, handles)
% hObject    handle to venueMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns venueMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from venueMenu
venue(handles)

% --- Executes during object creation, after setting all properties.
function venueMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to venueMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in playerMenu.
function playerMenu_Callback(hObject, eventdata, handles)
% hObject    handle to playerMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns playerMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from playerMenu
player(handles)

% --- Executes during object creation, after setting all properties.
function playerMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playerMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.venueMenu,'Enable','inactive')
set(handles.playerMenu,'Enable','inactive')
set(handles.powerSlider, 'Enable', 'on')
set(handles.angleSlider, 'Enable', 'on')
set(handles.startButton, 'Enable', 'inactive')

start=get(handles.playerMenu,'Value');              %Gets player information
venue=get(handles.venueMenu,'Value');               %Gets venue information

if start==1 && venue==1                             %Prompts user to select player/venue
    msgbox('Please select a player and venue!', 'Error', 'error')
elseif start==1
    msgbox('Please select a player!', 'Error', 'error')
elseif venue==1
    msgbox('Please select a venue!', 'Error', 'error')
else
    iVenue=get(handles.venueMenu,'Value');          %Sets venue again
    switch iVenue
        case 2
            axes(handles.gamesAxes);
            img=imread('joycebckgrnd.jpeg');
            imagesc([0 27], [-2 17],img);
            set(gca,'YDir','normal')
            set(handles.gamesAxes,'XTick',[])
            set(handles.gamesAxes,'YTick',[])
            axis equal
            hold on
            
        case 3
            axes(handles.gamesAxes);
            img=imread('ruckerbckgrnd.jpeg');
            imagesc([0 27], [-2 17],img);
            set(gca,'YDir','normal')
            set(handles.gamesAxes,'XTick',[])
            set(handles.gamesAxes,'YTick',[])
            axis equal
            hold on
            
    end
    x=randi(20);                                    %Generates random location for ball
    a=get(handles.feetText,'String');
    anum=str2double(a);
    b=get(handles.inchesText,'String');
    bn=str2double(b);
    bnum=bn/12;
    y=anum+bnum;                                    %Sets ball at height of player
    hold on
    
    %ball_diameter = 1.4;
    %ball=imread('ball.jpg');
    %imagesc([x x+ball_diameter], [y y+ball_diameter],ball);
    %set(gca,'YDir','normal');                       %Sets image of ball at location
    
    %% Plot and mask ball
    ballimage=imread('ball.jpg');
    ballmask = ballimage(:,:,3) > 150;
    img=image('CData',ballimage);
    ball_diameter = 1.4;
    set(img,'XData',[x x+ball_diameter]);
    set(img,'YData',[y y+ball_diameter]);
    set(img,'AlphaData',~ballmask);
    axis([0 27 -2 17])
    
    
    %% Draw net
    netx=[22.25 23.15 23.65 24.15 25 24.6 24.25 23.65 23 22.65 22.25];
    nety=[12 9.75 12 9.75 12 9.75 12 9.75 12 9.75 12];
    
    line(netx,nety, 'Color', 'w')
    
    %% Draw rim
    rimx=[22.05 25.5];
    rimy=[12 12];
    line(rimx, rimy, 'Color', 'r', 'LineWidth', 3.5)
    
    boardx=[25.5 25.5];
    boardy= [11 17];
    line(boardx,boardy, 'Color', 'w', 'LineWidth', 8)
    
    %% Draw support
    supportx=[25.5 28];
    supporty=[15 17];
    line(supportx, supporty, 'Color', 'w', 'LineWidth', 6)
    
    axis([0 27 -2 17])
    
    %% Initial Distance/Score
    
    set(handles.distanceValue,'String', num2str(22-(x)));       %Displays distance
    
    set(handles.scoreValue,'String', num2str(0));               %Sets score to zero
    
    set(handles.timeText,'String',24);
    
    t=linspace(1,24,24);
    pause(1)
    for it=1:24                                                %Starts timer
        shot=str2double(get(handles.attText,'String'));
        if shot~=0, break, end
        set(handles.timeText,'String', num2str(24-t(it)));
        c=get(handles.timeText,'String');
        cnum=str2double(c);
        if cnum <=10
            set(handles.timeText,'ForegroundColor',[1 0 0]);
        end
        pause(1)
    end
    
    x=str2double(get(handles.timeText,'String'));
    if x==0
        msgbox([{'Shot clock expired!';'You turned the ball over!';'You scored 0 points';''}], 'Game Over', 'Warn')
    end
end



% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function helpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to helpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function aboutMenu_Callback(hObject, eventdata, handles)
% hObject    handle to aboutMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'';'Introduction to Irish Hoops:';'';'Irish Hoops was programmed and designed as a project for second semester engineers at the University of Notre Dame.';' ';'Iheanyi Ekechuwu, 2014';'Jake Flynt, 2014';'Martin Le, 2014';'Pat McFarlane, 2014';'';'The game was programmed entirely in MathWorks MatLab 7.11 during the 2011 spring semester.';'';'';'';'Copyright © 2011';'All rights reserved'},'About Irish Hoops', 'help')

% --------------------------------------------------------------------
function howMenu_Callback(hObject, eventdata, handles)
% hObject    handle to howMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'';'Goal:';' ';'To score as many points as possible, through successful two- or three-point baskets in the allotted ten shots.';' ';'Game Play:';' ';'1.   Select a player and venue to use then click start to begin game.'; '2.   Upon starting a game, the shot clock will begin to run and the';'       ball will spawn at a random distance from the hoop.';'3.   Use the power and angle sliders to select the desired values';'       to shoot the ball at.';'4.   Click the shoot button to shoot the ball. If you do not shoot before';'       the shot clock expires, the game is over.'; '5.   The ball will launch with an initial velocity and angle as';'       determined by the information from the power and angle sliders'; '       controlled by the user.'; '6.   When the ball either goes in to the hoop or misses and bounces';'       around the venue, a new ball will be spawned at a new random';'       distance from the hoop.'; '7.	  Repeat until you have taken ten shots.';' ';''}, 'How to play', 'help')

% --------------------------------------------------------------------
function newMenu_Callback(hObject, eventdata, handles)
% hObject    handle to newMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all force
run iHoops3


% --------------------------------------------------------------------
function exitMenu_Callback(hObject, eventdata, handles)
% hObject    handle to exitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all force


% --------------------------------------------------------------------
function viewHigh_Callback(hObject, eventdata, handles)
% hObject    handle to viewHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
high=get(handles.highScore,'String');
percent=get(handles.highPercent,'String');
msgbox(['HIGH SCORE: ', high,' points at ', percent, '%.'], 'Irish Hoops High Score', 'help');
