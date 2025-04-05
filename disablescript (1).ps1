# Define paths
$scriptPath = "C:\IntranetStartup\OpenIntranet.ps1"
$startupFolder = "C:\IntranetStartup"
$GPOPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"

# Remove the startup script file
if (Test-Path -Path $scriptPath) {
    Remove-Item -Path $scriptPath -Force
    Write-Output "Startup script removed."
} else {
    Write-Output "Startup script not found."
}

# Remove the startup folder if it exists
if (Test-Path -Path $startupFolder) {
    Remove-Item -Path $startupFolder -Recurse -Force
    Write-Output "Startup folder removed."
} else {
    Write-Output "Startup folder not found."
}

# Remove the custom shell registry key
if (Test-Path -Path $GPOPath) {
    Remove-ItemProperty -Path $GPOPath -Name "Shell" -Force
    Write-Output "Custom shell configuration removed."
} else {
    Write-Output "Custom shell configuration not found."
}

# Reset execution policy to default
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope LocalMachine -Force
Write-Output "Execution policy reset to default."

