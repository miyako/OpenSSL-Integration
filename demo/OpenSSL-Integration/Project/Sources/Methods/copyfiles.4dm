//%attributes = {}

// Method : copyfiles- Copies private key and certificate for launching 4D Web Server
#DECLARE()->$success : Boolean

var $resFolder : 4D:C1709.Folder
var $dbFolder : 4D:C1709.Folder
var $certSource : 4D:C1709.File
var $keySource : 4D:C1709.File
var $certDest : 4D:C1709.File
var $keyDest : 4D:C1709.File

$success:=False:C215

$resFolder:=Folder:C1567(fk resources folder:K87:11)
$dbFolder:=Folder:C1567(fk database folder:K87:14)

$certSource:=$resFolder.file("certificate.pem")
$keySource:=$resFolder.file("private_key.key")

If ($certSource.exists) & ($keySource.exists)
	
	$certDest:=$certSource.copyTo($dbFolder; "cert.pem"; fk overwrite:K87:5)
	
	$keyDest:=$keySource.copyTo($dbFolder; "key.pem"; fk overwrite:K87:5)
	
	If ($certDest.exists) & ($keyDest.exists)
		$success:=True:C214
		ALERT:C41(" SSL files copied to database folder!"+Char:C90(Carriage return:K15:38)+\
			Char:C90(Carriage return:K15:38)+\
			"Files copied:"+Char:C90(Carriage return:K15:38)+\
			"- cert.pem"+Char:C90(Carriage return:K15:38)+\
			"- private_key.key"+Char:C90(Carriage return:K15:38)+\
			Char:C90(Carriage return:K15:38)+\
			"Location:"+Char:C90(Carriage return:K15:38)+\
			$dbFolder.platformPath)
	End if 
	
Else 
	ALERT:C41("Please generate a private key and/or PEM certificate")
End if 


return $success