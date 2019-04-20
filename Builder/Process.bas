Attribute VB_Name = "Process"
Public Const Version As Long = 19042001
Public Function CheckFileName(name As String) As Boolean
    CheckFileName = ((InStr(name, "*") Or InStr(name, "\") Or InStr(name, "/") Or InStr(name, ":") Or InStr(name, "?") Or InStr(name, """") Or InStr(name, "<") Or InStr(name, ">") Or InStr(name, "|")) = 0)
End Function
Sub Main()
    If Command$ <> "" Then
        Dim appn As String, f As String, t As String, p As String
        Dim nList As String, xinfo As String, info() As String
        p = Replace(Command$, """", "")

        
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
                MsgBox "��Ĺ����Ѿ������������ѽ����µ��ļ����Ƶ�����ļ����У�������Ժ��������ǡ�" & vbCrLf & vbCrLf & "ע�⣺�����Ǹ���Emerald���������ļ�����Ҫ���ֶ����ã�λ��Ŀ¼�µ�Core�ļ��У���" & vbCrLf & nList, 64, "Emerald Builder"
                GoTo SkipName
            Else
                MsgBox "��Ĺ����Ѿ���ʹ�����µ�Emerald�ˡ�", 48, "Emerald Builder"
                Exit Sub
            End If
        End If

        appn = InputBox("������Ĺ�������", "Emerald Project")
        If CheckFileName(appn) = False Or appn = "" Then MsgBox "����Ĺ������ơ�", 16, "Emerald Builder": Exit Sub
        
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
                If MsgBox("Emerald Builder �Ѿ���װ����ϣ��ɾ������", vbYesNo + 48, "Emerald Builder") = vbYes Then
                    
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\"
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon"
                    
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\version"
                    
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\"
                    
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\"
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon"
                    
                    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\"
                    
                    MsgBox "Emerald Builder �Ѿ�����ĵ�����ɾ����", 48, "Emerald Builder"
                    
                    End
                Else
                    End
                End If
            Else
                If MsgBox("����ȷ���������� Emerald Builder .", 64 + vbYesNo, "Emerald Builder") = vbNo Then Exit Sub
            End If
        End If
        
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\", "�ڴ˴�����/����Emerald����"
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon", exeP
        
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\version", Version
        
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\", exeP & " ""%v"""
        
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\", "�ڴ˴�����/����Emerald����"
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon", exeP
        
        WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\", exeP & " ""%v"""
        
        MsgBox "Emerald Builder �ɹ���װ����ĵ����ϡ�", 64
        
FailOper:
        MsgBox "����һЩ���⣬�޷���ɲ��ֲ�����" & vbCrLf & Err.Description & "(" & Err.Number & ")", 48, "Emerald Builder"
    End If
End Sub
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
