Attribute VB_Name = "DebugSwitch"
'   Emerald ������

'======================================================
'   �Ƿ���Debug
    Public Const DebugMode As Boolean = False
'   �Ƿ���ÿ���LOGO�������Դ�Ѿ�������ϣ�
    Public Const HideLOGO As Boolean = False
'   �����¼��ʱ�����죩
    Public Const UpdateCheckInterval As Long = 1
'   ���¼�鳬ʱʱ�䣨���룩
    Public Const UpdateTimeOut As Long = 2000
'======================================================


'==============================================================================
'   �汾����ע������
'   1.���ش���ĸı�
'     ���ڿ���LOGO�ļ��룬
'     �����������ҳ��Ϳ�������Timer�Ĵ���ת�Ƶ�����ҳ��֮ǰ��������һ�С�Me.Show��
'   *�ò��������Բ���Emerald�ṩ��ģ��
'   2.Emerald��ʼ���ĸı�
'     �����뵽Emerald�Ĵ��ڴ�С��������Emerald��������һ�Ρ�
'==============================================================================




'======================================================
'   Warning: please don't edit the following code .
    Public Debug_focus As Boolean
'======================================================
