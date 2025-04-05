# Define variables
$intranetUrl = "https://yourintraneturl.com"  # Replace with your intranet URL
$browserPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"  # Path to Microsoft Edge

# Path for the startup script that will launch the intranet in kiosk mode
$scriptPath = "C:\IntranetStartup\OpenIntranet.ps1"

# Create directory for the script if it doesn't exist
if (!(Test-Path -Path "C:\IntranetStartup")) {
    New-Item -ItemType Directory -Path "C:\IntranetStartup"
}

# Write the kiosk mode browser launch script to a file
$scriptContent = @"
# PowerShell script to open intranet in kiosk mode
Start-Process -FilePath "$browserPath" -ArgumentList "--kiosk $intranetUrl"
"@
$scriptContent | Out-File -FilePath $scriptPath -Encoding UTF8

# Set the script execution policy to allow running the script
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force

# Set the Group Policy setting for Custom User Interface
$GPOPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
if (!(Test-Path -Path $GPOPath)) {
    New-Item -Path $GPOPath -Force
}
Set-ItemProperty -Path $GPOPath -Name "Shell" -Value "powershell.exe -ExecutionPolicy Bypass -File `"$scriptPath`""

Write-Output "Intranet startup configuration applied. The system will launch the intranet in Edge's kiosk mode on login."





