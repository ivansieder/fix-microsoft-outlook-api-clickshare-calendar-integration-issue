$clickShareBasePath = "HKCU:\Software\Barco\ClickShare Client"
$calendarIntegrationRegistryName = "CalendarIntegration"

$isClickShareInstalled = Test-Path $clickShareBasePath

if (!$isClickShareInstalled) {
    Write-Host "ClickShare is not installed"
    exit 0
}

function Set-ClickShareCalendarIntegrationToFalse {
    Set-ItemProperty -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -Value false
    try {
        powershell .\FixUserShellFolderPermissions.ps1 -accepteula
    } catch {
        Write-Host "Something went wrong, but we don't really care here"
    }
}

$doesCalendarIntegrationRegistryKeyExist = !!(Get-ItemProperty -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue)

if (!$doesCalendarIntegrationRegistryKeyExist) {
    Set-ClickShareCalendarIntegrationToFalse
    exit 0
}

$isCalendarIntegrationRegistryKeySetToTrue = (Get-ItemPropertyValue -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue) -eq "true"

if ($isCalendarIntegrationRegistryKeySetToTrue) {
    Set-ClickShareCalendarIntegrationToFalse
    exit 0
}