//%attributes = {}
// Method :  key - Generates private key asynchronously given its bitness and file name

#DECLARE($privateKeyName : Text)

If ($privateKeyName="")
	$privateKeyName:="private_key_8192.key"
End if 

var $resPath : Text
var $keyPath : Text
var $cmd : Text
var $windowRef : Integer

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)
$keyPath:=$resPath+$privateKeyName
$cmd:="genrsa -out "+Char:C90(34)+$keyPath+Char:C90(34)+" 8192"

// Capture window reference
$windowRef:=Current form window:C827

// Execute async - pass window reference
Execute_OpenSSLAsynch($cmd; Formula:C1597(onFileGenerated($keyPath)))