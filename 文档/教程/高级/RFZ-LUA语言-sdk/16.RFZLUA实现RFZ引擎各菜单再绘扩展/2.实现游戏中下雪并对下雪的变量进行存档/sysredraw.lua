print("testing...");

--主游戏画面再绘扩展接口函数-开始

--定义变量-开始
local game_main_timer=0;--计时器
local game_main_snow_last_timeticks=0;--下雪消逝时间
local game_main_snow_dx={};--下雪dx坐标数组
local game_main_snow_dy={};--下雪dy坐标数组
local game_main_snow=0;--雪花资源索引
local game_main_snow_counts=100;--雪花数
local game_main_index=0;--计数器

local game_main_snow_isopening=0;--是否开启了下雪特效

local game_main_seek=0;--开始下雪的脚本地址

--定义变量-结束
function BeginSnow()--开始下雪
game_main_snow_isopening=1;--下雪已开启
game_main_seek=RFZGetSeek();
RFZWriteValue(1,game_main_seek);--将当前脚本地址赋值给#value[1]并写入存档文件

--初始化雪-开始
game_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--创建一张16X16大小的图片,用于存放雪花.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--加载字体
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--设置字体颜色为白色
DrawText(pf,"*",game_main_snow,0,0,RFZLUA.FONT_NORMAL);--存放雪花"*"
FreeFont(pf);--释放字体

for game_main_index=1,game_main_snow_counts do --初始化dx,dy坐标
game_main_snow_dx[game_main_index]=4.8*(game_main_index-1);
game_main_snow_dy[game_main_index]=math.random(0,272);--利用随机数产生随机的dy坐标
end

game_main_timer=CreateTimer();--创建计时器
StartTimer(game_main_timer);--开始计时器
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--获取消逝时间

game_main_index=0;
--初始化雪-结束

end


function EndSnow()--结束下雪
game_main_snow_isopening=0;--下雪关闭
RFZWriteValue(1,0);--将#value[1]清零并写入存档文件

--释放资源
FreeTimer(game_main_timer);--释放计时器
FreeImage(game_main_snow);--释放雪花图片
--释放资源

end


function RFZMainReDraw_Init()  --初始化资源函数   -- 一般用于存档读取和资源初始化

game_main_seek=RFZGetValue(1);--从存档文件中获取#value[1]的值即 下雪开始的地址.
game_main_snow_isopening=0;

if  (game_main_seek~=0) and (game_main_seek<=RFZGetSeek()) then--说明用户存档时,下雪特效是开启的.
game_main_snow_isopening=1;
game_main_snow=CreateImage(16,16,RFZLUA.IMG_4444);--创建一张16X16大小的图片,用于存放雪花.

local pf = LoadFontTTF("simfang.ttf",16,RFZLUA.IMG_4444);--加载字体
SetFontColor(pf,MAKE_RGBA_4444(255,255,255,255));--设置字体颜色为白色
DrawText(pf,"*",game_main_snow,0,0,RFZLUA.FONT_NORMAL);--存放雪花"*"
FreeFont(pf);--释放字体

for game_main_index=1,game_main_snow_counts do --初始化dx,dy坐标
game_main_snow_dx[game_main_index]=4.8*(game_main_index-1);
game_main_snow_dy[game_main_index]=math.random(0,272);--利用随机数产生随机的dy坐标
end

game_main_timer=CreateTimer();--创建计时器
StartTimer(game_main_timer);--开始计时器
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--获取消逝时间

game_main_index=0;

end

end

function RFZMainReDraw_Draw()  --再绘函数         -- 主要实现内部特效

if game_main_snow_isopening==1 then--已开启下雪

if (GetTimerTick(game_main_timer)-game_main_snow_last_timeticks)>10 then
game_main_snow_last_timeticks=GetTimerTick(game_main_timer);--重置消逝时间

for game_main_index=1,game_main_snow_counts do--移动雪花
game_main_snow_dy[game_main_index]=game_main_snow_dy[game_main_index]+1;
if game_main_snow_dy[game_main_index] > 272 then
game_main_snow_dy[game_main_index]=math.random(0,272);
end
end

end

for game_main_index=1,game_main_snow_counts do--画雪
DrawImage(game_main_snow,
game_main_snow_dx[game_main_index],game_main_snow_dy[game_main_index]);
end

end


end

function RFZMainReDraw_Free()  --立即释放资源函数 -- 立即释放游戏的资源
end

function RFZMainReDraw_FreeEx()--最后释放资源函数 -- 最后释放游戏的资源

if game_main_snow_isopening==1 then--已开启下雪
--释放资源
FreeTimer(game_main_timer);--释放计时器
FreeImage(game_main_snow);--释放雪花图片
--释放资源
end

end

--主游戏画面再绘扩展接口函数-结束



