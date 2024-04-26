#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region Foxit Reader
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\FoxitPDFReader20241_enu_Setup', '/quiet', 'ADDLOCAL="FX_PDFVIEWER"'
    if (Test-Path "C:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe") {
        Write-Log "Foxit Reader has been installed"
    }
    else {
        write-log "Error locating the Foxit Reader executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Foxit Reader: $ErrorMessage"
}
#endregion


#region Notepad++
try {
    Start-Process -filepath 'c:\temp\npp.7.8.8.Installer' -Wait -ErrorAction Stop -ArgumentList '/S'
    Copy-Item 'C:\Program Files (x86)\Notepad++'
    Rename-Item 'C:\Program Files (x86)\Notepad++\updater' 'C:\Program Files (x86)\Notepad++\updaterOld'
    if (Test-Path "C:\Program Files (x86)\Notepad++\notepad++.exe") {
        Write-Log "Notepad++ has been installed"
    }
    else {
        write-log "Error locating the Notepad++ executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Notepad++: $ErrorMessage"
}
#endregion

#region Notepad++(old)

#endregion
