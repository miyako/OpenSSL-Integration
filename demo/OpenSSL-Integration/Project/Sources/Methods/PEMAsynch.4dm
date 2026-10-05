//%attributes = {}
// Method :  PEM - Generates  PEM  certificate asynchronously
var $resPath : Text
var $keyPath : Text
var $csrPath : Text
var $certPath : Text
var $cmd : Text

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
	
	Execute_OpenSSLAsynch($cmd; Formula:C1597(onFileGenerated($certPath)))
	
Else 
	ALERT:C41(Localized string("Msg_MissingFiles"))
End if 