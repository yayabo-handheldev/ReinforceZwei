function BtnDown(key)--按键按下消息

if key==RFZLUA.BTN_CIRCLE then--当键盘L键按下或者PSP○键按下
--重新播放音频
unpause=1;
elseif key==RFZLUA.BTN_UP then--方向上
-- +
angel=angel+20;
if angel>360 then
angel = 0;
end
elseif key==RFZLUA.BTN_DOWN then--方向下
-- -
angel=angel-20;
if angel<0 then
angel = 360;
end
elseif key==RFZLUA.BTN_LEFT then--方向左
-- +
angel=angel+20;
if angel>360 then
angel = 0;
end
elseif key==RFZLUA.BTN_RIGHT then--方向右
-- -
angel=angel-20;
if angel<0 then
angel = 360;
end
end
end



function BtnUp(key)--按键弹起消息
end

function MouseMove(x,y)--鼠标移动消息
end

function MouseBtn(_type,x,y)--鼠标按键消息
end