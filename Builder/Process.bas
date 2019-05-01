Attribute VB_Name = "Process"
Public Const Version As Long = 19050108
Public VBIDEPath As String
Public Sub GetVBIDEPath()
    On Error GoTo errHandle
    
    Dim WSHShell As Object, temp As String, temp2() As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\VisualBasic.Project\shell\open\command\")
    temp2 = Split(temp, "vb6.exe")
    VBIDEPath = Replace(temp2(0), """", "")
    
errHandle:
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
    If Dialog("ж��", "Emerald Builder �Ѿ���װ����ϣ��ɾ������", "ж��", "�ֻ�") <> 1 Then End

    On Error Resume Next
    
    Set WSHShell = CreateObject("WScript.Shell")
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\version"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\"
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\"
    
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\"
    
    Kill VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    Kill VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
    If Err.Number <> 0 Then
        MsgBox "ж�ع����в��ֲ�����ִ��󣬿�����Ҫ���ֶ�ȷ��ɾ����", 64, "�ټ�"
    End If
    
    Dialog "�ټ�", "Emerald Builder �Ѿ�����ĵ�����ɾ����", "�ټ�"
    
    End
End Sub
Sub Setup()
    Dim exeP As String
    exeP = """" & App.Path & "\Builder.exe" & """"
    Set WSHShell = CreateObject("WScript.Shell")
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\version", Version
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\", exeP & " ""%v"""
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\", exeP & " ""%v"""
    
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon", exeP
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName", "Emerald"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion", "Indev " & Version
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher", "Error 404"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation", App.Path
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout", "http://red-error404.github.io/233"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString", exeP & " ""-uninstall"""
    
    FileCopy App.Path & "\Example\Emerald ��Ϸ����.frm", VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    FileCopy App.Path & "\Example\Emerald ҳ��.cls", VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
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
Sub Main()
    Call GetVBIDEPath
    
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
                    Dialog "���̸���", "��Ĺ����Ѿ������������ѽ����µ��ļ����Ƶ�����ļ����У�������Ժ��������ǡ�" & vbCrLf & vbCrLf & "ע�⣺�����Ǹ���Emerald���������ļ�����Ҫ���ֶ����ã�λ��Ŀ¼�µ�Core�ļ��У���" & vbCrLf & nList, "�յ���"
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
        Dim exeP As String, sh As String
        exeP = """" & App.Path & "\Builder.exe" & """"
        Set WSHShell = CreateObject("WScript.Shell")
        
        On Error GoTo FailRead
        sh = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\version")
FailRead:
        
        On Error GoTo FailOper
        
        If sh <> "" Then
            If Val(sh) = Version Then
                Call Uninstall
                End
            Else
                If Dialog("���¿���", "����ȷ���������� Emerald Builder .", "ȷ��", "ȡ��") <> 1 Then Exit Sub
            End If
        End If
        
        Call Setup
        
        Dialog "�ɹ�", "Emerald Builder �ɹ���װ����ĵ����ϡ�", "��"
        
FailOper:
        If Err.Number <> 0 Then Dialog "����", "����һЩ���⣬�޷���ɲ��ֲ�����" & vbCrLf & Err.Description & "(" & Err.Number & ")", "�ð�"
    End If
End Sub
Function InputAsk(t As String, c As String, ParamArray b()) As String
    Dim w As New MainWindow, b2()
    b2 = b
    
    w.NewDialog t, c, "", True, b2
    w.Show
    
    Do While w.Visible
        DoEvents
    Loop
    
    If w.Key = 1 Then InputAsk = w.InputBox.Content
    Unload w
End Function
Function Dialog(t As String, c As String, ParamArray b()) As Integer
    Dim w As New MainWindow, b2()
    b2 = b
    
    w.NewDialog t, c, "", False, b2
    w.Show
    
    Do While w.Visible
        DoEvents
    Loop
    
    Dialog = w.Key
    Unload w
End Function
Sub CopyInto(Src As String, Dst As String)
    Dim f As String
    f = Dir(Src & "\")
    Do While f <> ""
        FileCopy Src & "\" & f, Dst & "\" & f
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
