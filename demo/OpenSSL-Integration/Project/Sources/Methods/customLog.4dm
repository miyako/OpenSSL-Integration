//%attributes = {}
// Method :  customLog - Logs app info and stores log file in /Data/Logs/app.log

#DECLARE($message : Text; $level : Text)

If (Process info:C1843(Current process:C322).type#Worker process:K36:32)
	CALL WORKER:C1389("Logger"; Current method name:C684; $message; $level)
	return 
End if 

// Now in worker
If ($level="")
	$level:="INFO"
End if 

var $logFolder : 4D:C1709.Folder
var $logFile : 4D:C1709.File
var $timestamp : Text
var $logEntry : Text
var $existingContent : Text

$logFolder:=Folder:C1567(fk logs folder:K87:17)
$logFile:=$logFolder.file("app.log")

$timestamp:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
$logEntry:="["+$timestamp+"] ["+$level+"] "+$message+Char:C90(Carriage return:K15:38)

If ($logFile.exists)
	$existingContent:=$logFile.getText()
	$logFile.setText($existingContent+$logEntry)
Else 
	$logFile.setText($logEntry)
End if 