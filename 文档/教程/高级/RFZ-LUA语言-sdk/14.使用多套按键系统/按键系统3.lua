local quit = 0;--�����˳����
SetUserInputProcIndex(3);--������ϵͳ����Ϊ��3�װ���ϵͳ

function BtnDown3(key)--����������Ϣ
quit=1;--�����°���ʱ�˳�ѭ��
end

function BtnUp3(key)--����������Ϣ
end

function MouseMove3(x,y)--����ƶ���Ϣ
end

function MouseBtn3(_type,x,y)--��갴����Ϣ
end

function Analog3(x,y)--ҡ����Ϣ
end

local img = LoadGif("test.gif",RFZLUA.IMG_8888);--����ͼƬ
while quit==0 do
BeginScene(1);--��ʼ��ͼ
DrawGif(img,0,0);--��ͼ
EndScene();--������ͼ
end
FreeGif(img);--�ͷ�img�ڴ�

SetUserInputProcIndex(0);--������ϵͳ����ΪĬ�ϰ���ϵͳ