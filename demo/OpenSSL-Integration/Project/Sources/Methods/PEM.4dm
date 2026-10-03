//%attributes = {}
// Method :  PEM - Generates PEM certificate

var $resPath; $keyPath; $csrPath; $certPath; $cmd : Text
var $worker : 4D:C1709.SystemWorker
var bopenPemFile : Object

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)

$keyPath:=$resPath+"private_key.key"
$csrPath:=$resPath+"certificate.csr"
$certPath:=$resPath+"cert.pem"

If (File:C1566($csrPath).exists) & (File:C1566($keyPath).exists)
	
	If (File:C1566($certPath).exists)
		File:C1566($certPath).delete()
	End if 
	
	$cmd:="x509 -in "+Char:C90(34)+$csrPath+Char:C90(34)+\
		" -out "+Char:C90(34)+$certPath+Char:C90(34)+\
		" -req -signkey "+Char:C90(34)+$keyPath+Char:C90(34)+\
		" -days 365"
	
	$worker:=Execute_OpenSSL($cmd)
	
	If (File:C1566($certPath).exists & $worker.terminated)
		ALERT:C41("Success! Certificate created.")
		Form:C1466.pem:=File:C1566($certPath).getText()
		Form:C1466.pemPath:=$certPath
		OBJECT SET ENABLED:C1123(bopenPemFile; True:C214)
		
		
	Else 
		ALERT:C41("Error: Certificate not generated")
	End if 
	
Else 
	ALERT:C41("Missing required files!"+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
		"You need:"+Char:C90(Carriage return:K15:38)+\
		"1. Private key: private_key.key"+Char:C90(Carriage return:K15:38)+\
		"2. CSR: certificate.csr")
End if 