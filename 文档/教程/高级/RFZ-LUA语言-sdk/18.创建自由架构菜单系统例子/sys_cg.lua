--cgģʽϵͳ
--����ϵͳ����:3


local quit=0;--�˳����
local cg_counts=0;--��CG��
local cg_index=1;--��ǰCG����
local cg_btn_down=0;--�Ƿ���Ԥ��CG����
local cg_page_index=0;--��ǰҳ��
local cg_page_counts=0;--��ҳ��
local btn_updata_fontbg=1;--�Ƿ�������屳��
local cg_updata=1;--�Ƿ����CG����ͼ

function BtnDown3(key)

if key==RFZLUA.BTN_UP then

  if cg_counts>RFZLUA.CG_NODATA then
    if cg_btn_down==0 then--��ǰû��Ԥ��CG
      btn_updata_fontbg=1;
      cg_index=cg_index-3;
        if cg_page_index==cg_page_counts then
        --��ǰ�����һҳ
          if cg_index<((cg_page_index-1)*9+1) then
            cg_index=cg_index+9;
              if cg_index>cg_counts then
                cg_index=cg_index-6;
              end
          end
         else
         --�������һҳ
           if cg_index<((cg_page_index-1)*9+1) then
             cg_index=cg_index+9;
           end
         end
     end
  end

elseif key==RFZLUA.BTN_DOWN then

  if cg_counts>RFZLUA.CG_NODATA then
    if cg_btn_down==0 then--��ǰû��Ԥ��CG
      btn_updata_fontbg=1;
      cg_index=cg_index+3;
      if cg_page_index==cg_page_counts then
      --��ǰ�����һҳ
        if cg_index>cg_counts then
          cg_index=cg_index-(cg_counts-(cg_page_index-1)*9);
        end
      else
      --�������һҳ
        if cg_index>(cg_page_index*9) then
          cg_index=cg_index-9;
        end
      end
     end
  end

elseif key==RFZLUA.BTN_LEFT then

  if cg_counts>RFZLUA.CG_NODATA then
    btn_updata_fontbg=1;
    cg_index=cg_index-1;
      if cg_page_index==cg_page_counts then
      --��ǰ�����һҳ
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_counts-(cg_page_index-1)*9;
        end
      else
      --�������һҳ
        if cg_index<((cg_page_index-1)*9+1) then
          cg_index=cg_page_index*9;
        end
      end
  end

elseif key==RFZLUA.BTN_RIGHT then

  if cg_counts>RFZLUA.CG_NODATA then
    btn_updata_fontbg=1;
    cg_index=cg_index+1;
      if cg_page_index==cg_page_counts then
      --��ǰ�����һҳ
        if cg_index>cg_counts then
          cg_index=(cg_page_index-1)*9+1;
        end
      else
      --�������һҳ
        if cg_index>cg_page_index*9 then
          cg_index=(cg_page_index-1)*9+1;
        end
      end
  end

elseif key==RFZLUA.BTN_LT then

  if cg_counts>RFZLUA.CG_NODATA then
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

  if cg_counts>RFZLUA.CG_NODATA then
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


function RFZTitleCGMode()--����˵�CGģʽ

SetUserInputProcIndex(3);--���CGģʽ�İ���ϵͳ����

local bg=LoadImage("data/sys/cg.png",RFZLUA.IMG_8888);
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local cg_pack=RFZSysGetCGPack();--��ȡ��ǰϵͳ��CG����,"#initcgpack(data\cg.rfz)"
local cg_child_pack=RFZSysGetChildCGPack();--��ȡ��ǰϵͳ����CG����,"#initchildcgpack(data\childcg.rfz)"
local cg_fbg=CreateImageEx(122,69,MAKE_RGBA_4444(255,204,255,100),RFZLUA.IMG_4444);

