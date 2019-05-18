VERSION 5.00
Begin VB.Form MainWindow 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "��������"
   ClientHeight    =   6672
   ClientLeft      =   12
   ClientTop       =   12
   ClientWidth     =   9660
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
'   �ڴ˴��������ҳ����ģ������
    Dim WelcomePage As New WelcomePage, TitleBar As New TitleBar
'==================================================

Private Sub DrawTimer_Timer()
    '����
    EC.Display
End Sub

Private Sub Form_Load()
    '��ʼ��Emerald
    StartEmerald Me.Hwnd, Me.ScaleWidth, Me.ScaleHeight
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
    
    Set TitleBar = New TitleBar

    '���ûҳ��
    EC.ActivePage = "WelcomePage"
    If InstalledPath = "" Then
        WelcomePage.Page.StartAnimation 1
        WelcomePage.Page.StartAnimation 2, 200
    End If
    
    Me.Show
    DrawTimer.Enabled = True
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    '���������Ϣ
    UpdateMouse X, Y, 1, button
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single)
    '���������Ϣ
    If Mouse.state = 0 Then
        UpdateMouse X, Y, 0, button
    Else
        Mouse.X = X: Mouse.Y = Y
    End If
End Sub
Private Sub Form_MouseUp(button As Integer, Shift As Integer, X As Single, Y As Single)
    '���������Ϣ
    UpdateMouse X, Y, 2, button
End Sub

Private Sub Form_Unload(Cancel As Integer)
    '��ֹ����
    DrawTimer.Enabled = False
    '�ͷ�Emerald��Դ
    EndEmerald
End Sub
