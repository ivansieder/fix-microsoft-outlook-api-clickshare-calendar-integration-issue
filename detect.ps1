$clickShareBasePath = "HKCU:\Software\Barco\ClickShare Client";
$calendarIntegrationRegistryName = "CalendarIntegration";

$isClickShareInstalled = Test-Path $clickShareBasePath;

if (!$isClickShareInstalled) {
    Write-Host "ClickShare is not installed";
    Exit 0;
}

$doesCalendarIntegrationRegistryKeyExist = !!(Get-ItemProperty -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue);

if (!$doesCalendarIntegrationRegistryKeyExist) {
    Write-Host "ClickShare CalendarIntegration registry key does not exist";
    Exit 1603;
}

$isCalendarIntegrationRegistryKeySetToTrue = (Get-ItemPropertyValue -Path $clickShareBasePath -Name $calendarIntegrationRegistryName -ErrorAction SilentlyContinue) -eq "true"

if ($isCalendarIntegrationRegistryKeySetToTrue) {
    Write-Host "ClickShare CalendarIntegration registry key is set to true instead of false";
    Exit 1603;
}