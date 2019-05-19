Attribute VB_Name = "Process"
'Emerald ��ش���

Public VBIDEPath As String, InstalledPath As String, IsUpdate As Boolean
Public WelcomePage As New WelcomePage, TitleBar As New TitleBar, SetupPage As SetupPage, WaitPage As WaitPage, DialogPage As DialogPage
Public Tasks() As String
Public CmdMark As String, SetupErr As Long, Repaired As Boolean
Public Sub CheckUpdate()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\version")
    IsUpdate = (Val(temp) <> Version)
    
ErrHandle:
    
End Sub
Public Sub GetInstalledPath()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\icon")
    InstalledPath = Replace(temp, """", "")
    
ErrHandle:
    
End Sub
Public Sub GetVBIDEPath()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String, temp2() As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\VisualBasic.Project\shell\open\command\")
    temp2 = Split(temp, "vb6.exe")
    VBIDEPath = Replace(temp2(0), """", "")
    
ErrHandle:
    If Err.Number <> 0 Then
        Dialog "��·", "��ȡVB6·��ʧ�ܣ���ȷ�����ĵ������Ѿ���װVB6���Ǿ���棩��" & vbCrLf & vbCrLf & _
               "ע�⣺Emeraldֻ������VB6", "�ð�"
    End If
End Sub
Public Function CheckFileName(name As String) As Boolean
    CheckFileName = ((InStr(name, "*") Or InStr(name, "\") Or InStr(name, "/") Or InStr(name, ":") Or InStr(name, "?") Or InStr(name, """") Or InStr(name, "<") Or InStr(name, ">") Or InStr(name, "|") Or InStr(name, " ") Or InStr(name, "!") Or InStr(name, "-") Or InStr(name, "+") Or InStr(name, "#") Or InStr(name, "@") Or InStr(name, "$") Or InStr(name, "^") Or InStr(name, "&") Or InStr(name, "(") Or InStr(name, ")")) = 0)
    Dim t As String
    If name <> "" Then t = Left(name, 1)
    CheckFileName = CheckFileName And (Trim(Str(Val(t))) <> t)
End Function
Sub Uninstall()
    'If Dialog("ж��", "Emerald Builder �Ѿ���װ����ϣ��ɾ������", "ж��", "�ֻ�") <> 1 Then End
    On Error Resume Next
    
    SetupPage.SetupInfo = "���ڴ�����WScript.Shell����"
    SetupPage.Progress = 0.1
    Call FakeSleep
    
    Set WSHShell = CreateObject("WScript.Shell")
    
    SetupPage.SetupInfo = "����ɾ������Դ�����������˵���"
    SetupPage.Progress = 0.4
    Call FakeSleep
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\version"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\"
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\"
    
    SetupPage.SetupInfo = "����ɾ���������Ϣ"
    SetupPage.Progress = 0.7
    Call FakeSleep
    
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\"
    
    SetupPage.SetupInfo = "����ɾ����Visual Basic 6 ģ���ļ� (1/2)"
    SetupPage.Progress = 0.8
    Call FakeSleep
    
    Kill VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    
    SetupPage.SetupInfo = "����ɾ����Visual Basic 6 ģ���ļ� (2/2)"
    SetupPage.Progress = 0.9
    Call FakeSleep
    
    Kill VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
    SetupPage.SetupInfo = "��β"
    SetupPage.Progress = 1
    
    SetupErr = Err.Number
End Sub
Sub FakeSleep()
    For i = 1 To 10
        Sleep 10: DoEvents
        ECore.Display
    Next
End Sub
Sub Setup()
    On Error Resume Next
    
    Dim exeP As String
    exeP = """" & App.Path & "\Builder.exe" & """"
    
    SetupPage.SetupInfo = "���ڴ�����WScript.Shell����"
    SetupPage.Progress = 0.1
    Set WSHShell = CreateObject("WScript.Shell")

    Call FakeSleep

    SetupPage.SetupInfo = "����ע�᣺��Դ�����������˵���"
    SetupPage.Progress = 0.3
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\version", Version
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\", exeP & " ""%v"""
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\", exeP & " ""%v"""
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "����ע�᣺�����Ϣ"
    SetupPage.Progress = 0.6
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon", exeP
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName", "Emerald"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion", "Indev " & Version
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher", "Error 404"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation", App.Path
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout", "http://red-error404.github.io/233"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString", exeP & " ""-uninstall"""
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "���ڸ��ƣ�Visual Basic 6 ģ���ļ���1/2��"
    SetupPage.Progress = 0.8
    FileCopy App.Path & "\Example\Emerald ��Ϸ����.frm", VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "���ڸ��ƣ�Visual Basic 6 ģ���ļ���2/2��"
    SetupPage.Progress = 0.9
    FileCopy App.Path & "\Example\Emerald ҳ��.cls", VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "��β"
    SetupPage.Progress = 1
    
    SetupErr = Err.Number
End Sub
Sub CheckVersion()
    On Error Resume Next
    Dim exeP As String, sh As String
    exeP = """" & App.Path & "\Builder.exe" & """"
    Set WSHShell = CreateObject("WScript.Shell")
    
    sh = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\version")
    
    If sh <> "" Then
        If Val(sh) <> Version Then
            If Dialog("���¿���", "ʹ��ǰ��Ҫ�������Emerald��", "����", "�Ժ�") <> 1 Then End
            Call Setup
            Dialog "����", "���³ɹ�������������������", "�õ�"
            End
        End If
    End If
End Sub
Sub Repair()
    If InstalledPath = "" Then Exit Sub
    
    If Dir(InstalledPath) = "" Then
        EECore.NewTransform transFadeIn, 700, "WelcomePage": Repaired = True
    End If
End Sub
Sub Main()
    MainWindow.Show
    
    Call CheckUpdate
    Call GetVBIDEPath
    Call GetInstalledPath
    Call Repair
    If Repaired Then Exit Sub
    
    If Command$ <> "" Then
        Dim appn As String, f As String, t As String, p As String
        Dim nList As String, xinfo As String, info() As String
        p = Replace(Command$, """", "")

        If p = "-uninstall" Then Call Uninstall
        Call CheckVersion
        
        If Dir(p & "\.emerald") <> "" Then
            Open p & "\.emerald" For Input As #1
            Do While Not EOF(1)
            Line Input #1, t
            xinfo = xinfo & t & vbCrLf
            Loop
            Close #1
            info = Split(xinfo, vbCrLf)
        End If
        
        If Dir(p & "\core\GCore.bas") <> "" Then
            If Val(info(0)) < Version Then
                nList = nList & CompareFolder(App.Path & "\core", p & "\core") & vbCrLf
                If nList = vbCrLf Then
                    Dialog "���̸���", "�����ѽ����µ��ļ����Ƶ�����ļ����У�����û���������ļ���", "�õ�"
                Else
                    Dialog "���̸���", "��Ĺ����Ѿ�������" & vbCrLf & "�����ѽ����µ��ļ����Ƶ�����ļ����У�������Ժ��������ǡ�" & vbCrLf & vbCrLf & "ע�⣺�����Ǹ���Emerald���������ļ�����Ҫ���ֶ�����" & vbCrLf & "��λ��Ŀ¼�µ�Core�ļ��У���" & vbCrLf & nList, "�յ���"
                End If
                If Val(info(0)) < 19051004 Then
                    Dialog "����", "��Դ���غ����Ѿ�Ǩ�ơ�" & vbCrLf & "Page->Page.Res" & vbCrLf & vbCrLf & "* �������Emerald�ṩ�Ĵ���ģ��", "Ŷ"
                End If
                If Val(info(0)) < 19051110 Then
                    Dialog "����", "����������������" & vbCrLf & "�����DebugSwitchģ�����ע���޸Ĵ��룡" & vbCrLf & vbCrLf & "* �������Emerald�ṩ�Ĵ���ģ��", "Ŷ"
                    Dialog "����", "������ջ����޸�" & vbCrLf & "������Ļ�ͼ���̼���Page.Clear��" & vbCrLf & vbCrLf & "* �������Emerald�ṩ�Ĵ���ģ��", "Ŷ"
                End If
                GoTo SkipName
            Else
                Dialog "�޲���", "��Ĺ����Ѿ���ʹ�����µ�Emerald�ˡ�", "�ֻ�"
                Exit Sub
            End If
        End If

        appn = InputAsk("��������", "������Ŀɰ��Ĺ�������(*^��^*)~", "���", "ȡ��")
        If CheckFileName(appn) = False Or appn = "" Then Dialog "��ŭ", "����Ĺ������ơ�", "����": Exit Sub
        
        Open App.Path & "\example.vbp" For Input As #1
        Do While Not EOF(1)
        Line Input #1, t
        f = f & t & vbCrLf
        Loop
        Close #1
        
        f = Replace(f, "{app}", appn)
        
        Open p & "\" & appn & ".vbp" For Output As #1
        Print #1, f
        Close #1
            
SkipName:
        If Dir(p & "\core", vbDirectory) = "" Then MkDir p & "\core"
        CopyInto App.Path & "\core", p & "\core"
        If Dir(p & "\assets", vbDirectory) = "" Then MkDir p & "\assets"
        If Dir(p & "\assets\debug", vbDirectory) = "" Then MkDir p & "\assets\debug"
        CopyInto App.Path & "\assets\debug", p & "\assets\debug"
        CopyInto App.Path & "\framework", p
        If Dir(p & "\music", vbDirectory) = "" Then MkDir p & "\music"
        
        Open p & "\.emerald" For Output As #1
        Print #1, Version 'version
        Print #1, Now 'Update Time
        Close #1
        
    Else
        
        If InstalledPath <> "" Then
            If (Not IsUpdate) Then
                ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
            Else
                ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
            End If
        End If
        
        If InstalledPath = "" Then
            ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
        End If
        
    End If
End Sub
Function InputAsk(t As String, c As String, ParamArray b()) As String
    InputAsk = InputBox(c, t)
End Function
Function Dialog(t As String, c As String, ParamArray b()) As Integer
    Dim b2(), last As String
    b2 = b
    
    last = ECore.ActivePage
    DialogPage.NewDialog t, c, b2
    
    Do While DialogPage.Key = 0
        ECore.Display
        Sleep 10: DoEvents
    Loop
    
    Dialog = DialogPage.Key
    ECore.NewTransform transFadeIn, 700, last
End Function
Sub CopyInto(Src As String, Dst As String)
    Dim f As String, p As Boolean
    p = Dir(Dst & "\Core.bas") <> ""
    f = Dir(Src & "\")
    Do While f <> ""
        If f = "Core.bas" Then
            If p Then GoTo skip
        End If
        FileCopy Src & "\" & f, Dst & "\" & f
skip:
        f = Dir()
    Loop
End Sub
Function CompareFolder(Src As String, Dst As String) As String
    Dim f As String, fs() As String
    f = Dir(Src & "\")
    
    ReDim fs(0)
    
    Do While f <> ""
        ReDim Preserve fs(UBound(fs) + 1)
        fs(UBound(fs)) = f
        f = Dir()
    Loop
    
    For i = 1 To UBound(fs)
        If Dir(Dst & "\" & fs(i)) = "" Then
            CompareFolder = CompareFolder & fs(i) & vbCrLf
        End If
    Next
End Function
