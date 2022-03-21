
local quit = 0;

function BtnDown(key)
if key== RFZLUA.BTN_CIRCLE then--当按下O键时退出
quit=1;
end
end
--注:次模式下 SetUserInputProcIndex 函数为无效函数
function RFZExtendMode()
InitUserInputProc();--初始化用户按键系统--SetUserInputProcIndex(1);设置用户按键系统索引local gif = LoadGif("test.gif",RFZLUA.IMG_8888);--加载图片while quit==0 doBeginScene(1);--开始绘图DrawGif(gif,0,0);--画图EndScene();--结束绘图endFreeGif(gif);--释放gif内存FiniUserInputProc();--释放用户按键
end