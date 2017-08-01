## Windows 标准(内置)环境变量


Variable                        | Volatile <br> (Read-Only) | Default value in Windows (system drive is C: )
--------                        | --------                  | --------
ALLUSERSPROFILE                 |                           | C:\ProgramData
APPDATA                         |                           | C:\Users\{username}\AppData\Roaming
CD                              | Y                         | The current directory (string).
ClientName                      | Y                         | Terminal servers only - the ComputerName of a remote host.
CMDEXTVERSION                   | Y                         | The current Command Processor Extensions version number. (NT = "1", Win2000+ = "2".)
CMDCMDLINE                      | Y                         | The original command line that invoked the Command Processor.
CommonProgramFiles              |                           | C:\Program Files\Common Files
COMMONPROGRAMFILES(x86)         |                           | C:\Program Files (x86)\Common Files
COMPUTERNAME                    |                           | {computername}
COMSPEC                         |                           | C:\Windows\System32\cmd.exe or if running a 32 bit WOW - C:\Windows\SysWOW64\cmd.exe
DATE                            | Y                         | The current date using same region specific format as DATE.
ERRORLEVEL                      | Y                         | The current ERRORLEVEL value, automatically set when a program exits.
FPS_BROWSER_APP_PROFILE_STRING  |                           | Internet Explorer
FPS_BROWSER_USER_PROFILE_STRING |                           | Default
                                |                           | These are undocumented variables for the Edge browser in Windows 10.
HighestNumaNodeNumber           | Y (hidden)                | The highest NUMA node number on this computer.
HOMEDRIVE                       | Y                         | C:
HOMEPATH                        | Y                         | \Users\{username}
LOCALAPPDATA                    |                           | C:\Users\{username}\AppData\Local
LOGONSERVER                     |                           | \\{domain_logon_server}
NUMBER_OF_PROCESSORS            | Y                         | The Number of processors running on the machine.
OS                              | Y                         | Operating system on the user's workstation.
PATH                            | User and                  | C:\Windows\System32\;C:\Windows\;C:\Windows\System32\Wbem;{plus program paths}
                                | System                    |
PATHEXT                         |                           | .COM; .EXE; .BAT; .CMD; .VBS; .VBE; .JS ; .WSF; .WSH; .MSC
                                |                           | The syntax is like the PATH variable - semicolon separators.
PROCESSOR_ARCHITECTURE          | Y                         | AMD64/IA64/x86 This doesn't tell you the architecture of the processor but only of the current process, so it returns "x86" for a 32 bit WOW process running on 64 bit Windows. See detecting OS 32/64 bit
PROCESSOR_ARCHITEW6432          |                           | =%ProgramFiles% (only available on 64 bit systems)
PROCESSOR_IDENTIFIER            | Y                         | Processor ID of the user's workstation.
PROCESSOR_LEVEL                 | Y                         | Processor level of the user's workstation.
PROCESSOR_REVISION              | Y                         | Processor version of the user's workstation.
ProgramW6432                    |                           | =%PROCESSOR_ARCHITECTURE% (only available on 64 bit systems)
ProgramData                     |                           | C:\ProgramData
ProgramFiles                    |                           | C:\Program Files or C:\Program Files (x86)
ProgramFiles(x86) 1             |                           | C:\Program Files (x86)
PROMPT                          |                           | Code for current command prompt format,usually $P$G
                                |                           | C:>
PSModulePath                    |                           | %SystemRoot%\system32\WindowsPowerShell\v1.0\Modules\
Public                          |                           | C:\Users\Public
RANDOM                          | Y                         | A random integer number, anything from 0 to 32,767 (inclusive).
%SessionName%                   |                           | Terminal servers only - for a terminal server session, SessionName is a combination of the connection name, followed by #SessionNumber. For a console session, SessionName returns "Console".
SYSTEMDRIVE                     |                           | C:
SYSTEMROOT                      |                           | By default, Windows is installed to C:\Windows but there's no guarantee of that, Windows can be installed to a different folder, or a different drive letter.
                                |                           | systemroot is a read-only system variable that will resolve to the correct location.
                                |                           | NT 4.0, Windows 2000 and Windows NT 3.1 default to C:\WINNT
TEMP and TMP                    | User Variable             | C:\Users\{Username}\AppData\Local\Temp
                                |                           | Under XP this was \{username}\Local Settings\Temp
TIME                            | Y                         | The current time using same format as TIME.
UserDnsDomain                   | Y                         | Set if a user is a logged on to a domain and returns the fully qualified DNS domain that the currently logged on user's account belongs to.
                                | User Variable             |
USERDOMAIN                      |                           | {userdomain}
USERDOMAIN_roamingprofile       |                           | The user domain for RDS or standard roaming profile paths. Windows 8/10/2012 (or Windows 7/2008 with Q2664408)
USERNAME                        |                           | {username}
USERPROFILE                     |                           | "%SystemDrive%\Users\{username}
This is equivalent to the $HOME environment variable in Unix/Linux"
WINDIR                          |                           | "%WinDir% pre-dates Windows NT and seems to be superseded by %SystemRoot%
Set by default as windir=%SystemRoot%
%windir% is a regular variable and can be changed, which makes it less robust than %systemroot%"
