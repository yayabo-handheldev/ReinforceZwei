--��Ϸ�˵�ϵͳ
--����ϵͳ����:5

local gamemenu_index=RFZGAMEMENU_TITLE;--�˵�����
local btn_down=0;--ĳ������������
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

  RFZSysGameMenuQuit();--�˳���Ϸ�˵�
  
end

end


function RFZGameMenu_Init()--��Ϸ�˵���ʼ���ӿ�

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

function RFZGameMenu_Free()--��Ϸ�˵�������Դ�ӿ�

FreeImage(fbg);
for i=RFZGAMEMENU_TITLE,RFZGAMEMENU_EXIT do
  FreeImage(btn_normal[i]);
  FreeImage(btn_active[i]);
end
FiniUserInputProc();

end

function RFZGameMenu()--��Ϸ�˵��ӿ�

DrawImage(fbg,0,0);
for i=RFZGAMEMENU_TITLE,RFZGAMEMENU_EXIT do
  if gamemenu_index==i then
    DrawImage(btn_active[i],40,23*(i-1)+40);
  else
    DrawImage(btn_normal[i],40,23*(i-1)+40);
  end
end


if btn_down==1 then--ĳ������������
  btn_down=0;
  if     gamemenu_index==RFZGAMEMENU_TITLE    then--���ر��ⱻ����
  
    ReleaseScene();--�ͷŻ�ͼ
    RFZSysGameMenuTitle();--����ִ�з��ر���
    
  elseif gamemenu_index==RFZGAMEMENU_SAVEGAME then--�浵ϵͳ����������
    
    ReleaseScene();--�ͷŻ�ͼ
    RFZGameMenuSaveSystem();--������Ϸ�浵ϵͳ
    
  elseif gamemenu_index==RFZGAMEMENU_LOADGAME then--����ϵͳ����������
    
    ReleaseScene();--�ͷŻ�ͼ
    local loadgame_index = RFZGameMenuLoadSystem();--������Ϸ����ϵͳ
    if loadgame_index~=0 then
    --��Ҫ������Ϸ
      RFZSysGameMenuLoadSavedata(loadgame_index);
    end
    
  elseif gamemenu_index==RFZGAMEMENU_LOG      then--��ʷ���밴��������
    
    ReleaseScene();--�ͷŻ�ͼ
    RFZGameMenuLogSystem();--������ʷ����ϵͳ
    
  elseif gamemenu_index==RFZGAMEMENU_EXIT     then--�˳���Ϸ����������
  
    RFZSysGameMenuExit();--����ִ���˳���Ϸ
    
  end
  
end

end
