:: This batch file copies common files found in AppData under a Windows 10 user profile, to your flash drive.
:: Edit the two lines below to reflect the drive letter of your flash drive and the user that we are pulling data from.
:: Run as the user, not as admin.
:: Created by Aric Galloso 2/15/2021


Set DriveLetter=E:
Set User=Agalloso

:: DO NOT EDIT ANYTHING BELOW THIS LINE

:: robocopy.exe "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" *.* /e "%DriveLetter%\%User%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" /R:1 /W:1
:: robocopy.exe "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.bak" *.* /e "%DriveLetter%\%User%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.bak" /R:1 /W:1


robocopy.exe "%userprofile%\AppData\Roaming\Microsoft\Signatures" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Microsoft\Signatures" /R:1 /W:1 
robocopy.exe "%userprofile%\AppData\Roaming\Microsoft\Templates" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Microsoft\Templates" /R:1 /W:1
robocopy.exe "%userprofile%\AppData\Roaming\Microsoft\Sticky Notes" *.* /e "%DriveLetter%\%User%\AppData\Microsoft\Sticky Notes" /R:1 /W:1
robocopy.exe "%userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" R:1 /W:1
robocopy.exe "%userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" R:1 /W:1
REG EXPORT "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" "%DriveLetter%\%User%\TaskBar-pinned-items.reg"


:: robocopy.exe "%userprofile%\AppData\Roaming\Adobe\Acrobat\DC\Security" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Adobe\Acrobat\DC\Security" /R:1 /W:1
robocopy.exe "%userprofile%\AppData\Roaming\Adobe\Acrobat" *.* /e "%DriveLetter%\%User%\AppData\Roaming\Adobe\Acrobat" /R:1 /W:1

robocopy.exe "%userprofile%\Appdata\LocalLow\Sun\Java\Deployment\security\exception.sites" *.* /e "%DriveLetter%\%User%\Appdata\LocalLow\Sun\Java\Deployment\security\exception.sites" /R:1 /W:1
robocopy.exe "%userprofile%\Appdata\LocalLow\Sun\Java\Deployment\security\trusted.certs" *.* /e "%DriveLetter%\%User%\Appdata\LocalLow\Sun\Java\Deployment\security\trusted.certs" /R:1 /W:1

:: Logs mapped Drives
net use >>"%DriveLetter%\%user%\Backup_NetUse.txt"

:: Logs printer info
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -l >>"%DriveLetter%\%User%\Backup_PrinterList.txt"

:: Exports users Internet Explorer Trusted Sites
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains" "%DriveLetter%\%User%\Backup_Trusted_Sites.reg"

:: Great catch below, shared by Alan.
reg export "HKCU\Software\Microsoft\Shared Tools\Proofing tools\Custom Dictionaries" "%DriveLetter%\%User%\Custom Dictionaries.reg"


:: Creating a list of programs below, adds significant time.  Consider removing it, if you do not need it.
:: List of installed programs
:: wmic /output:%userprofile%\Programs.csv product get name,version
:: wmic /output:P:\Programs.csv product get name,version
wmic /output:%DriveLetter%\%User%\Programs.csv product get name,version

WMIC OS LIST BRIEF >>"%DriveLetter%\%User%\ComputerInfo.txt"
WMIC BIOS get serialnumber >>"%DriveLetter%\%User%\ComputerInfo.txt"
WMIC OS GET csname >>"%DriveLetter%\%User%\ComputerInfo.txt"
WMIC SERVICE where (state="running") GET caption, name, state >>"%DriveLetter%\%User%\ComputerInfo.txt"
Echo Go to Edit - Preferences - Signatures - Identities & Trusted Certificates, select your signature profiles and then click on Export.Save them to a data file. 
Echo DONT FORGET to backup Chrome, FireFox, and Edge bookmarks up manually.
pause
