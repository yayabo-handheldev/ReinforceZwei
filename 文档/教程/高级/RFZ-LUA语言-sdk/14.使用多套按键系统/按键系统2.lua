local quit = 0;--�����˳����
SetUserInputProcIndex(2);--������ϵͳ����Ϊ��2�װ���ϵͳ

function BtnDown2(key)--����������Ϣ
end

function BtnUp2(key)--����������Ϣ
end

function MouseMove2(x,y)--����ƶ���Ϣ
end

function MouseBtn2(_type,x,y)--��갴����Ϣ
quit=1;--�������ʱ�˳�ѭ��
end

function Analog2(x,y)--ҡ����Ϣ
end

local img = LoadImage("1.jpg",RFZLUA.IMG_8888);--����ͼƬ
while quit==0 do
BeginScene(1);--��ʼ��ͼ
DrawImage(img,0,0);--��ͼ
EndScene();--������ͼ
end
FreeImage(img);--�ͷ�img�ڴ�

SetUserInputProcIndex(0);--������ϵͳ����ΪĬ�ϰ���ϵͳ