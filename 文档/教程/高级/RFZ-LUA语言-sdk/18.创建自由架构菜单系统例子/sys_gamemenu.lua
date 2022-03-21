--游戏菜单系统
--按键系统索引:5

local gamemenu_index=RFZGAMEMENU_TITLE;--菜单索引
local btn_down=0;--某个按键被按下
local fbg=0;
local btn_normal={};
local btn_active={};

local i=0;

function BtnDown5(key)

if     key==RFZLUA.BTN_UP     then

  gamemenu_index=gamemenu_index-1;
  if gamemenu_index<RFZGAMEMENU_TITLE then
    gamemenu_index=RFZGAMEMENU_EXIT;
  end
  
elseif key==RFZLUA.BTN_DOWN   then

  gamemenu_index=gamemenu_index+1;
  if gamemenu_index>RFZGAMEMENU_EXIT then
    gamemenu_index=RFZGAMEMENU_TITLE;
  end
  
elseif key==RFZLUA.BTN_CIRCLE then
  
  btn_down=1;
  
elseif key==RFZLUA.BTN_CROSS  then

  RFZSysGameMenuQuit();--退出游戏菜单
  
end

end


function RFZGameMenu_Init()--游戏菜单初始化接口

InitUserInputProc();
SetUserInputProcIndex(5);
gamemenu_index=RFZGAMEMENU_TITLE;
btn_down=0;
i=0;

fbg            = LoadImage("data/sys/gbg.png",RFZLUA.IMG_8888);
btn_normal[1]  = LoadImage("data/sys/gtitle-off.png",RFZLUA.IMG_8888);
btn_active[1]  = LoadImage("data/sys/gtitle-over.png",RFZLUA.IMG_8888);
btn_normal[2]  = LoadImage("data/sys/gsave-off.png",RFZLUA.IMG_8888);
btn_active[2]  = LoadImage("data/sys/gsave-over.png",RFZLUA.IMG_8888);
btn_normal[3]  = LoadImage("data/sys/gload-off.png",RFZLUA.IMG_8888);
btn_active[3]  = LoadImage("data/sys/gload-over.png",RFZLUA.IMG_8888);
btn_normal[4]  = LoadImage("data/sys/ghistory-off.png",RFZLUA.IMG_8888);
btn_active[4]  = LoadImage("data/sys/ghistory-over.png",RFZLUA.IMG_8888);
btn_normal[5]  = LoadImage("data/sys/gexit-off.png",RFZLUA.IMG_8888);
btn_active[5]  = LoadImage("data/sys/gexit-over.png",RFZLUA.IMG_8888);


end

function RFZGameMenu_Free()--游戏菜单销毁资源接口

FreeImage(fbg);
for i=RFZGAMEMENU_TITLE,RFZGAMEMENU_EXIT do
  FreeImage(btn_normal[i]);
  FreeImage(btn_active[i]);
end
FiniUserInputProc();

end

function RFZGameMenu()--游戏菜单接口

DrawImage(fbg,0,0);
for i=RFZGAMEMENU_TITLE,RFZGAMEMENU_EXIT do
  if gamemenu_index==i then
    DrawImage(btn_active[i],40,23*(i-1)+40);
  else
    DrawImage(btn_normal[i],40,23*(i-1)+40);
  end
end


if btn_down==1 then--某个按键被按下
  btn_down=0;
  if     gamemenu_index==RFZGAMEMENU_TITLE    then--返回标题被按下
  
    ReleaseScene();--释放绘图
    RFZSysGameMenuTitle();--立即执行返回标题
    
  elseif gamemenu_index==RFZGAMEMENU_SAVEGAME then--存档系统按键被按下
    
    ReleaseScene();--释放绘图
    RFZGameMenuSaveSystem();--进入游戏存档系统
    
  elseif gamemenu_index==RFZGAMEMENU_LOADGAME then--读档系统按键被按下
    
    ReleaseScene();--释放绘图
    local loadgame_index = RFZGameMenuLoadSystem();--进入游戏读档系统
    if loadgame_index~=0 then
    --需要读档游戏
      RFZSysGameMenuLoadSavedata(loadgame_index);
    end
    
  elseif gamemenu_index==RFZGAMEMENU_LOG      then--历史回想按键被按下
    
    ReleaseScene();--释放绘图
    RFZGameMenuLogSystem();--进入历史回想系统
    
  elseif gamemenu_index==RFZGAMEMENU_EXIT     then--退出游戏按键被按下
  
    RFZSysGameMenuExit();--立即执行退出游戏
    
  end
  
end

end
