function ball(handles)

%% Create background
iVenue=get(handles.venueMenu,'Value');
switch iVenue
    case 2
        axes(handles.gamesAxes);
        img=imread('joycebckgrnd.jpeg');
        imagesc([0 27], [-2 17],img);
        set(gca,'YDir','normal');
        axis equal
    case 3
        axes(handles.gamesAxes);
        img=imread('ruckerbckgrnd.jpeg');
        imagesc([0 27], [-2 17],img);
        set(gca,'YDir','normal');
        axis equal
end

hold on

%% Plot ball
%% set parameters
g=32.174; % ft/s^2 acceleration due to gravity
theta = str2double(get(handles.angleValue,'String'));
ax=0;
ay=-g ;
x=str2double(get(handles.distanceValue,'String'));
x0=21-x; %m
a=get(handles.feetText,'String');
anum=str2double(a);
b=get(handles.inchesText,'String');
bn=str2double(b);
bnum=bn/12;
y0=anum+bnum;
power=str2double(get(handles.powerValue,'String'));
velo = 40*(power/100);
vx0 =velo*cosd(theta); %ft/ s
vy0=velo*sind(theta);
Tf =45; %s
Nt=800;
ballimage = imread('ball.jpg');
ballmask = ballimage(:,:,3) > 150;
img=image('CData',ballimage);
ball_diameter = 1.4; % feet
%% initialize
t =linspace(0 , Tf , Nt ) ;
x=zeros(1 , Nt);
y=zeros(1 , Nt);
vx=zeros(1 , Nt);
vy=zeros(1 , Nt);
deltat = t(2)-t(1);
x(1)= x0 ;
y(1)= y0;
vx(1)=vx0;
vy(1)=vy0;
for it = 1: Nt-1
    vx(it+1)=vx(it)+ax*deltat;
    vy(it+1)=vy(it)+ay*deltat;
    x(it+1)=x(it)+ 0.5*(vx(it+1)+vx(it))*deltat;
    y(it+1)=y(it)+ 0.5*(vy(it+1)+vy(it))*deltat;
    %% Ground bounce condition
    if (y(it+1)<0)
        vy(it+1) = (abs((sin(pi/4))*vy(it+1)));
        if abs(vy(it+1)) < 0.5
            vy(it+1) = 0;
            y(it+1) = 0;
        end
        %% Rolling condition
        if vy(it+1) == 0;
            if vx(it+1) < 0
                ax = 0.1*g;
                if abs(vx(it+1))<0.2
                    vx(it+1) = 0;
                end
            elseif vx(it+1) > 0
                ax = -0.1*g;
                if abs(vx(it+1))<0.2
                    vx(it+1) = 0;
                end
            end
        end
    end
    %% Rim bouncing conditions
    if (x(it+1)>=20.85) && (x(it+1)<=22.25) && (y(it+1)>=10.6) && (y(it+1)<=12)
        if vy(it+1) >= 0
            vy(it+1) = -(abs((sin(pi/4))*vy(it+1)));
            y(it+1) = 10.59;
            if x(it+1)<21.55
                vx(it+1) = -abs((sin(pi/4))*vx(it+1));
            elseif x(it+1)>=21.55
                vx(it+1) = abs((sin(pi/4))*vx(it+1));
            end
        elseif vy(it+1) <= 0
            vy(it+1) = (abs((sin(pi/4))*vy(it+1)));
            y(it+1) = 12.001;
            if x(it+1)<21.55
                vx(it+1) = -abs((sin(pi/4))*vx(it+1));
            elseif x(it+1)>=21.55
                vx(it+1) = abs((sin(pi/4))*vx(it+1));
            end
        end
    end
    %% Back Rim
    if (x(it+1)>=23.9) && (x(it+1)<=24.4) && (y(it+1)>=10.6) && (y(it+1)<=12)
        if vy(it+1) >= 0
            vy(it+1) = -(abs((sin(pi/4))*vy(it+1)));
            y(it+1) = 10.59;
            if x(it+1)<24.15
                vx(it+1) = -abs((sin(pi/4))*vx(it+1));
            elseif x(it+1)>=24.15
                vx(it+1) = abs((sin(pi/4))*vx(it+1));
            end
        elseif vy(it+1) <= 0
            vy(it+1) = (abs((sin(pi/4))*vy(it+1)));
            y(it+1) = 12.001;
            if x(it+1)<24.15
                vx(it+1) = -abs((sin(pi/4))*vx(it+1));
            elseif x(it+1)>=24.15
                vx(it+1) = abs((sin(pi/4))*vx(it+1));
            end
        end
    end
    %% Backboard Bouncing Conditions
    if (x(it+1)<25.8) && (x(it+1)>24.4) && (y(it+1)>=9.6) && (y(it+1)<=17)
        if vx(it+1)>=0
            vx(it+1) = -abs((sin(pi/4))*vx(it+1));
            x(it+1) = 24.125;
        elseif vx(it+1)<=0
            vx(it+1) = abs((sin(pi/4))*vx(it+1));
            x(it+1) = 25.5;
        end
    end
    %% Scoring Conditions
    if (x(it+1)>22.2) && (x(it+1)<24) && (y(it+1)>=10.6) && (y(it+1)<=11.6) && vy(it+1)<0
        y(it+1) = 10.6;
    end
    %% Wall bouncing conditions
    if (x(it+1)>25.6)
        vx(it+1) = -abs((sin(pi/4))*vx(it+1));
    elseif (x(it+1)<0)
        vx(it+1) = abs((sin(pi/4))*vx(it+1));
    end
