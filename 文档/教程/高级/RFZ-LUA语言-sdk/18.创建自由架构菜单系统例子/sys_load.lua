--����ϵͳ
--����ϵͳ����:2

local quit=0;--�˳����
local btn_dy=22;
local btn_down=0;--�����Ƿ񱻰���
local savedata_counts=0;--��ǰ�Ѿ����浵�Ĵ浵��
local btn_updata_fontbg=1;--�Ƿ�������屳��
local load_index=1;--��ǰ��������

function BtnDown2(key)

if key==RFZLUA.BTN_UP then

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--��ǰ���ڴ浵
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

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--��ǰ���ڴ浵
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

  if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--��ǰ���ڴ浵
    btn_down=1;
  end

elseif key==RFZLUA.BTN_CROSS then

quit=1;

end

end


function RFZTitleLoadSystem()--����˵���������

SetUserInputProcIndex(2);--��ɶ���ϵͳ�İ���ϵͳ����

local bg=LoadImage("data/sys/sys_load_028.grp.png",RFZLUA.IMG_8888);
local btn=LoadImage("data/sys/sys_conf_032.grp.png",RFZLUA.IMG_8888);
local load_normal=LoadImage("data/sys/sel_normal.png",RFZLUA.IMG_8888);
local load_active=LoadImage("data/sys/sel_active.png",RFZLUA.IMG_8888);

quit=0;
btn_dy=22;
btn_down=0;
savedata_counts=0;
btn_updata_fontbg=1;

local savedata_index={};--��ǰ�Ѿ����浵���Ĵ浵����������ֵ����
--��ȡ��ǰ�Ѿ��浵�Ĵ浵���Լ���������ֵ-��ʼ
local i=1;
for i=1,RFZLUA.SAVEDATA_MAXDATA do
  if RFZSysReadSavedata(i)~="" then--������ǰ�д浵
    savedata_counts=savedata_counts+1;--��Ч�浵��+1
    savedata_index[savedata_counts]=i;--��ȡ��ǰ�浵������ֵ
  end
end
--��ȡ��ǰ�Ѿ��浵�Ĵ浵���Լ���������ֵ-����
--print("�浵��:"..savedata_counts);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local savedata_btn_index=0;--��ǰѡ�а�������

local savedata_page_counts=0;--����ҳ����
local savedata_page_index=0;--��ǰҳ������
--��ȡҳ����-��ʼ
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--�д浵
  if (savedata_counts%4)==0 then
    savedata_page_counts=savedata_counts/4;
  else
    savedata_page_counts=1+(savedata_counts-savedata_counts%4)/4;
  end
  savedata_page_index=1;
end
--��ȡҳ����--����


while quit==0 do

if btn_updata_fontbg==1 then

  btn_updata_fontbg=0;
  ClearImage(font_bg);
  if savedata_counts==RFZLUA.SAVEDATA_NODATA then--��ǰû�д浵
    DrawText(font,"�㻹û�д浵����Ϸ!",font_bg,150,120,RFZLUA.FONT_NORMAL);
   else--��ǰ�д浵
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
     else-- �浵��>4
     --��ȡ��ǰҳ������--��ʼ
       if (load_index%4)==0 then
         savedata_page_index=load_index/4;
       else
         savedata_page_index=1+(load_index-load_index%4)/4;
       end
     --��ȡ��ǰҳ������--����
       if savedata_page_index==savedata_page_counts then--��ǰΪ���һҳ
         --print("��ǰΪ���һҳ");
         for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):���һ��ҳ��Ĵ浵��
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       else--�������һҳ
         --print("�������һҳ");
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
    else-- �浵��>4
      if savedata_page_index==savedata_page_counts then--��ǰΪ���һҳ
        for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):���һ��ҳ��Ĵ浵��
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      else--�������һҳ
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

if btn_down==1 then--��������������
  quit=1;--�˳�ѭ��
end

end

FreeImage(bg);
FreeImage(btn);
FreeImage(load_normal);
FreeImage(load_active);
FreeImage(font_bg);
FreeFont(font);
SetUserInputProcIndex(0);--��ر���˵�ϵͳ�İ���ϵͳ����

--����һ��ֵ����ϵͳ�Ƿ�Ҫ����
if btn_down==1 then--��������������
--�����˶�������
--print(savedata_index[load_index]);
  return savedata_index[load_index];--������Ҫ����,�浵������ֵ.
