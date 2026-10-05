//%attributes = {}
// Method : certif - Generates PEM, DER, or CRT certificates

#DECLARE($certExt : Text; $days : Integer)

var $resPath : Text
var $keyPath : Text
var $certPath : Text
var $configPath : Text
var $cmd; $privateKeyName; $certName; $ext : Text
var $worker : 4D:C1709.SystemWorker
var bopenCrtFile; bgetCrtInfo; bcopyCert : Object


$privateKeyName:="private_key.key"
$certName:="certificate"
Case of 
	: ($certExt="PEM")
		$ext:=".pem"
	: ($certExt="DER")
		$ext:=".der"
	Else 
		$ext:=".crt"
End case 


If ($days=0)
	$days:=365  // Valid for 1 year
End if 


$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)

$keyPath:=$resPath+$privateKeyName
$certPath:=$resPath+$certName+$ext
$configPath:=$resPath+"openssl_config.cnf"


$cmd:="req -new -x509"
$cmd+=" -key "+Char:C90(34)+$keyPath+Char:C90(34)
$cmd+=" -config "+Char:C90(34)+$configPath+Char:C90(34)
$cmd+=" -out "+Char:C90(34)+$certPath+Char:C90(34)
$cmd+=" -days "+String:C10($days)

If ($ext="der")
	$cmd+=" -outform DER"
End if 

$worker:=Execute_OpenSSL($cmd)

If (File:C1566($certPath).exists & $worker.terminated)
	ALERT:C41(Replace string(Localized string("Msg_SelfSignedCreated"); "{name}"; $certName))
	Form:C1466.certificate:=File:C1566($certPath).getText()
	Form:C1466.certPath:=$certPath
	OBJECT SET ENABLED:C1123(bopenCrtFile; True:C214)
	OBJECT SET ENABLED:C1123(bgetCrtInfo; True:C214)
	OBJECT SET ENABLED:C1123(bcopyCert; True:C214)
	
Else 
	ALERT:C41(Localized string("Msg_CouldNotCreateFile"))
	
End if 
