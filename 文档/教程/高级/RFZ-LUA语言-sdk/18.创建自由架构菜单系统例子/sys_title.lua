--����˵�ϵͳ


local btn_index=RFZTITLE_NEWGAME;--��ǰ��������:1-5,1��ʾ:newgame�Դ�����
local btn_down=0;--�����Ƿ��Ѿ�����

function BtnDown(key)

if key==RFZLUA.BTN_UP then

  btn_index=btn_index-1;
  if btn_index<RFZTITLE_NEWGAME then
    btn_index=RFZTITLE_EXIT;
  end

elseif key==RFZLUA.BTN_DOWN then

  btn_index=btn_index+1;
  if btn_index>RFZTITLE_EXIT then
    btn_index=RFZTITLE_NEWGAME;
  end

elseif key==RFZLUA.BTN_CIRCLE then

btn_down=1;--��������

end

end


function RFZTitleSystem()


InitUserInputProc();
SetUserInputProcIndex(0);

local bg=LoadImage("data/sys/title/0000000.png",RFZLUA.IMG_8888);
local fbg=LoadImage("data/sys/title/0000001.png",RFZLUA.IMG_8888);
local fbg2=LoadImage("data/sys/title/0000002.png",RFZLUA.IMG_8888);

local bg_dy=0;
local bg_dy2=272;
local fbg_dy=272;

local bg_dy_timetick=10;
local bg_ef  =  effect_create_fadein(0,255,3000);
local fbg_ef =  effect_create_fadein(0,255,2000);
local fbg_ef2=  effect_create_fadein(0,255,3000);

local btn_normal={};
btn_normal[RFZTITLE_NEWGAME]=LoadImage("data/sys/sys_title_003.grp.png",RFZLUA.IMG_8888);
btn_normal[RFZTITLE_LOADGAME]=LoadImage("data/sys/sys_title_008.grp.png",RFZLUA.IMG_8888);
btn_normal[RFZTITLE_CG]=LoadImage("data/sys/sys_title_013.grp.png",RFZLUA.IMG_8888);
btn_normal[RFZTITLE_CGMEMORY]=LoadImage("data/sys/sys_title_016.grp.png",RFZLUA.IMG_8888);
btn_normal[RFZTITLE_EXIT]=LoadImage("data/sys/sys_title_019.grp.png",RFZLUA.IMG_8888);

local btn_active={};
btn_active[RFZTITLE_NEWGAME]=LoadImage("data/sys/sys_title_004.grp.png",RFZLUA.IMG_8888);
btn_active[RFZTITLE_LOADGAME]=LoadImage("data/sys/sys_title_009.grp.png",RFZLUA.IMG_8888);
btn_active[RFZTITLE_CG]=LoadImage("data/sys/sys_title_014.grp.png",RFZLUA.IMG_8888);
btn_active[RFZTITLE_CGMEMORY]=LoadImage("data/sys/sys_title_017.grp.png",RFZLUA.IMG_8888);
btn_active[RFZTITLE_EXIT]=LoadImage("data/sys/sys_title_020.grp.png",RFZLUA.IMG_8888);

local btn_ef={};
btn_ef[RFZTITLE_NEWGAME]=effect_create_fadein(0,255,100);
btn_ef[RFZTITLE_LOADGAME]=effect_create_fadein(0,255,300);
btn_ef[RFZTITLE_CG]=effect_create_fadein(0,255,500);
btn_ef[RFZTITLE_CGMEMORY]=effect_create_fadein(0,255,700);
btn_ef[RFZTITLE_EXIT]=effect_create_fadein(0,255,900);


local quit=0;--�˳����

local timer = CreateTimer();
StartTimer(timer);
local timetick = GetTimerTick(timer);

btn_index=RFZTITLE_NEWGAME;
local i=RFZTITLE_NEWGAME;
btn_down=0;

local loadgame_index=0;--��������,���ڶ���ϵͳʱ,������Ϸ�󷵻ر���˵�ϵͳ��ķ���ֵ.

while quit==0 do

if bg_dy>=-272 and fbg_dy>=0 then
  if (GetTimerTick(timer)-timetick)>bg_dy_timetick then
    timetick = GetTimerTick(timer);
    bg_dy=bg_dy-1;
    if bg_dy==-272 then
      bg_dy=-300;
    end
    fbg_dy=fbg_dy-1;
  end
  
elseif bg_dy2>=0 and fbg_dy<=0 then

  if (GetTimerTick(timer)-timetick)>bg_dy_timetick then
    timetick = GetTimerTick(timer);
    bg_dy2=bg_dy2-1;
    if bg_dy2<0 then
      bg_dy2=0;
    end
    fbg_dy=fbg_dy-1;
    if fbg_dy==-272 then
      fbg_dy=300;
      FreeImage(fbg);
      fbg=LoadImage("data/sys/sys_title_002.grp.png",RFZLUA.IMG_8888);
    end
  end
  
