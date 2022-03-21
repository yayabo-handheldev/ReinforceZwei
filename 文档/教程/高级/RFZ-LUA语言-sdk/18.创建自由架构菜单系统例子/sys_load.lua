--读档系统
--按键系统索引:2

local quit=0;--退出标记
local btn_dy=22;
local btn_down=0;--按键是否被按下
local savedata_counts=0;--当前已经被存档的存档数
local btn_updata_fontbg=1;--是否更新字体背景
local load_index=1;--当前读档索引

function BtnDown2(key)

if key==RFZLUA.BTN_UP then

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--当前存在存档
    load_index=load_index-1;
      if load_index<1 then
        load_index=savedata_counts;
      end
    btn_dy=btn_dy-2;
    if btn_dy<22 or load_index==savedata_counts then
      btn_dy=222;
    end
    btn_updata_fontbg=1;
  end

elseif key==RFZLUA.BTN_DOWN then

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--当前存在存档
    load_index=load_index+1;
    if load_index>savedata_counts then
      load_index=1;
    end
    btn_dy=btn_dy+2;
    if btn_dy>=222 or load_index==1 then
      btn_dy=22;
    end
    btn_updata_fontbg=1;
end

elseif key==RFZLUA.BTN_CIRCLE then

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--当前存在存档
    btn_down=1;
  end

elseif key==RFZLUA.BTN_CROSS then

quit=1;

end

end


function RFZTitleLoadSystem()--标题菜单读档函数

SetUserInputProcIndex(2);--设成读档系统的按键系统索引

local bg=LoadImage("data/sys/sys_load_028.grp.png",RFZLUA.IMG_8888);
local btn=LoadImage("data/sys/sys_conf_032.grp.png",RFZLUA.IMG_8888);
local load_normal=LoadImage("data/sys/sel_normal.png",RFZLUA.IMG_8888);
local load_active=LoadImage("data/sys/sel_active.png",RFZLUA.IMG_8888);

quit=0;
btn_dy=22;
btn_down=0;
savedata_counts=0;
btn_updata_fontbg=1;

local savedata_index={};--当前已经被存档过的存档的所有索引值数组
--获取当前已经存档的存档数以及所有索引值-开始
local i=1;
for i=1,RFZLUA.SAVEDATA_MAXDATA do
  if RFZSysReadSavedata(i)~="" then--表明当前有存档
    savedata_counts=savedata_counts+1;--有效存档数+1
    savedata_index[savedata_counts]=i;--获取当前存档的索引值
  end
end
--获取当前已经存档的存档数以及所有索引值-结束
--print("存档数:"..savedata_counts);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local savedata_btn_index=0;--当前选中按键索引

local savedata_page_counts=0;--读档页面数
local savedata_page_index=0;--当前页面索引
--获取页面数-开始
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--有存档
  if (savedata_counts%4)==0 then
    savedata_page_counts=savedata_counts/4;
  else
    savedata_page_counts=1+(savedata_counts-savedata_counts%4)/4;
  end
  savedata_page_index=1;
end
--获取页面数--结束


while quit==0 do

if btn_updata_fontbg==1 then

  btn_updata_fontbg=0;
  ClearImage(font_bg);
  if savedata_counts==RFZLUA.SAVEDATA_NODATA then--当前没有存档
    DrawText(font,"你还没有存档过游戏!",font_bg,150,120,RFZLUA.FONT_NORMAL);
   else--当前有存档
     DrawText(font,load_index.."/"..savedata_counts,font_bg,400,240,RFZLUA.FONT_NORMAL);
     savedata_btn_index=load_index%4;
     if savedata_btn_index==0 then
       savedata_btn_index=4;
     end
     local time_info={};
     if savedata_counts<=4 then
       for i=1,savedata_counts do
         time_info[i]=RFZSysReadSavedata(savedata_index[i]);
         DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
       end
     else-- 存档数>4
     --获取当前页面索引--开始
       if (load_index%4)==0 then
         savedata_page_index=load_index/4;
       else
         savedata_page_index=1+(load_index-load_index%4)/4;
       end
     --获取当前页面索引--结束
       if savedata_page_index==savedata_page_counts then--当前为最后一页
         --print("当前为最后一页");
         for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):最后一个页面的存档数
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       else--不是最后一页
         --print("不是最后一页");
         for i=1,4 do
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       end
     end
   end

end


BeginScene(1);
DrawImage(bg,0,0);
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then

  DrawImage(btn,465,btn_dy);
    if savedata_counts<=4 then
      for i=1,savedata_counts do
        if i==savedata_btn_index then
          DrawImage(load_active,20,(i-1)*58+22);
        else
          DrawImage(load_normal,20,(i-1)*58+22);
        end
      end
    else-- 存档数>4
      if savedata_page_index==savedata_page_counts then--当前为最后一页
        for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):最后一个页面的存档数
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      else--不是最后一页
        for i=1,4 do
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      end
    end

