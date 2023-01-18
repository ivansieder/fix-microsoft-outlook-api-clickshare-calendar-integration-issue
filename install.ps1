$clickShareBasePath = "HKCU:\Software\Barco\ClickShare Client";
$calendarIntegrationRegistryName = "CalendarIntegration";

$isClickShareInstalled = Test-Path $clickShareBasePath;

if (!$isClickShareInstalled) {
    Write-Host "ClickShare is not installed";
    Exit 0;
}

function Set-ClickShareCalendarIntegrationToFalse {
    Set-ItemProperty -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -Value false;
    powershell .\FixUserShellFolderPermissions.ps1 -accepteula
}

$doesCalendarIntegrationRegistryKeyExist = !!(Get-ItemProperty -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue);

if (!$doesCalendarIntegrationRegistryKeyExist) {
    Set-ClickShareCalendarIntegrationToFalse
    Exit 0;
}

$isCalendarIntegrationRegistryKeySetToTrue = (Get-ItemPropertyValue -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue) -eq "true"

if ($isCalendarIntegrationRegistryKeySetToTrue) {
    Set-ClickShareCalendarIntegrationToFalse
    Exit 0;
}