end

BeginScene(1);

if bg_dy2==0 then
  DrawImage(fbg2,0,0);
  DrawEffect(fbg_ef,fbg,0,0);
elseif bg_dy2==272 then
  DrawEffect(bg_ef,bg,0,bg_dy);
  DrawEffect(fbg_ef2,fbg,0,fbg_dy);
else
  DrawEffect(bg_ef,fbg2,0,bg_dy2);
  DrawEffect(fbg_ef2,fbg,0,fbg_dy);
end


if GetEffectStatus(fbg_ef)==RFZLUA.EFFECT_STOP then--���ǰ����Ч��ʾ�����ʾ����

  for i=RFZTITLE_NEWGAME,RFZTITLE_EXIT do
    if i==btn_index then
      DrawEffect(btn_ef[i],btn_active[i],150,(i-1)*30+80);
    else
      DrawEffect(btn_ef[i],btn_normal[i],150,(i-1)*30+80);
    end
   end

end

EndScene();

if GetEffectStatus(fbg_ef)==RFZLUA.EFFECT_STOP then--���ǰ����Ч��ʾ�����ʾ����

  if btn_down==1 then--���������� 
    btn_down=0;
    if 
    GetEffectStatus(btn_ef[5])==RFZLUA.EFFECT_STOP
    and 
    GetEffectStatus(btn_ef[4])==RFZLUA.EFFECT_STOP 
    and
    GetEffectStatus(btn_ef[3])==RFZLUA.EFFECT_STOP 
    and
    GetEffectStatus(btn_ef[2])==RFZLUA.EFFECT_STOP 
    and
    GetEffectStatus(btn_ef[1])==RFZLUA.EFFECT_STOP 
    then--��ǰû��һ����Ч������
      if btn_index==RFZTITLE_NEWGAME then--��������Ϸ����
        quit=1;--�˳�ѭ��
      elseif btn_index==RFZTITLE_LOADGAME then--���¶�����Ϸ����
        loadgame_index=RFZTitleLoadSystem();--����ϵͳ
          if loadgame_index~=0 then--��Ҫ���ж�������
            quit=1;--�˳�ѭ��
          end
      elseif btn_index==RFZTITLE_CG then--����CGģʽ����
        RFZTitleCGMode();--CGģʽ
      elseif btn_index==RFZTITLE_CGMEMORY then--����CG����ģʽ����
        RFZTitleCGMemoryMode();--CG����ģʽ
      elseif btn_index==RFZTITLE_EXIT then--�����˳���Ϸ����
        quit=1;--�˳�ѭ��
      end
    end    
  end
  
end

end

FreeTimer(timer);
FreeImage(bg);
FreeImage(fbg);
FreeImage(fbg2);

for i=RFZTITLE_NEWGAME,RFZTITLE_EXIT do
  FreeImage(btn_normal[i]);
  FreeImage(btn_active[i]);
  FreeEffect(btn_ef[i]);
end

FreeEffect(fbg_ef2);
FreeEffect(bg_ef);
FreeEffect(fbg_ef);
FiniUserInputProc();

--���ڴ���
if btn_index==RFZTITLE_NEWGAME then--��������Ϸ����
  RFZJump("*title_newgame");--script.rfz�ű���ת��*title_newgame��ǩ��

elseif btn_index==RFZTITLE_LOADGAME then--���¶�����Ϸ����

  if loadgame_index~=0 then--��Ҫ���ж�������
    --print(loadgame_index);
    local ierror = RFZSysLoadSavedata(loadgame_index);--����
    if     ierror==RFZLUA.LOADDATA_ERROR   then--������������
      RFZJump("*title_exit");--script.rfz�ű���ת��*title_exit��ǩ��
    elseif ierror==RFZLUA.LOADDATA_EXIT    then--�����˳���Ϸ��Ϣ
      RFZJump("*title_exit");--script.rfz�ű���ת��*title_exit��ǩ��
    elseif ierror==RFZLUA.LOADDATA_RESTART then--�������ر�����Ϣ
      RFZJump("*title_restart");--script.rfz�ű���ת��*title_restart��ǩ��
    end

end

elseif btn_index==RFZTITLE_CG then--����CGģʽ����

elseif btn_index==RFZTITLE_CGMEMORY then--����CG����ģʽ����

elseif btn_index==RFZTITLE_EXIT then--�����˳���Ϸ����
  RFZJump("*title_exit");--script.rfz�ű���ת��*title_exit��ǩ��

end


end