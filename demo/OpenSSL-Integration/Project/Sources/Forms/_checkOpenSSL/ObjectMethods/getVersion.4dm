// Button Object Method - Get OpenSSL Version (using modified Execute_OpenSSL)

var $worker : 4D:C1709.SystemWorker
var $output : Text
var $version : Text

$worker:=Execute_OpenSSL("version")

If ($worker#Null:C1517) & ($worker.exitCode=0)
	$output:=$worker.response
	customLog("")
	Form:C1466.version:=$output
	Form:C1466.isOpenSSL:=True:C214
	If (Storage:C1525.config#Null:C1517)
		Form:C1466.openSSLPath:=Storage:C1525.config.openSSLPath
	End if 
	
Else 
	Form:C1466.version:="OpenSSL not found or error occurred"
End if 