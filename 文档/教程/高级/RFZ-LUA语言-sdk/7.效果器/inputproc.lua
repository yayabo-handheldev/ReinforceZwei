function BtnDown(key)--����������Ϣ

if key==RFZLUA.BTN_CIRCLE then--������L�����»���PSP�������
--���²�����Ƶ
unpause=1;
elseif key==RFZLUA.BTN_UP then--������
-- +
angel=angel+20;
if angel>360 then
angel = 0;
end
elseif key==RFZLUA.BTN_DOWN then--������
-- -
angel=angel-20;
if angel<0 then
angel = 360;
end
elseif key==RFZLUA.BTN_LEFT then--������
-- +
angel=angel+20;
if angel>360 then
angel = 0;
end
elseif key==RFZLUA.BTN_RIGHT then--������
-- -
angel=angel-20;
if angel<0 then
angel = 360;
end
end
end



function BtnUp(key)--����������Ϣ
end

function MouseMove(x,y)--����ƶ���Ϣ
end

function MouseBtn(_type,x,y)--��갴����Ϣ
end