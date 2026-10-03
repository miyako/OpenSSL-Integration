//%attributes = {}
#DECLARE($command : Text; $timeoutSeconds : Integer)->$worker : 4D:C1709.SystemWorker

var $binPath; $fullCommand : Text
var $startTime : Integer
var $elapsed : Integer

If ($timeoutSeconds=0)
	$timeoutSeconds:=3
End if 

If (Storage:C1525.config#Null:C1517)
	$binPath:=Storage:C1525.config.openSSLPath
End if 

If ($binPath#Null:C1517)
	
	$fullCommand:=Char:C90(34)+$binPath+Char:C90(34)+" "+$command
	Try
		$worker:=4D:C1709.SystemWorker.new($fullCommand)
		
	Catch
		ON ERR CALL:C155("errorHandler"; ek global:K92:2)
	End try
	$startTime:=Milliseconds:C459
	
	Repeat 
		$worker.wait(1)  // Check more frequently
		$elapsed:=(Milliseconds:C459-$startTime)/1000
		
		If ($worker.responseError#"")
			ALERT:C41("OpenSSL Error: "+$worker.responseError)
			$worker.terminate()
			return $worker
		End if 
		
		If ($elapsed>$timeoutSeconds) & (Not:C34($worker.terminated))
			ALERT:C41("OpenSSL command timed out after "+String:C10($timeoutSeconds)+" seconds\n\nCommand: "+$command)
			$worker.terminate()
			return $worker
		End if 
		
	Until ($worker.terminated)
	
Else 
	
	ALERT:C41("OpenSSL not found at: "+$binPath+"\n\nPlease install:\nWindows: winget install openssl\nmacOS: brew install openssl@3")
	return 
End if 



// Final error check
If ($worker.responseError#"")
	ALERT:C41("OpenSSL Error: "+$worker.responseError)
End if 

return $worker