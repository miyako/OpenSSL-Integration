//%attributes = {}
// Method :  signXML - Generates signed XML 

#DECLARE()
var $resFolder : 4D:C1709.Folder
var $pathXMLIN; $pathXMLOUT; $pathCert; $pathKey; $password; $resPath; $cmd : Text
var $sigFile : 4D:C1709.File
var $worker : 4D:C1709.SystemWorker


$resFolder:=Folder:C1567(fk resources folder:K87:11)
$password:="ABC1234"

$resPath:=Convert path system to POSIX:C1106($resFolder.platformPath)

$pathXMLIN:=$resPath+"payment_request.xml"
$pathXMLOUT:=$resPath+"payment_request.xml.p7s"
$pathCert:=$resPath+"certificate.crt"
$pathKey:=$resPath+"private_key.key"

$cmd:="smime -sign -binary -nodetach"
$cmd+=" -in "+Char:C90(34)+$pathXMLIN+Char:C90(34)
$cmd+=" -out "+Char:C90(34)+$pathXMLOUT+Char:C90(34)
$cmd+=" -signer "+Char:C90(34)+$pathCert+Char:C90(34)
$cmd+=" -inkey "+Char:C90(34)+$pathKey+Char:C90(34)
$cmd+=" -passin pass:"+$password
$cmd+=" -outform PEM"

$worker:=Execute_OpenSSL($cmd)


$sigFile:=File:C1566($pathXMLOUT)


If ($sigFile#Null:C1517) && ($worker.terminated)
	ALERT:C41(Replace string(Localized string("Msg_SignedFileCreated"); "{name}"; $sigFile.name))
	Form:C1466.signedXML:=$sigFile.getText()
Else 
	ALERT:C41(Replace string(Localized string("Msg_FileNotFoundOpenSSL"); "{path}"; $pathXMLIN))
End if 