end

DrawImage(font_bg,0,0);
EndScene();

if btn_down==1 then--读档按键被按下
  quit=1;--退出循环
end

end

FreeImage(bg);
FreeImage(btn);
FreeImage(load_normal);
FreeImage(load_active);
FreeImage(font_bg);
FreeFont(font);
SetUserInputProcIndex(0);--设回标题菜单系统的按键系统索引

--返回一个值告诉系统是否要读档
if btn_down==1 then--读档按键被按下
--发生了读档操作
--print(savedata_index[load_index]);
  return savedata_index[load_index];--返回需要读档,存档的索引值.
else
  return 0;--没有做读档操作
end

end




function RFZGameMenuLoadSystem()--游戏菜单读档函数

SetUserInputProcIndex(2);--设成读档系统的按键系统索引
local bg=LoadImage("data/sys/sys_load_028.grp.png",RFZLUA.IMG_8888);
local btn=LoadImage("data/sys/sys_conf_032.grp.png",RFZLUA.IMG_8888);
local load_normal=LoadImage("data/sys/sel_normal.png",RFZLUA.IMG_8888);
local load_active=LoadImage("data/sys/sel_active.png",RFZLUA.IMG_8888);

quit=0;
btn_dy=22;
btn_down=0;
savedata_counts=0;
btn_updata_fontbg=1;

local savedata_index={};--当前已经被存档过的存档的所有索引值数组
--获取当前已经存档的存档数以及所有索引值-开始
local i=1;
for i=1,RFZLUA.SAVEDATA_MAXDATA do
  if RFZSysReadSavedata(i)~="" then--表明当前有存档
    savedata_counts=savedata_counts+1;--有效存档数+1
    savedata_index[savedata_counts]=i;--获取当前存档的索引值
  end
end
--获取当前已经存档的存档数以及所有索引值-结束
--print("存档数:"..savedata_counts);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local savedata_btn_index=0;--当前选中按键索引

local savedata_page_counts=0;--读档页面数
local savedata_page_index=0;--当前页面索引
--获取页面数-开始
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--有存档
  if (savedata_counts%4)==0 then
    savedata_page_counts=savedata_counts/4;
  else
    savedata_page_counts=1+(savedata_counts-savedata_counts%4)/4;
  end
  savedata_page_index=1;
end
--获取页面数--结束


while quit==0 do

if btn_updata_fontbg==1 then

  btn_updata_fontbg=0;
  ClearImage(font_bg);
  if savedata_counts==RFZLUA.SAVEDATA_NODATA then--当前没有存档
    DrawText(font,"你还没有存档过游戏!",font_bg,150,120,RFZLUA.FONT_NORMAL);
   else--当前有存档
     DrawText(font,load_index.."/"..savedata_counts,font_bg,400,240,RFZLUA.FONT_NORMAL);
     savedata_btn_index=load_index%4;
     if savedata_btn_index==0 then
       savedata_btn_index=4;
     end
     local time_info={};
     if savedata_counts<=4 then
       for i=1,savedata_counts do
         time_info[i]=RFZSysReadSavedata(savedata_index[i]);
         DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
       end
     else-- 存档数>4
     --获取当前页面索引--开始
       if (load_index%4)==0 then
         savedata_page_index=load_index/4;
       else
         savedata_page_index=1+(load_index-load_index%4)/4;
       end
     --获取当前页面索引--结束
       if savedata_page_index==savedata_page_counts then--当前为最后一页
         --print("当前为最后一页");
         for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):最后一个页面的存档数
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       else--不是最后一页
         --print("不是最后一页");
         for i=1,4 do
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       end
     end
   end

end


BeginScene(1);
DrawImage(bg,0,0);
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then

  DrawImage(btn,465,btn_dy);
    if savedata_counts<=4 then
      for i=1,savedata_counts do
        if i==savedata_btn_index then
          DrawImage(load_active,20,(i-1)*58+22);
        else
          DrawImage(load_normal,20,(i-1)*58+22);
        end
      end
    else-- 存档数>4
      if savedata_page_index==savedata_page_counts then--当前为最后一页
        for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):最后一个页面的存档数
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      else--不是最后一页
        for i=1,4 do
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      end
    end

end

DrawImage(font_bg,0,0);
EndScene();

if btn_down==1 then--读档按键被按下
  quit=1;--退出循环
end

end

FreeImage(bg);
FreeImage(btn);
FreeImage(load_normal);
FreeImage(load_active);
FreeImage(font_bg);
FreeFont(font);
SetUserInputProcIndex(5);--设回游戏菜单系统的按键系统索引

--返回一个值告诉系统是否要读档
if btn_down==1 then--读档按键被按下
--发生了读档操作
--print(savedata_index[load_index]);
  return savedata_index[load_index];--返回需要读档,存档的索引值.
else
  return 0;--没有做读档操作
end

end


