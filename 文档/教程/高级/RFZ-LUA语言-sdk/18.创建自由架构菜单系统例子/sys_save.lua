--存档系统
--按键系统索引:1


local quit = 0;--退出标志
local btn_down=0;--按键是否按下
local btn_dy=22;
local btn_updata_fontbg=0;--是否更新字体背景
local savedata_index=1;--当前存档索引

function BtnDown1(key)

if key==RFZLUA.BTN_UP then

  savedata_index=savedata_index-1;
    if savedata_index<1 then
      savedata_index=RFZLUA.SAVEDATA_MAXDATA;
    end
  btn_dy=btn_dy-2;
  if btn_dy<22 then
    btn_dy=222;
  end
  btn_updata_fontbg=1;

elseif key==RFZLUA.BTN_DOWN then

  savedata_index=savedata_index+1;
  if savedata_index>RFZLUA.SAVEDATA_MAXDATA then
    savedata_index=1;
  end
  btn_dy=btn_dy+2;
  if btn_dy>=222 then
    btn_dy=22;
  end
  btn_updata_fontbg=1;

elseif key==RFZLUA.BTN_CIRCLE then

btn_down=1;

elseif key==RFZLUA.BTN_CROSS then

quit=1;

end

end


function RFZGameMenuSaveSystem()--游戏菜单存档函数

SetUserInputProcIndex(1);
--存档
local bg=LoadImage("data/sys/sys_sav_028.grp.png",RFZLUA.IMG_8888);
local btn=LoadImage("data/sys/sys_conf_032.grp.png",RFZLUA.IMG_8888);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local savedata_bg_normal=LoadImage("data/sys/sel_normal.png",RFZLUA.IMG_8888);
local savedata_bg_active=LoadImage("data/sys/sel_active.png",RFZLUA.IMG_8888);

quit=0;
btn_down=0;
local i=1;
btn_down=0;
btn_updata_fontbg=1;
--savedata_index=1;
btn_dy=22;
local savedata_btn_index=0;--当前选中按键的索引值

while quit==0 do

if btn_updata_fontbg==1 then--更新字体背景

  btn_updata_fontbg=0;
  ClearImage(font_bg);
  DrawText(font,savedata_index.."/"..RFZLUA.SAVEDATA_MAXDATA,font_bg,400,240,RFZLUA.FONT_NORMAL);
  savedata_btn_index=savedata_index%4;
  if savedata_btn_index==0 then
    savedata_btn_index=4;
  end

  local time_info={};
  if savedata_btn_index==1 then
  
    for i=1,4 do
      time_info[i]=RFZSysReadSavedata(savedata_index+(i-1));
      DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
    end

  elseif savedata_btn_index==2 then
  
    time_info[1]=RFZSysReadSavedata(savedata_index-1);
    time_info[2]=RFZSysReadSavedata(savedata_index);
    time_info[3]=RFZSysReadSavedata(savedata_index+1);
    time_info[4]=RFZSysReadSavedata(savedata_index+2);
    for i=1,4 do
      DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
    end

  elseif savedata_btn_index==3 then
  
    time_info[1]=RFZSysReadSavedata(savedata_index-2);
    time_info[2]=RFZSysReadSavedata(savedata_index-1);
    time_info[3]=RFZSysReadSavedata(savedata_index);
    time_info[4]=RFZSysReadSavedata(savedata_index+1);
    for i=1,4 do
      DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
    end

   elseif savedata_btn_index==4 then
   
     time_info[1]=RFZSysReadSavedata(savedata_index-3);
     time_info[2]=RFZSysReadSavedata(savedata_index-2);
     time_info[3]=RFZSysReadSavedata(savedata_index-1);
     time_info[4]=RFZSysReadSavedata(savedata_index);
     for i=1,4 do
      DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
     end

   end

end

BeginScene(1);
DrawImage(bg,0,0);
DrawImage(btn,465,btn_dy);
for i=1,4 do
  if savedata_btn_index==i then
    DrawImage(savedata_bg_active,20,(i-1)*58+22);
  else
    DrawImage(savedata_bg_normal,20,(i-1)*58+22);
  end
end

DrawImage(font_bg,0,0);
EndScene();

if btn_down==1 then--存档被按下
  btn_down=0;
  RFZSysDeleteSavedata(savedata_index);--删除存档
  RFZSysWriteSavedataEx(savedata_index);--写存档
  btn_updata_fontbg=1;
end

end

FreeImage(savedata_bg_normal);
FreeImage(savedata_bg_active);

FreeImage(bg);
FreeImage(btn);
FreeImage(font_bg);
FreeFont(font);

--存档
SetUserInputProcIndex(5);--返回gamemenu系统主菜单,将按键索引设回 5

end