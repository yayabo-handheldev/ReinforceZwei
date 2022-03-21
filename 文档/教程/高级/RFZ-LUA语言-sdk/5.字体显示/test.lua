local img = RFZLoadImage("0.jpg",RFZLUA.IMG_8888,"bg.rfz");--加载图片
local snd = RFZLoadSound("loli.mp3","voice.rfz");--遍历方式加载音频
--local snd = RFZLoadSoundIndex(1,"voice.rfz");--索引方式加载音频
SetSoundVol(snd,128);--设置音量
PlaySound(snd,1);--播放1次
local text_bg = CreateImage(480,272,RFZLUA.IMG_8888);--创建个画字体的背景
local font = LoadFontTTF("simfang.ttf",13,RFZLUA.IMG_8888);--加载ttf字体
DrawText(font,"哥哥是个笨蛋!",text_bg,240,100,RFZLUA.FONT_NORMAL);
while 1 do
BeginScene(1);--开始绘图
DrawImage(img,0,0);--画图
DrawImage(text_bg,0,0);--画字体背景图
EndScene();--结束绘图
end
FreeImage(img);--释放img内存
FreeImage(text_bg);--释放text_bg内存
FreeSound(snd);--释放音频
FreeFont(font);--释放字体