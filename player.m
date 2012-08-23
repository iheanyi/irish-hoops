function player(handles)

iplayer=get(handles.playerMenu,'Value');
switch iplayer
    case 1
        
    case 2
        axes(handles.axes6)
        imshow('nash.jpg')
        set(handles.feetText,'String', 6)
        set(handles.inchesText,'String',8)
        set(handles.axes6,'Box','on')
    case 3
        axes(handles.axes6)
        imshow('hansbrough.jpg')
        set(handles.feetText,'String', 6)
        set(handles.inchesText,'String',3)
        set(handles.axes6,'Box','on')
    case 4
        axes(handles.axes6)
        imshow('abromaitis.jpg')
        set(handles.feetText,'String', 6)
        set(handles.inchesText,'String',8)
        set(handles.axes6,'Box','on')
        
end