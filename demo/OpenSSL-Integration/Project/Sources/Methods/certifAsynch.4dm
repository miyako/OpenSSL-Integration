//%attributes = {}
// Method : certifAsynch - Generates asynchronously PEM, DER, or CRT certificates
#DECLARE($privateKeyName : Text; $certName : Text; $days : Integer)

If ($privateKeyName="")
	$privateKeyName:="private_key.key"
End if 

If ($certName="")
	$certName:="certificate.crt"
End if 

If ($days=0)
	$days:=365  // Valid for 1 year
End if 

var $resPath : Text
var $keyPath : Text
var $certPath : Text
var $configPath : Text
var $cmd : Text

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)
$keyPath:=$resPath+$privateKeyName
$certPath:=$resPath+$certName
$configPath:=$resPath+"openssl_config.cnf"

$cmd:="req -new -x509"
$cmd+=" -key "+Char:C90(34)+$keyPath+Char:C90(34)
$cmd+=" -config "+Char:C90(34)+$configPath+Char:C90(34)
$cmd+=" -out "+Char:C90(34)+$certPath+Char:C90(34)
$cmd+=" -days "+String:C10($days)

Execute_OpenSSLAsynch($cmd; Formula:C1597(onFileGenerated($certPath)))