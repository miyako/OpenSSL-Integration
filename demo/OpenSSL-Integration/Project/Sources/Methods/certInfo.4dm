//%attributes = {}
// Method : certInfo - Obtains text-based certificate given a file
#DECLARE($certExt : Text)
var $resPath : Text
var $certPath : Text
var $cmd : Text
var $certName; $ext : Text
var $worker : 4D:C1709.SystemWorker

$certName:="certificate"

Case of 
	: ($certExt="PEM")
		$ext:=".pem"
	: ($certExt="DER")
		$ext:=".der"
	Else 
		$ext:=".crt"
End case 

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)
$certPath:=$resPath+$certName+$ext

$cmd:="x509 -in "+Char:C90(34)+$certPath+Char:C90(34)

If ($ext=".der")
	$cmd+=" -inform DER"
End if 

$cmd+=" -text -noout"

$worker:=Execute_OpenSSL($cmd)

If ($worker.terminated)
	
	ALERT:C41($worker.response)
	
Else 
	ALERT:C41(Localized string("Msg_CouldNotGetInfo"))
End if 