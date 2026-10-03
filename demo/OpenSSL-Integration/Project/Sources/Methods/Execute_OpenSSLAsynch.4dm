//%attributes = {}
#DECLARE($command : Text; $onComplete : 4D:C1709.Function)->$worker : 4D:C1709.SystemWorker
var $binPath; $fullCommand : Text
var $callbacks : cs:C1710.OpenSSLWorker

If (Process info:C1843(Current process:C322).type#Worker process:K36:32)
	CALL WORKER:C1389("OpenSSL_Worker"; Current method name:C684; $command; $onComplete)
	return 
End if 

If (Storage:C1525.config#Null:C1517)
	$binPath:=Storage:C1525.config.openSSLPath
End if 

If (Not:C34(File:C1566($binPath).exists))
	ALERT:C41("OpenSSL not found at: "+$binPath+"\n\nPlease install:\nWindows: winget install openssl\nmacOS: brew install openssl@3")
	return 
End if 

$fullCommand:=Char:C90(34)+$binPath+Char:C90(34)+" "+$command

$callbacks:=cs:C1710.OpenSSLWorker.new($onComplete)
$worker:=4D:C1709.SystemWorker.new($fullCommand; $callbacks)

return $worker