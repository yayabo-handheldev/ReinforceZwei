print("testing...");

--����Ϸ�����ٻ���չ�ӿں���-��ʼ

--�������-��ʼ
local game_main_timer=0;--��ʱ��
local game_main_snow_last_timeticks=0;--��ѩ����ʱ��
local game_main_snow_dx={};--��ѩdx��������
local game_main_snow_dy={};--��ѩdy��������
local game_main_snow=0;--ѩ����Դ����
local game_main_snow_counts=100;--ѩ����
local game_main_index=0;--������

local game_main_snow_isopening=0;--�Ƿ�������ѩ��Ч

local game_main_seek=0;--��ʼ��ѩ�Ľű���ַ

--�������-����
function BeginSnow()--��ʼ��ѩ
game_main_snow_isopening=1;--��ѩ�ѿ���
game_main_seek=RFZGetSeek();
RFZWriteValue(1,game_main_seek);--����ǰ�ű���ַ��ֵ��#value[1]��д��浵�ļ�

--��ʼ��ѩ-��ʼ
game_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--����һ��16X16��С��ͼƬ,���ڴ��ѩ��.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--��������
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--����������ɫΪ��ɫ
DrawText(pf,"*",game_main_snow,0,0,RFZLUA.FONT_NORMAL);--���ѩ��"*"
FreeFont(pf);--�ͷ�����

for game_main_index=1,game_main_snow_counts do --��ʼ��dx,dy����
game_main_snow_dx[game_main_index]=4.8*(game_main_index-1);
game_main_snow_dy[game_main_index]=math.random(0,272);--������������������dy����
end

game_main_timer=CreateTimer();--������ʱ��
StartTimer(game_main_timer);--��ʼ��ʱ��
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--��ȡ����ʱ��

game_main_index=0;
--��ʼ��ѩ-����

end


function EndSnow()--������ѩ
game_main_snow_isopening=0;--��ѩ�ر�
RFZWriteValue(1,0);--��#value[1]���㲢д��浵�ļ�

--�ͷ���Դ
FreeTimer(game_main_timer);--�ͷż�ʱ��
FreeImage(game_main_snow);--�ͷ�ѩ��ͼƬ
--�ͷ���Դ

end


function RFZMainReDraw_Init()  --��ʼ����Դ����   -- һ�����ڴ浵��ȡ����Դ��ʼ��

game_main_seek=RFZGetValue(1);--�Ӵ浵�ļ��л�ȡ#value[1]��ֵ�� ��ѩ��ʼ�ĵ�ַ.
game_main_snow_isopening=0;

if  (game_main_seek~=0) and (game_main_seek<=RFZGetSeek()) then--˵���û��浵ʱ,��ѩ��Ч�ǿ�����.
game_main_snow_isopening=1;
game_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--����һ��16X16��С��ͼƬ,���ڴ��ѩ��.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--��������
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--����������ɫΪ��ɫ
DrawText(pf,"*",game_main_snow,0,0,RFZLUA.FONT_NORMAL);--���ѩ��"*"
FreeFont(pf);--�ͷ�����

for game_main_index=1,game_main_snow_counts do --��ʼ��dx,dy����
game_main_snow_dx[game_main_index]=4.8*(game_main_index-1);
game_main_snow_dy[game_main_index]=math.random(0,272);--������������������dy����
end

game_main_timer=CreateTimer();--������ʱ��
StartTimer(game_main_timer);--��ʼ��ʱ��
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--��ȡ����ʱ��

game_main_index=0;

end

end

function RFZMainReDraw_Draw()  --�ٻ溯��         -- ��Ҫʵ���ڲ���Ч

if game_main_snow_isopening==1 then--�ѿ�����ѩ

if (GetTimerTick(game_main_timer)-game_main_snow_last_timeticks)>10 then
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--��������ʱ��

for game_main_index=1,game_main_snow_counts do--�ƶ�ѩ��
game_main_snow_dy[game_main_index]=game_main_snow_dy[game_main_index]+1;
if game_main_snow_dy[game_main_index] > 272 then
game_main_snow_dy[game_main_index]=math.random(0,272);
end
end

end

for game_main_index=1,game_main_snow_counts do--��ѩ
DrawImage(game_main_snow,
game_main_snow_dx[game_main_index],game_main_snow_dy[game_main_index]);
end

end


end

function RFZMainReDraw_Free()  --�����ͷ���Դ���� -- �����ͷ���Ϸ����Դ
end

function RFZMainReDraw_FreeEx()--����ͷ���Դ���� -- ����ͷ���Ϸ����Դ

if game_main_snow_isopening==1 then--�ѿ�����ѩ
--�ͷ���Դ
FreeTimer(game_main_timer);--�ͷż�ʱ��
FreeImage(game_main_snow);--�ͷ�ѩ��ͼƬ
--�ͷ���Դ
end

end

--����Ϸ�����ٻ���չ�ӿں���-����



