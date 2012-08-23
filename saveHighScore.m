function saveHighScore(handles)

score=str2double(get(handles.highScore,'String'));
percent=str2double(get(handles.percentText,'String'));
newScore=str2double(get(handles.scoreValue,'String'));

if newScore >= score
    score=newScore;
elseif newScore<score
    score=score;
end

save('score.mat','score','percent')
