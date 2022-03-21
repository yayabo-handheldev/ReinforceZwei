--�ı�����ģʽϵͳ
--����ϵͳ����:6

local quit=0;--�˳����
local btn_down=0;--�����Ƿ���
local text_counts=0;--�ı���
local text_index=0;--��ǰ�ı�����
local font_updata_bg=0;--�Ƿ�������屳��

function BtnDown6(key)

if     key==RFZLUA.BTN_UP     then
  
  if text_counts>0 then
    font_updata_bg=1;
    text_index=text_index-1;
    if text_index<1 then
      text_index=text_counts;
    end
  end
  
elseif key==RFZLUA.BTN_DOWN   then

  if text_counts>0 then
    font_updata_bg=1;
    text_index=text_index+1;
    if text_index>text_counts then
      text_index=1;
    end
  end
  
elseif key==RFZLUA.BTN_CIRCLE then

  btn_down=1;

elseif key==RFZLUA.BTN_CROSS  then

  quit=1;

end

end

function RFZGameMenuLogSystem()

SetUserInputProcIndex(6);--���LOGģʽ�İ���ϵͳ����

local voice=0;
local bg=LoadImage("data/sys/sys_log_001.grp.png",RFZLUA.IMG_8888);
local font=LoadFontTTF("data/font/default.ttf",13,RFZLUA.IMG_4444);
SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
local font_bg=CreateImage(480,272,RFZLUA.IMG_4444);
font_updata_bg=1;
quit=0;
btn_down=0;
text_counts=RFZSysLogGetLogTextCounts();
text_index=text_counts;

local text_page_counts=0;
local text_page_index=0;
if text_counts>0 then
  if (text_counts%3)==0 then
    text_page_counts=text_counts/3;
  else
    text_page_counts=1+(text_counts-(text_counts%3))/3;
  end
  text_page_index=text_page_counts;
end

local i=1;
local text_btn_index=0;
local text_voice_index=0;

while quit==0 do

if font_updata_bg==1 then

  font_updata_bg=0;
  ClearImage(font_bg);
  if text_counts>0 then
  
    text_voice_index=0;
    SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
    DrawText(font,text_index.."/"..text_counts,font_bg,400,240,RFZLUA.FONT_NORMAL);
    text_btn_index=text_index%3;
    if text_btn_index==0 then
      text_btn_index=3;
    end
    
    if text_counts<3 then
    
      local init_color=0;
      for i=1,text_counts do     
         
        if i==text_btn_index then
          --��Ҫ0_VOICE.RFZ�ļ�֧��
          --O_VOICE.RFZ�ļ�����ʹ��rfz_make_index_script���
          text_voice_index=RFZSysLogGetLogTextVoiceIndex(text_index);--��ȡ��Ƶ����
          if text_voice_index~=0 then
            SetFontColor(font,MAKE_RGBA_4444(255,102,0,255));
          else
            SetFontColor(font,MAKE_RGBA_4444(51,0,255,255));
          end
          
          init_color=1;
        else
          if init_color==1 then
            init_color=0;
            SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
          end
        end
        
		local text=RFZSysLogGetLogText(i);
		if text.text0~="" then
		  DrawText(font,text.text0,font_bg,30,20*0+35+(i-1)*80,RFZLUA.FONT_NORMAL);
		  if text.text1~="" then
			DrawText(font,text.text1,font_bg,30,20*1+35+(i-1)*80,RFZLUA.FONT_NORMAL);
			if text.text2~="" then
			  DrawText(font,text.text0,font_bg,30,20*2+35+(i-1)*80,RFZLUA.FONT_NORMAL);
			end
		  end
		end
		
      end
      
      
    else
    
      if text_index%3==0 then
        text_page_index=text_index/3;
      else
        text_page_index=1+(text_index-text_index%3)/3;
      end

	  local init_color=0;
	  local text_temp_index=(text_page_index-1)*3;
	  for i=1,(text_counts-text_temp_index) do     
		 
		if i==text_btn_index then
		  text_voice_index=RFZSysLogGetLogTextVoiceIndex(text_temp_index+i);--��ȡ��Ƶ����
		  if text_voice_index~=0 then
			SetFontColor(font,MAKE_RGBA_4444(255,102,0,255));
		  else
			SetFontColor(font,MAKE_RGBA_4444(51,0,255,255));
		  end
		  
		  init_color=1;
		else
		  if init_color==1 then
			init_color=0;
			SetFontColor(font,MAKE_RGBA_4444(255,255,255,255));
		  end
		end
		
		local text=RFZSysLogGetLogText(text_temp_index+i);
		if text.text0~="" then
		  DrawText(font,text.text0,font_bg,30,20*0+35+(i-1)*80,RFZLUA.FONT_NORMAL);
		  if text.text1~="" then
			DrawText(font,text.text1,font_bg,30,20*1+35+(i-1)*80,RFZLUA.FONT_NORMAL);
			if text.text2~="" then
			  DrawText(font,text.text0,font_bg,30,20*2+35+(i-1)*80,RFZLUA.FONT_NORMAL);
			end
		  end
		end
			
	  end
		  
    end
      
   
    
  else
    SetFontColor(font,MAKE_RGBA_4444(255,0,0,255));
    DrawText(font,"��ǰû�п��Ի�����ı�����!",font_bg,120,120,RFZLUA.FONT_NORMAL);
  end
  
end

BeginScene(1);
DrawImage(bg,0,0);
DrawImage(font_bg,0,0);
EndScene();

if btn_down==1 then
  btn_down=0;
  if text_voice_index>0 then--��ǰ�Ի�������Ƶ
    if voice~=0 then
      FreeSound(voice);
    end
    voice=RFZLoadSoundIndex(text_voice_index,"data/voice.rfz");
    if voice~=0 then
      SetSoundVol(voice,128);
      PlaySound(voice,1);
    end
  end
end

end

if voice~=0 then
  FreeSound(voice);
end
FreeImage(bg);
FreeImage(font_bg);
FreeFont(font);
SetUserInputProcIndex(5);--�����Ϸ�˵�ϵͳ�İ���ϵͳ����

end