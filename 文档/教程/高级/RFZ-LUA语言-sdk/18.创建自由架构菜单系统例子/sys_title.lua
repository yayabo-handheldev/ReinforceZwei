--标题菜单系统


local btn_index=RFZTITLE_NEWGAME;--当前按键索引:1-5,1表示:newgame以此类推
local btn_down=0;--按键是否已经按下

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

btn_down=1;--按键按下

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


local quit=0;--退出标记

local timer = CreateTimer();
StartTimer(timer);
local timetick = GetTimerTick(timer);

btn_index=RFZTITLE_NEWGAME;
local i=RFZTITLE_NEWGAME;
btn_down=0;

local loadgame_index=0;--读档索引,当在读档系统时,读档游戏后返回标题菜单系统后的返回值.

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


if GetEffectStatus(fbg_ef)==RFZLUA.EFFECT_STOP then--如果前景特效显示完就显示按键

  for i=RFZTITLE_NEWGAME,RFZTITLE_EXIT do
    if i==btn_index then
      DrawEffect(btn_ef[i],btn_active[i],150,(i-1)*30+80);
    else
      DrawEffect(btn_ef[i],btn_normal[i],150,(i-1)*30+80);
    end
   end

end

EndScene();

if GetEffectStatus(fbg_ef)==RFZLUA.EFFECT_STOP then--如果前景特效显示完就显示按键

  if btn_down==1 then--按键被按下 
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
    then--当前没有一个特效在运行
      if btn_index==RFZTITLE_NEWGAME then--按下新游戏按键
        quit=1;--退出循环
      elseif btn_index==RFZTITLE_LOADGAME then--按下读档游戏按键
        loadgame_index=RFZTitleLoadSystem();--读档系统
          if loadgame_index~=0 then--需要进行读档操作
            quit=1;--退出循环
          end
      elseif btn_index==RFZTITLE_CG then--按下CG模式按键
        RFZTitleCGMode();--CG模式
      elseif btn_index==RFZTITLE_CGMEMORY then--按下CG回想模式按键
        RFZTitleCGMemoryMode();--CG回想模式
      elseif btn_index==RFZTITLE_EXIT then--按下退出游戏按键
        quit=1;--退出循环
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

--后期处理
if btn_index==RFZTITLE_NEWGAME then--按下新游戏按键
  RFZJump("*title_newgame");--script.rfz脚本跳转到*title_newgame标签处

elseif btn_index==RFZTITLE_LOADGAME then--按下读档游戏按键

  if loadgame_index~=0 then--需要进行读档操作
    --print(loadgame_index);
    local ierror = RFZSysLoadSavedata(loadgame_index);--读档
    if     ierror==RFZLUA.LOADDATA_ERROR   then--读档索引错误
      RFZJump("*title_exit");--script.rfz脚本跳转到*title_exit标签处
    elseif ierror==RFZLUA.LOADDATA_EXIT    then--读档退出游戏消息
      RFZJump("*title_exit");--script.rfz脚本跳转到*title_exit标签处
    elseif ierror==RFZLUA.LOADDATA_RESTART then--读档返回标题消息
      RFZJump("*title_restart");--script.rfz脚本跳转到*title_restart标签处
    end

end

elseif btn_index==RFZTITLE_CG then--按下CG模式按键

elseif btn_index==RFZTITLE_CGMEMORY then--按下CG回想模式按键

elseif btn_index==RFZTITLE_EXIT then--按下退出游戏按键
  RFZJump("*title_exit");--script.rfz脚本跳转到*title_exit标签处

end


end