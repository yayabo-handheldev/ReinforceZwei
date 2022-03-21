--标题菜单再绘-开始

--主界面-开始{

--定义变量-开始
local title_main_timer=0;--计时器
local title_main_snow_last_timeticks=0;--下雪消逝时间
local title_main_snow_dx={};--下雪dx坐标数组
local title_main_snow_dy={};--下雪dy坐标数组
local title_main_snow=0;--雪花资源索引
local title_main_snow_counts=100;--雪花数
local title_main_index=0;--计数器
--定义变量-结束

function RFZTitleReDraw_MainInit()--初始化资源函数

title_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--创建一张16X16大小的图片,用于存放雪花.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--加载字体
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--设置字体颜色为白色
DrawText(pf,"*",title_main_snow,0,0,RFZLUA.FONT_NORMAL);--存放雪花"*"
FreeFont(pf);--释放字体

for title_main_index=1,title_main_snow_counts do --初始化dx,dy坐标
title_main_snow_dx[title_main_index]=4.8*(title_main_index-1);
title_main_snow_dy[title_main_index]=math.random(0,272);--利用随机数产生随机的dy坐标
end

title_main_timer=CreateTimer();--创建计时器
StartTimer(title_main_timer);--开始计时器
title_main_snow_last_timeticks=GetTimerTick(title_main_timer);--获取消逝时间

title_main_index=0;

end

function RFZTitleReDraw_MainDraw()--再绘函数

if (GetTimerTick(title_main_timer)-title_main_snow_last_timeticks)>10 then
title_main_snow_last_timeticks=GetTimerTick(title_main_timer);--重置消逝时间

for title_main_index=1,title_main_snow_counts do--移动雪花
title_main_snow_dy[title_main_index]=title_main_snow_dy[title_main_index]+1;
if title_main_snow_dy[title_main_index] > 272 then
title_main_snow_dy[title_main_index]=math.random(0,272);
end
end

end

for title_main_index=1,title_main_snow_counts do--画雪
DrawImage(title_main_snow,
title_main_snow_dx[title_main_index],title_main_snow_dy[title_main_index]);
end

end

function RFZTitleReDraw_MainFree()--释放资源函数

FreeTimer(title_main_timer);--释放计时器
FreeImage(title_main_snow);--释放雪花图片

end
--主界面-结束}

