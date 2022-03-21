--cg回想模式系统
--按键系统索引:4




local quit=0;--退出标记
local cg_counts=0;--总CG数
local cg_index=1;--当前CG索引
local cg_btn_down=0;--是否按下预览CG回想按键
local cg_page_index=0;--当前页数
local cg_page_counts=0;--总页数
local btn_updata_fontbg=1;--是否更新字体背景
local cg_updata=1;--是否更新CG缩略图

function BtnDown4(key)

if key==RFZLUA.BTN_UP then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    if cg_btn_down==0 then--当前没有预览CG
      btn_updata_fontbg=1;
      cg_index=cg_index-3;
      if cg_page_index==cg_page_counts then
      --当前是最后一页
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_index+9;
          if cg_index>cg_counts then
            cg_index=cg_index-6;
          end

        end

      else
      --不是最后一页
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_index+9;
        end
      end
    end
  end

elseif key==RFZLUA.BTN_DOWN then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    if cg_btn_down==0 then--当前没有预览CG
      btn_updata_fontbg=1;
      cg_index=cg_index+3;
      if cg_page_index==cg_page_counts then
      --当前是最后一页
        if cg_index>cg_counts then
          cg_index=cg_index-(cg_counts-(cg_page_index-1)*9);
        end
      else
      --不是最后一页
        if cg_index>(cg_page_index*9) then
          cg_index=cg_index-9;
        end
      end
    end
  end

elseif key==RFZLUA.BTN_LEFT then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    btn_updata_fontbg=1;
    cg_index=cg_index-1;
      if cg_page_index==cg_page_counts then
      --当前是最后一页
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_counts-(cg_page_index-1)*9;
        end
      else
      --不是最后一页
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_page_index*9;
        end
      end
  end

elseif key==RFZLUA.BTN_RIGHT then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    btn_updata_fontbg=1;
    cg_index=cg_index+1;
      if cg_page_index==cg_page_counts then
      --当前是最后一页
        if cg_index>cg_counts then
          cg_index=(cg_page_index-1)*9+1;
        end
      else
      --不是最后一页
        if cg_index>cg_page_index*9 then
          cg_index=(cg_page_index-1)*9+1;
        end
      end
  end

elseif key==RFZLUA.BTN_LT then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    btn_updata_fontbg=1;
    cg_page_index=cg_page_index-1;
    if cg_page_index<1 then
      cg_page_index=cg_page_counts;
    end
    cg_index=(cg_page_index-1)*9+1;
    if cg_counts>9 then
      cg_updata=1;
    end
  end

elseif key==RFZLUA.BTN_RT then

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    btn_updata_fontbg=1;
    cg_page_index=cg_page_index+1;
    if cg_page_index>cg_page_counts then
      cg_page_index=1;
    end
    cg_index=(cg_page_index-1)*9+1;
    if cg_counts>9 then
      cg_updata=1;
    end
  end

elseif key==RFZLUA.BTN_CIRCLE then

cg_btn_down=1;

elseif key==RFZLUA.BTN_CROSS then

quit=1;

end

end


function RFZTitleCGMemoryMode()--标题菜单CG回想模式

SetUserInputProcIndex(4);--设成CG回想模式的按键系统索引

local bg=LoadImage("data/sys/cgmemory.png",RFZLUA.IMG_8888);
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,0,255,255));

local cg_child_pack=RFZSysGetChildCGMemoryPack();--获取当前系统的子CG回想包名,"#initchildcgmemorypack(data\childcgmemory.rfz)"
local cg_fbg=CreateImageEx(122,69,MAKE_RGBA_4444(255,204,255,100),RFZLUA.IMG_4444);

local i=1;
quit=0;
cg_counts=0;
--cg_index=1;
local hot_cg_index={};
local hot_cgmemory_index={};
--获取有效CG回想数/有效CG回想索引--开始
local hcg=0;
for i=1,RFZLUA.CGMEMORY_MAXDATA  do
--根据实际的CG回想数设置循环的次数
--这里用默认的RFZLUA.CGMEMORY_MAXDATA
  hcg=RFZSysReadCGMemory(i);
  if hcg~=RFZLUA.CGMEMORY_NODATA then
    cg_counts=cg_counts+1;--有效CG回想数+1
    hot_cg_index[cg_counts]=hcg;--获取有效CG回想的CG缩略图在CG回想子包中的位置索引
    hot_cgmemory_index[cg_counts]=i;--获取CG回想在存档中的索引位置
  end
end
--获取有效CG回想数/有效CG回想索引--结束

--[[
--测试--开始
cg_counts=13;
cg_index=1;
for i=1,cg_counts do
hot_cg_index[i]=i;
end
--测试--结束
--]]

if cg_counts>RFZLUA.CGMEMORY_NODATA then
--获取CG总页数--开始
  if cg_counts%9==0 then
    cg_page_counts=cg_counts/9;
  else
    cg_page_counts=1+((cg_counts-cg_counts%9)/9);
  end
--获取CG总页数--结束
--获取当前CG页数--开始
  if cg_index%9==0 then
    cg_page_index=cg_index/9;
  else
    cg_page_index=1+((cg_index-cg_index%9)/9);
  end
