
local quit = 0;

function BtnDown(key)
if key== RFZLUA.BTN_CIRCLE then--������O��ʱ�˳�
quit=1;
end
end
--ע:��ģʽ�� SetUserInputProcIndex ����Ϊ��Ч����
function RFZExtendMode()
InitUserInputProc();--��ʼ���û�����ϵͳ--SetUserInputProcIndex(1);�����û�����ϵͳ����local gif = LoadGif("test.gif",RFZLUA.IMG_8888);--����ͼƬwhile quit==0 doBeginScene(1);--��ʼ��ͼDrawGif(gif,0,0);--��ͼEndScene();--������ͼendFreeGif(gif);--�ͷ�gif�ڴ�FiniUserInputProc();--�ͷ��û�����
end