//%attributes = {}
// Method :  csr - Generates CSR given a config file

#DECLARE($privateKeyName : Text; $csrName : Text)

var $worker : 4D:C1709.SystemWorker

If ($privateKeyName="")
	$privateKeyName:="private_key.key"
End if 
If ($csrName="")
	$csrName:="certificate.csr"
End if 

var $resPath : Text
var $keyPath : Text
var $configPath : Text
var $outPath : Text
var $cmd : Text
var bopenCsrFile : Object

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)

$keyPath:=$resPath+$privateKeyName
$configPath:=$resPath+"openssl_config.cnf"
$outPath:=$resPath+$csrName

$cmd:="req -new"
$cmd+=" -key "+Char:C90(34)+$keyPath+Char:C90(34)
$cmd+=" -config "+Char:C90(34)+$configPath+Char:C90(34)
$cmd+=" -out "+Char:C90(34)+$outPath+Char:C90(34)

$worker:=Execute_OpenSSL($cmd)

If (File:C1566($outPath).exists & $worker.terminated)
	ALERT:C41(Localized string("Msg_CSRCreated"))
	Form:C1466.csr:=File:C1566($outPath).getText()
	Form:C1466.csrPath:=$outPath
	OBJECT SET ENABLED:C1123(bopenCsrFile; True:C214)
Else 
	ALERT:C41(Localized string("Msg_CouldNotCreateFile"))
	
End if 