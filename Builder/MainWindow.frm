VERSION 5.00
Begin VB.Form MainWindow 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Emerald Builder"
   ClientHeight    =   6672
   ClientLeft      =   12
   ClientTop       =   12
   ClientWidth     =   9660
   Icon            =   "MainWindow.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   556
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   805
   StartUpPosition =   2  '��Ļ����
   Begin VB.Timer DrawTimer 
      Enabled         =   0   'False
      Interval        =   5
      Left            =   9000
      Top             =   240
   End
End
Attribute VB_Name = "MainWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==================================================
'   ҳ�������
    Dim EC As GMan
    Dim oShadow As New aShadow
'==================================================
Private Sub DrawTimer_Timer()
    '����
    EC.Display
End Sub

Private Sub Form_Load()
    '��ʼ��Emerald
    StartEmerald Me.Hwnd, 805, 556
    '��������
    MakeFont "΢���ź�"
    '����ҳ�������
    Set EC = New GMan
    EC.Layered True
    
    '�����浵����ѡ��
    Set ESave = New GSaving
    ESave.Create "Emerald.builder", "Emerald.builder"
    
    '���������б�
    Set MusicList = New GMusicList
    MusicList.Create App.Path & "\music"

    '��ʼ��ʾ
    With oShadow
        If .Shadow(Me) Then
            .Depth = 20
            .Transparency = 16
        End If
    End With
    
    '�ڴ˴���ʼ�����ҳ��
    Set WelcomePage = New WelcomePage
    Set SetupPage = New SetupPage
    Set WaitPage = New WaitPage
    Set DialogPage = New DialogPage
    Set UpdatePage = New UpdatePage
    
    Set TitleBar = New TitleBar

    '���ûҳ��
    EC.ActivePage = "WaitPage"
    
    DrawTimer.Enabled = True
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, x As Single, y As Single)
    '���������Ϣ
    UpdateMouse x, y, 1, button
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, x As Single, y As Single)
    '���������Ϣ
    If Mouse.state = 0 Then
        UpdateMouse x, y, 0, button
    Else
        Mouse.x = x: Mouse.y = y
    End If
End Sub
Private Sub Form_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
    '���������Ϣ
    UpdateMouse x, y, 2, button
End Sub

Private Sub Form_Unload(Cancel As Integer)
    '��ֹ����
    DrawTimer.Enabled = False
    '�ͷ�Emerald��Դ
    EndEmerald
End Sub