end

%% plot results animating motion
xmax=27;
xmin=0;
ymax=17;
ymin=-2;
% for it =1:5:Nt
%plot(x(it) , y(it), 'ro');
%axis ([ xmin xmax ymin ymax ] ) ;
%xlabel('x(m)');
%ylabel('y(m)');
%drawnow
%end
%set(ball_image, 'Parent', hgtransform);

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


for it = 1:100;
    
    %% Scoring Conditions
    if (x(it+1)>22.2) && (x(it+1)<24) && (y(it+1)>=10.6) && (y(it+1)<=11.6) && vy(it+1)<0
        score=str2double(get(handles.scoreValue,'String'));
        distance=str2double(get(handles.distanceValue,'String'));
        b=str2double(get(handles.madeText,'String'));
        made=b+1;
        set(handles.madeText,'String',num2str(made))
        if distance<20
            set(handles.scoreValue,'String',num2str(score+2));
        elseif distance >=20
            set(handles.scoreValue,'String',num2str(score+3));
        end
    end
    %% Plot of the ball (spin doesn't work yet)
    %angle_spin = 30;
    %ball_spin = imrotate(ball_image, angle_spin);
    %rot_angle = -(it/Nt)*pi;
    %rball = makehgtform('zrotate', rot_angle);
    set(img,'XData',[x(it) x(it)+ball_diameter]);
    set(img,'YData',[y(it) y(it)+ball_diameter]);
    set(img,'AlphaData',~ballmask);
    axis([xmin xmax ymin ymax]);
    
    drawnow
end

%% Updates stats

a=str2double(get(handles.attText,'String'));
m=str2double(get(handles.madeText,'String'));
percent=(m/a)*100;
set(handles.percentText,'String',num2str(percent));
set(handles.shootButton,'Enable','on');

%% Number of Shots
a=str2double(get(handles.attText,'String'));

if a<10
    %% spawn position of new ball
    axes(handles.gamesAxes)
    pos_x=randi(20);
    a=get(handles.feetText,'String');
    anum=str2double(a);
    b=get(handles.inchesText,'String');
    bn=str2double(b);
    bnum=bn/12;
    pos_y=anum+bnum;
    set(handles.distanceValue,'String', num2str(22-(pos_x)));
    
    %% Plot and mask ball
    ball_diameter = 1.4;
    ballimage=imread('ball.jpg');
    ballmask = ballimage(:,:,3) > 150;
    img=image('CData',ballimage);
    ball_diameter = 1.4;
    set(img,'XData',[pos_x pos_x+ball_diameter]);
    set(img,'YData',[pos_y pos_y+ball_diameter]);
    set(img,'AlphaData',~ballmask);
    
    %% Resest Timer
    t=linspace(1,24,24);
    set(handles.timeText,'ForegroundColor',[0.749 0.749 0]);
    set(handles.timeText,'String',24)
    pause(1)
    
    for it=1:24
        shot=str2double(get(handles.attText,'String'));
        if shot==10, break, end
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
        a=str2double(get(handles.attText,'String'));
        attempts=a+1;
        set(handles.attText,'String',num2str(attempts))
        score=get(handles.scoreValue,'String');
        msgbox({['Shot clock expired!';'You turned the ball over!';'You scored ', num2str(score), 'points.' ;'']}, 'Game Over', 'Warn')
        
    end
elseif a==10
    set(handles.startButton, 'Enable', 'inactive')
    set(handles.shootButton,'Enable','inactive')
    score=get(handles.scoreValue,'String');
    percent=get(handles.percentText,'String');
    set(handles.powerSlider, 'Enable', 'off')
    set(handles.angleSlider, 'Enable', 'off')
    msgbox(['GAME OVER. You shot ', num2str(percent) , '% to score ', num2str(score),' points!'],'Game Over');
    msgbox('Click "New Game" under File menu to start a new game','New Game', 'help')
    saveHighScore(handles)
    loadHighScore(handles)
end



%ball=imread('ball.jpg');
%imagesc([pos_x pos_x+ball_diameter], [pos_y pos_y+ball_diameter],ball);
%set(gca,'YDir','normal');                       %Sets image of ball at location

%powerBar(handles)