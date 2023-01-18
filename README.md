An Intune package to fix some issues related to M365-Apps along with ClickShare (with calendar integration enabled), see https://www.borncity.com/blog/2023/01/18/windows-10-taskleiste-und-office-anwendungen-streiken-18-jan-2023/

If it detects that the calendar integration of Barco's ClickShare is enabled, this script does two things:
- disable the calendar integration through a registry key
- run Barco's script to fix the unresponsive taskbar (https://www.barco.com/en/support/knowledge-base/6077-unresponsive-windows-taskbar-with-clickshare-app)

Usage:
- grab the `fix-microsoft-outlook-api-clickshare-calendar-integration-issue.intunewin` file and deploy it as Win32-App in Intune