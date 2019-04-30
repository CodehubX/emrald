VERSION 5.00
Begin VB.Form TestWindow 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Emerald.Test"
   ClientHeight    =   6672
   ClientLeft      =   48
   ClientTop       =   396
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
Attribute VB_Name = "TestWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim GTest As GTest, EC As GMan

Private Sub DrawTimer_Timer()
    EC.Display
End Sub

Private Sub Form_Load()
    StartEmerald Me.Hwnd, Me.ScaleWidth, Me.ScaleHeight
    MakeFont "΢���ź�"
    
    Set EC = New GMan
    
    Set ESave = New GSaving
    ESave.Create "emerald.test", "Emerald.test"
    
    EC.ActivePage = "TestPage"
    
    Me.Show
    DrawTimer.Enabled = True
    
    Set GTest = New GTest
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    UpdateMouse X, Y, 1, button
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single)
    If Mouse.State = 0 Then UpdateMouse X, Y, 0, button
End Sub

Private Sub Form_MouseUp(button As Integer, Shift As Integer, X As Single, Y As Single)
    UpdateMouse X, Y, 2, button
End Sub

Private Sub Form_Unload(Cancel As Integer)
    DrawTimer.Enabled = False
    EndEmerald
End Sub