--获取当前CG页数--结束
end

cg_btn_down=0;
btn_updata_fontbg=1;
cg_updata=1;
local cg_btn_index=0;--当前选中的CG索引[1-9]
local cg_tumb={};--缩略图
local cg_tumb_counts=0;--当前多少张CG缩略图被显示


while quit==0 do

  if  btn_updata_fontbg==1 then

    cg_btn_index=cg_index%9;
    if cg_btn_index==0 then
      cg_btn_index=9;
    end

    btn_updata_fontbg=0;
    ClearImage(font_bg);

    if cg_counts>RFZLUA.CGMEMORY_NODATA then--当前有CG
      DrawText(font,"LT:前页",font_bg,420,30,RFZLUA.FONT_NORMAL);
      DrawText(font,"RT:后页",font_bg,420,50,RFZLUA.FONT_NORMAL);
      --获取当前CG页数--开始
      if cg_index%9==0 then
        cg_page_index=cg_index/9;
      else
        cg_page_index=1+((cg_index-cg_index%9)/9);
      end
      --获取当前CG页数--结束
      DrawText(font,cg_page_index.."/"..cg_page_counts,font_bg,420,250,RFZLUA.FONT_NORMAL);
      if cg_updata==1 then--需要更新CG缩略图
        cg_updata=0;
        if cg_tumb_counts>0 then
          for i=1,cg_tumb_counts do
            FreeImage(cg_tumb[i]);
          end
        end
        if cg_counts<9 then
          cg_tumb_counts=cg_counts;
          for i=1,cg_tumb_counts do
            cg_tumb[i]=RFZLoadImageIndex(hot_cg_index[i],RFZLUA.IMG_8888,cg_child_pack);
          end
        else
         if cg_page_index==cg_page_counts then
         --当前是最后一页
           cg_tumb_counts=cg_counts-(cg_page_index-1)*9;
             for i=1,cg_tumb_counts do
               cg_tumb[i]=RFZLoadImageIndex(hot_cg_index[(cg_page_index-1)*9+i],RFZLUA.IMG_8888,cg_child_pack);
             end
         else
         --不是最后一页
           cg_tumb_counts=9;
           for i=1,cg_tumb_counts do
             cg_tumb[i]=RFZLoadImageIndex(hot_cg_index[(cg_page_index-1)*9+i],RFZLUA.IMG_8888,cg_child_pack);
           end
         end
        end
      end
    end
  end

BeginScene(1);
DrawImage(bg,0,0);
DrawImage(font_bg,0,0);

if cg_counts>RFZLUA.CGMEMORY_NODATA then--当前存在CG

  for i=1,cg_tumb_counts do
    if     i<4  then
      DrawImage(cg_tumb[i],(i-1)*125+15,72*0+45);
    elseif i<7  then
      DrawImage(cg_tumb[i],(i-4)*125+15,72*1+45);
    elseif i<10 then
      DrawImage(cg_tumb[i],(i-7)*125+15,72*2+45);
    end

  end

  if     cg_btn_index<4 then
    DrawImage(cg_fbg,(cg_btn_index-1)*125+15,72*0+45);
  elseif cg_btn_index<7  then
    DrawImage(cg_fbg,(cg_btn_index-4)*125+15,72*1+45);
  elseif cg_btn_index<10 then
    DrawImage(cg_fbg,(cg_btn_index-7)*125+15,72*2+45);
  end

end

EndScene();

if cg_btn_down==1 then--CG回想预览按键被按下

  if cg_counts>RFZLUA.CGMEMORY_NODATA then
    cg_btn_down=0;
    --释放资源-开始
    --释放缩略图
    if cg_tumb_counts>0 then
      for i=1,cg_tumb_counts do
        FreeImage(cg_tumb[i]);
      end
    end
    --释放其余所有资源
    FreeImage(bg);
    FreeImage(font_bg);
    FreeFont(font);
    FreeImage(cg_fbg);
    --释放资源-开始
    --开始加载CG回想
    FiniUserInputProc();--必须先销毁当前的按键系统
    RFZSysLoadCGMemory(hot_cgmemory_index[cg_index]);
    --设置回当前的按键系统
    InitUserInputProc();
    SetUserInputProcIndex(4);
    --
    --重新加载资源-返回CG回想模式-开始
    --加载缩略图
    btn_updata_fontbg=1;
    cg_updata=1;
    cg_tumb_counts=0;
    --加载其他资源
    bg=LoadImage("data/sys/cgmemory.png",RFZLUA.IMG_8888);
    font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
    font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
    SetFontColor(font,MAKE_RGBA_4444(255,0,255,255));
    cg_fbg=CreateImageEx(122,69,MAKE_RGBA_4444(255,204,255,100),RFZLUA.IMG_4444);
    --重新加载资源-返回CG回想模式-结束
  end
  
end

end

FreeImage(bg);
FreeImage(font_bg);
FreeFont(font);
FreeImage(cg_fbg);

if cg_tumb_counts>0 then
  for i=1,cg_tumb_counts do
    FreeImage(cg_tumb[i]);
  end
end

SetUserInputProcIndex(0);--设回标题菜单系统的按键系统索引

end


