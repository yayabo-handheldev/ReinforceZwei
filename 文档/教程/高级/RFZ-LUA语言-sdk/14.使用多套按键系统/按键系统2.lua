local quit = 0;--设置退出标记
SetUserInputProcIndex(2);--将按键系统设置为第2套按键系统

function BtnDown2(key)--按键按下消息
end

function BtnUp2(key)--按键弹起消息
end

function MouseMove2(x,y)--鼠标移动消息
end

function MouseBtn2(_type,x,y)--鼠标按键消息
quit=1;--当鼠标点击时退出循环
end

function Analog2(x,y)--摇杆消息
end

local img = LoadImage("1.jpg",RFZLUA.IMG_8888);--加载图片
while quit==0 do
BeginScene(1);--开始绘图
DrawImage(img,0,0);--画图
EndScene();--结束绘图
end
FreeImage(img);--释放img内存

SetUserInputProcIndex(0);--将按键系统设置为默认按键系统