local quit = 0;--�����˳����
SetUserInputProcIndex(1);--������ϵͳ����Ϊ��1�װ���ϵͳ

function BtnDown1(key)--����������Ϣ
quit=1;--����������ʱ�˳�ѭ��
end

function BtnUp1(key)--����������Ϣ
end

function MouseMove1(x,y)--����ƶ���Ϣ
end

function MouseBtn1(_type,x,y)--��갴����Ϣ
end

function Analog1(x,y)--ҡ����Ϣ
end

local img = LoadImage("0.jpg",RFZLUA.IMG_8888);--����ͼƬ
while quit==0 do
BeginScene(1);--��ʼ��ͼ
DrawImage(img,0,0);--��ͼ
EndScene();--������ͼ
end
FreeImage(img);--�ͷ�img�ڴ�

SetUserInputProcIndex(0);--������ϵͳ����ΪĬ�ϰ���ϵͳ