local quit = 0;--设置退出标记
SetUserInputProcIndex(3);--将按键系统设置为第3套按键系统

function BtnDown3(key)--按键按下消息
quit=1;--当按下按键时退出循环
end

function BtnUp3(key)--按键弹起消息
end

function MouseMove3(x,y)--鼠标移动消息
end

function MouseBtn3(_type,x,y)--鼠标按键消息
end

function Analog3(x,y)--摇杆消息
end

local img = LoadGif("test.gif",RFZLUA.IMG_8888);--加载图片
while quit==0 do
BeginScene(1);--开始绘图
DrawGif(img,0,0);--画图
EndScene();--结束绘图
end
FreeGif(img);--释放img内存

SetUserInputProcIndex(0);--将按键系统设置为默认按键系统