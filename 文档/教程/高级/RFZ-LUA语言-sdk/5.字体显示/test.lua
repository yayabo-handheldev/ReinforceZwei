local img = RFZLoadImage("0.jpg",RFZLUA.IMG_8888,"bg.rfz");--����ͼƬ
local snd = RFZLoadSound("loli.mp3","voice.rfz");--������ʽ������Ƶ
--local snd = RFZLoadSoundIndex(1,"voice.rfz");--������ʽ������Ƶ
SetSoundVol(snd,128);--��������
PlaySound(snd,1);--����1��
local text_bg = CreateImage(480,272,RFZLUA.IMG_8888);--������������ı���
local font = LoadFontTTF("simfang.ttf",13,RFZLUA.IMG_8888);--����ttf����
DrawText(font,"����Ǹ�����!",text_bg,240,100,RFZLUA.FONT_NORMAL);
while 1 do
BeginScene(1);--��ʼ��ͼ
DrawImage(img,0,0);--��ͼ
DrawImage(text_bg,0,0);--�����屳��ͼ
EndScene();--������ͼ
end
FreeImage(img);--�ͷ�img�ڴ�
FreeImage(text_bg);--�ͷ�text_bg�ڴ�
FreeSound(snd);--�ͷ���Ƶ
FreeFont(font);--�ͷ�����