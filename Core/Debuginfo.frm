VERSION 5.00
Begin VB.Form Debuginfo 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Game Manager"
   ClientHeight    =   5750
   ClientLeft      =   30
   ClientTop       =   370
   ClientWidth     =   6090
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   575
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   609
   StartUpPosition =   2  '��Ļ����
   Begin VB.Timer Reporter 
      Interval        =   20
      Left            =   2640
      Top             =   2760
   End
   Begin VB.Label msg 
      BackStyle       =   0  'Transparent
      Caption         =   "Information"
      ForeColor       =   &H00808080&
      Height          =   5010
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   5370
   End
End
Attribute VB_Name = "Debuginfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Reporter_Timer()
    Dim text As String
    
    text = "��������" & App.Title & vbCrLf & vbCrLf & _
                                "���״̬��" & Mouse.State & "(" & Mouse.button & ")  (" & Mouse.X & "," & Mouse.Y & ")" & vbCrLf & _
                                "�浵״̬��" & IIf(Not ESave Is Nothing, "�Ѵ���", "δ����")
                                
    If Not ESave Is Nothing Then text = text & "��Ȩ�ޣ�" & ESave.sToken & "�����ݸ�����" & ESave.Count
    
    text = text & vbCrLf
    
    text = text & "��ǰ�ҳ�棺" & ECore.ActivePage & vbCrLf
    text = text & "FPS��" & FPS & vbCrLf
    text = text & "ÿ֡��ʱ��" & Int(FPSct / FPS) & "ms" & vbCrLf
    text = text & "���⼫��fps��" & Int(1000 / Int(FPSct / FPS)) & vbCrLf
    
    text = text & vbCrLf & vbCrLf & "ע������" & vbCrLf
    
    If Abs(FPSctt - 1000) > 60 Then text = text & "�ƺ�������ʹ��Timer��ͼ��" & vbCrLf
    
    msg.Caption = text
End Sub