else
  return 0;--û������������
end

end




function RFZGameMenuLoadSystem()--��Ϸ�˵���������

SetUserInputProcIndex(2);--��ɶ���ϵͳ�İ���ϵͳ����
local bg=LoadImage("data/sys/sys_load_028.grp.png",RFZLUA.IMG_8888);
local btn=LoadImage("data/sys/sys_conf_032.grp.png",RFZLUA.IMG_8888);
local load_normal=LoadImage("data/sys/sel_normal.png",RFZLUA.IMG_8888);
local load_active=LoadImage("data/sys/sel_active.png",RFZLUA.IMG_8888);

quit=0;
btn_dy=22;
btn_down=0;
savedata_counts=0;
btn_updata_fontbg=1;

local savedata_index={};--��ǰ�Ѿ����浵���Ĵ浵����������ֵ����
--��ȡ��ǰ�Ѿ��浵�Ĵ浵���Լ���������ֵ-��ʼ
local i=1;
for i=1,RFZLUA.SAVEDATA_MAXDATA do
  if RFZSysReadSavedata(i)~="" then--������ǰ�д浵
    savedata_counts=savedata_counts+1;--��Ч�浵��+1
    savedata_index[savedata_counts]=i;--��ȡ��ǰ�浵������ֵ
  end
end
--��ȡ��ǰ�Ѿ��浵�Ĵ浵���Լ���������ֵ-����
--print("�浵��:"..savedata_counts);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
local savedata_btn_index=0;--��ǰѡ�а�������

local savedata_page_counts=0;--����ҳ����
local savedata_page_index=0;--��ǰҳ������
--��ȡҳ����-��ʼ
if savedata_counts~=RFZLUA.SAVEDATA_NODATA then--�д浵
  if (savedata_counts%4)==0 then
    savedata_page_counts=savedata_counts/4;
  else
    savedata_page_counts=1+(savedata_counts-savedata_counts%4)/4;
  end
  savedata_page_index=1;
end
--��ȡҳ����--����


while quit==0 do

if btn_updata_fontbg==1 then

  btn_updata_fontbg=0;
  ClearImage(font_bg);
  if savedata_counts==RFZLUA.SAVEDATA_NODATA then--��ǰû�д浵
    DrawText(font,"�㻹û�д浵����Ϸ!",font_bg,150,120,RFZLUA.FONT_NORMAL);
   else--��ǰ�д浵
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
     else-- �浵��>4
     --��ȡ��ǰҳ������--��ʼ
       if (load_index%4)==0 then
         savedata_page_index=load_index/4;
       else
         savedata_page_index=1+(load_index-load_index%4)/4;
       end
     --��ȡ��ǰҳ������--����
       if savedata_page_index==savedata_page_counts then--��ǰΪ���һҳ
         --print("��ǰΪ���һҳ");
         for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):���һ��ҳ��Ĵ浵��
           time_info[i]=RFZSysReadSavedata(savedata_index[(savedata_page_index-1)*4+i]);
           DrawText(font,time_info[i],font_bg,130,(i-1)*58+22+12,RFZLUA.FONT_NORMAL);
         end
       else--�������һҳ
         --print("�������һҳ");
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
    else-- �浵��>4
      if savedata_page_index==savedata_page_counts then--��ǰΪ���һҳ
        for i=1,(savedata_counts-((savedata_page_index-1)*4)) do--(savedata_counts-((savedata_page_index-1)*4)):���һ��ҳ��Ĵ浵��
          if i==savedata_btn_index then
            DrawImage(load_active,20,(i-1)*58+22);
          else
            DrawImage(load_normal,20,(i-1)*58+22);
          end
        end
      else--�������һҳ
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

if btn_down==1 then--��������������
  quit=1;--�˳�ѭ��
end

end

FreeImage(bg);
FreeImage(btn);
FreeImage(load_normal);
FreeImage(load_active);
FreeImage(font_bg);
FreeFont(font);
SetUserInputProcIndex(5);--�����Ϸ�˵�ϵͳ�İ���ϵͳ����

--����һ��ֵ����ϵͳ�Ƿ�Ҫ����
if btn_down==1 then--��������������
--�����˶�������
--print(savedata_index[load_index]);
  return savedata_index[load_index];--������Ҫ����,�浵������ֵ.
else
  return 0;--û������������
end

end


