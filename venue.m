function venue(handles)

iVenue=get(handles.venueMenu,'Value');

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


axes(handles.gamesAxes);

    %% Plot and mask ball
    ballimage=imread('ball.jpg');
    ballmask = ballimage(:,:,3) > 150;
    img=image('CData',ballimage);
    ball_diameter = 1.4;
    set(img,'XData',[2 2+ball_diameter]);
    set(img,'YData',[0 0+ball_diameter]);
    set(img,'AlphaData',~ballmask);

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

