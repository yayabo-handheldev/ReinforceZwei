--标题菜单再绘-开始

--主界面-开始{
function RFZTitleReDraw_MainInit()--初始化资源函数
end

function RFZTitleReDraw_MainDraw()--再绘函数
end

function RFZTitleReDraw_MainFree()--释放资源函数
end
--主界面-结束}

--读档菜单-开始
function RFZTitleReDraw_LoadInit()--初始化资源函数
end

function RFZTitleReDraw_LoadDraw()--再绘函数
end

function RFZTitleReDraw_LoadFree()--释放资源函数
end
--读档菜单-结束

--CG模式菜单-开始
function RFZTitleReDraw_CGInit()--初始化资源函数
end

function RFZTitleReDraw_CGDraw()--再绘函数
end

function RFZTitleReDraw_CGFree()--释放资源函数
end
--CG模式菜单-结束

--CG回想模式菜单-开始
function RFZTitleReDraw_CGMemoryInit()--初始化资源函数
end

function RFZTitleReDraw_CGMemoryDraw()--再绘函数
end

function RFZTitleReDraw_CGMemoryFree()--释放资源函数
end
--CG回想模式菜单-结束

--标题菜单再绘-结束




--游戏菜单再绘-开始

--主界面-开始
function RFZGameMenuReDraw_MainInit()--初始化资源函数
end

function RFZGameMenuReDraw_MainDraw()--再绘函数
end

function RFZGameMenuReDraw_MainFree()--释放资源函数
end
--主界面-结束

--存档菜单-开始
function RFZGameMenuReDraw_SaveInit()--初始化资源函数
end

function RFZGameMenuReDraw_SaveDraw()--再绘函数
end

function RFZGameMenuReDraw_SaveFree()--释放资源函数
end
--存档菜单-结束

--读档菜单-开始
function RFZGameMenuReDraw_LoadInit()--初始化资源函数
end

function RFZGameMenuReDraw_LoadDraw()--再绘函数
end

function RFZGameMenuReDraw_LoadFree()--释放资源函数
end
--读档菜单-结束

--文本回想菜单-开始
function RFZGameMenuReDraw_RecollectionInit()--初始化资源函数
end

function RFZGameMenuReDraw_RecollectionDraw()--再绘函数
end

function RFZGameMenuReDraw_RecollectionFree()--释放资源函数
end
--文本回想菜单-结束

--游戏菜单再绘-结束

--主游戏画面再绘扩展接口函数-开始

function RFZMainReDraw_Init()  --初始化资源函数   -- 一般用于存档读取和资源初始化
end

function RFZMainReDraw_Draw()  --再绘函数         -- 主要实现内部特效
end

function RFZMainReDraw_Free()  --立即释放资源函数 -- 立即释放游戏的资源
end

function RFZMainReDraw_FreeEx()--最后释放资源函数 -- 最后释放游戏的资源
end

--主游戏画面再绘扩展接口函数-结束



