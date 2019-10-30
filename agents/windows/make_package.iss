[Setup]
AppName=RT Monitor
AppVersion=1.0
WizardStyle=modern
DisableWelcomePage=no
CreateAppDir=yes
DisableProgramGroupPage=yes
DefaultGroupName=RT Monitor
DefaultDirName={autopf}\RTMonitor
UninstallDisplayIcon={app}\bin\zabbix_agentd.exe
Compression=lzma2
SolidCompression=yes
OutputDir=compiled
PrivilegesRequired=admin
OutputBaseFilename=RTMonitor-setup


[Dirs]
Name: "{app}\bin"
Name: "{app}\conf"
Name: "{app}\conf.d"
Name: "{app}\logs"


[Files]
Source: "bin\zabbix_agentd.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "bin\speedtest.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "conf\rtmonitor.conf"; DestDir: "{app}\conf"; Flags: ignoreversion; AfterInstall: ReplaceVariables(ExpandConstant('{app}\conf\rtmonitor.conf'), ExpandConstant('{app}'))
Source: "conf.d\speedtest.conf"; DestDir: "{app}\conf.d"; Flags: ignoreversion; AfterInstall: ReplaceVariables(ExpandConstant('{app}\conf.d\speedtest.conf'), ExpandConstant('{app}'))

[Run]
Filename: "{app}\bin\zabbix_agentd.exe"; Parameters: "--multiple-agents --config ""{app}\conf\rtmonitor.conf"" --stop"; StatusMsg: "Stopping RT Monitor service"; Flags: runascurrentuser
Filename: "{app}\bin\zabbix_agentd.exe"; Parameters: "--multiple-agents --config ""{app}\conf\rtmonitor.conf"" --install"; StatusMsg: "Installing RT Monitor service"; Flags: runascurrentuser
Filename: "{app}\bin\zabbix_agentd.exe"; Parameters: "--multiple-agents --config ""{app}\conf\rtmonitor.conf"" --start"; StatusMsg: "Starting RT Monitor service"; Flags: runascurrentuser

[UninstallRun]
Filename: "{app}\bin\zabbix_agentd.exe"; Parameters: "--multiple-agents --config ""{app}\conf\rtmonitor.conf"" --stop"; StatusMsg: "Stopping RT Monitor service"; Flags: runascurrentuser
Filename: "{app}\bin\zabbix_agentd.exe"; Parameters: "--multiple-agents --config ""{app}\conf\rtmonitor.conf"" --uninstall"; StatusMsg: "Uninstalling RT Monitor service"; Flags: runascurrentuser

[Code]

procedure ReplaceVariables(FileName, AppVariable: String);
var
  MyFile : TStrings;
  MyText : String;
begin
  MyFile := TStringList.Create;

  try

    try
      MyFile.LoadFromFile(FileName);
      MyText := MyFile.Text;

      { Only save if text has been changed. }
      if StringChangeEx(MyText, '__app__', AppVariable, True) > 0 then
      begin;
        MyFile.Text := MyText;
        MyFile.SaveToFile(FileName);
      end;
    except;
    end;
  finally
    MyFile.Free;
  end;
end;