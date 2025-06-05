# install_pad.ps1

# URL инсталлятора PAD
$padInstallerUrl = "https://go.microsoft.com/fwlink/?linkid=2102613"
$tempFolder = $ENV:TEMP
$padInstallerPath = Join-Path -Path $tempFolder -ChildPath "Setup.Microsoft.PowerAutomate.exe"

# Создание временной папки
if (!(Test-Path -Path $tempFolder)) {
    Write-Output "Temporary folder $tempFolder does not exist. Creating it..."
    New-Item -ItemType Directory -Path $tempFolder | Out-Null
}

# Скачивание PAD установщика
Write-Output "Downloading Power Automate Desktop installer..."
try {
    Invoke-WebRequest -Uri $padInstallerUrl -OutFile $padInstallerPath -UseBasicParsing
    Write-Output "Installer downloaded to $padInstallerPath"
} catch {
    Write-Output "Error downloading PAD installer: $_"
    exit 1
}

# Проверяем наличие скачанного файла
if (!(Test-Path -Path $padInstallerPath)) {
    Write-Output "Error: Installer file not found at $padInstallerPath"
    exit 1
}

# Установка PAD
Write-Output "Installing Power Automate Desktop..."
try {
    Start-Process -FilePath $padInstallerPath -ArgumentList "/silent" -Wait
    Write-Output "Power Automate Desktop installed successfully."
} catch {
    Write-Output "Error during installation: $_"
    exit 1
}

# Очистка временных файлов
Write-Output "Cleaning up temporary files..."
try {
    Remove-Item -Path $padInstallerPath -Force
    Write-Output "Temporary files cleaned up."
} catch {
    Write-Output "Error during cleanup: $_"
}

Write-Output "Script execution completed."