local i=1;
quit=0;
cg_counts=0;
--cg_index=1;
local hot_cg_index={};
--��ȡ��ЧCG��/��ЧCG����--��ʼ
local hcg=0;
for i=1,13  do
--����ʵ�ʵ�CG������ѭ���Ĵ���
--����ֱ�������CG��RFZLUA.CG_MAXDATA����Ϊѭ�����ֵ
--����ѭ��13����ΪCG����CG����ֻ��13��
  hcg=RFZSysReadCG(i);
  if hcg~=RFZLUA.CG_NODATA then
    cg_counts=cg_counts+1;--��ЧCG��+1
    hot_cg_index[cg_counts]=hcg;--��ȡ��ЧCG��CG���е�λ������
  end

end
--��ȡ��ЧCG��/��ЧCG����--����

--[[
--����--��ʼ
cg_counts=13;
cg_index=1;
for i=1,cg_counts do
hot_cg_index[i]=i;
end
--����--����
--]]

if cg_counts>RFZLUA.CG_NODATA then
--��ȡCG��ҳ��--��ʼ
  if cg_counts%9==0 then
    cg_page_counts=cg_counts/9;
  else
    cg_page_counts=1+((cg_counts-cg_counts%9)/9);
  end
--��ȡCG��ҳ��--����
--��ȡ��ǰCGҳ��--��ʼ
  if cg_index%9==0 then
    cg_page_index=cg_index/9;
  else
    cg_page_index=1+((cg_index-cg_index%9)/9);
  end
--��ȡ��ǰCGҳ��--����
end

cg_btn_down=0;
btn_updata_fontbg=1;
cg_updata=1;
local cg_btn_index=0;--��ǰѡ�е�CG����[1-9]
local cg_tumb={};--����ͼ
local cg_tumb_counts=0;--��ǰ������CG����ͼ����ʾ


while quit==0 do

if  btn_updata_fontbg==1 then

  cg_btn_index=cg_index%9;
  if cg_btn_index==0 then
    cg_btn_index=9;
  end
  btn_updata_fontbg=0;
  ClearImage(font_bg);
  
  if cg_counts>RFZLUA.CG_NODATA then--��ǰ��CG
    
    DrawText(font,"LT:ǰҳ",font_bg,420,30,RFZLUA.FONT_NORMAL);
    DrawText(font,"RT:��ҳ",font_bg,420,50,RFZLUA.FONT_NORMAL);
    --��ȡ��ǰCGҳ��--��ʼ
    if cg_index%9==0 then
      cg_page_index=cg_index/9;
    else
      cg_page_index=1+((cg_index-cg_index%9)/9);
    end
    --��ȡ��ǰCGҳ��--����
    DrawText(font,cg_page_index.."/"..cg_page_counts,font_bg,420,250,RFZLUA.FONT_NORMAL);
    if cg_updata==1 then--��Ҫ����CG����ͼ
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
       --��ǰ�����һҳ
         cg_tumb_counts=cg_counts-(cg_page_index-1)*9;
         for i=1,cg_tumb_counts do
           cg_tumb[i]=RFZLoadImageIndex(hot_cg_index[(cg_page_index-1)*9+i],RFZLUA.IMG_8888,cg_child_pack);
         end
       else
       --�������һҳ
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

if cg_counts>RFZLUA.CG_NODATA then--��ǰ����CG

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

if cg_btn_down==1 then--CGԤ������������

  if cg_counts>RFZLUA.CG_NODATA then   
    local cg_view=RFZLoadImageIndex(hot_cg_index[cg_index],RFZLUA.IMG_8888,cg_pack);
    while quit==0 do
      if btn_updata_fontbg==1 then
        btn_updata_fontbg=0;
        FreeImage(cg_view);
        cg_view=RFZLoadImageIndex(hot_cg_index[cg_index],RFZLUA.IMG_8888,cg_pack);
      end
      BeginScene(1);
      DrawImage(cg_view,0,0);
      EndScene();
    end
    FreeImage(cg_view);
    quit=0;
    btn_updata_fontbg=1;
    cg_btn_down=0;
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

SetUserInputProcIndex(0);--��ر���˵�ϵͳ�İ���ϵͳ����

end
