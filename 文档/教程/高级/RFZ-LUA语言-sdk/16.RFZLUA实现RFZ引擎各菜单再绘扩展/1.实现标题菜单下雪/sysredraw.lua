--����˵��ٻ�-��ʼ

--������-��ʼ{

--�������-��ʼ
local title_main_timer=0;--��ʱ��
local title_main_snow_last_timeticks=0;--��ѩ����ʱ��
local title_main_snow_dx={};--��ѩdx��������
local title_main_snow_dy={};--��ѩdy��������
local title_main_snow=0;--ѩ����Դ����
local title_main_snow_counts=100;--ѩ����
local title_main_index=0;--������
--�������-����

function RFZTitleReDraw_MainInit()--��ʼ����Դ����

title_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--����һ��16X16��С��ͼƬ,���ڴ��ѩ��.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--��������
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--����������ɫΪ��ɫ
DrawText(pf,"*",title_main_snow,0,0,RFZLUA.FONT_NORMAL);--���ѩ��"*"
FreeFont(pf);--�ͷ�����

for title_main_index=1,title_main_snow_counts do --��ʼ��dx,dy����
title_main_snow_dx[title_main_index]=4.8*(title_main_index-1);
title_main_snow_dy[title_main_index]=math.random(0,272);--������������������dy����
end

title_main_timer=CreateTimer();--������ʱ��
StartTimer(title_main_timer);--��ʼ��ʱ��
title_main_snow_last_timeticks=GetTimerTick(title_main_timer);--��ȡ����ʱ��

title_main_index=0;

end

function RFZTitleReDraw_MainDraw()--�ٻ溯��

if (GetTimerTick(title_main_timer)-title_main_snow_last_timeticks)>10 then
title_main_snow_last_timeticks=GetTimerTick(title_main_timer);--��������ʱ��

for title_main_index=1,title_main_snow_counts do--�ƶ�ѩ��
title_main_snow_dy[title_main_index]=title_main_snow_dy[title_main_index]+1;
if title_main_snow_dy[title_main_index] > 272 then
title_main_snow_dy[title_main_index]=math.random(0,272);
end
end

end

for title_main_index=1,title_main_snow_counts do--��ѩ
DrawImage(title_main_snow,
title_main_snow_dx[title_main_index],title_main_snow_dy[title_main_index]);
end

end

function RFZTitleReDraw_MainFree()--�ͷ���Դ����

FreeTimer(title_main_timer);--�ͷż�ʱ��
FreeImage(title_main_snow);--�ͷ�ѩ��ͼƬ

end
--������-����}

