//%attributes = {}
// Method :  key - Generates private key given its bitness and file name

#DECLARE($keyBits : Text; $fileName : Text)

var $worker : 4D:C1709.SystemWorker
var $cmd; $privateKeyName; $keyPath; $resPath : Text
var bopenKeyFile : Object

If ($fileName="")
	$privateKeyName:="private_key.key"
Else 
	$privateKeyName:=$fileName+".key"
End if 


$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)

$keyPath:=$resPath+$privateKeyName


$cmd:="genrsa -out "+Char:C90(34)+$keyPath+Char:C90(34)+" "+$keyBits


$worker:=Execute_OpenSSL($cmd)


If (File:C1566($keyPath).exists & $worker.terminated)
	ALERT:C41(Localized string("Msg_KeyCreated"))
	Form:C1466.privateKey:=File:C1566($keyPath).getText()
	Form:C1466.keyPath:=$keyPath
	OBJECT SET ENABLED:C1123(bopenKeyFile; True:C214)
Else 
	ALERT:C41(Localized string("Msg_CouldNotCreateFile"))
	
End if 