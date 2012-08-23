function loadHighScore(handles)

fileName='score.mat';

if exist(fileName)
    load(fileName,'score','percent')
    set(handles.highScore,'String', num2str(score));
    set(handles.highPercent,'String', num2str(percent));
end