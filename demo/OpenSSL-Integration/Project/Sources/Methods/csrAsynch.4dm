//%attributes = {}
// Method :  csrAsynch - Generates asynchronously CSR given a config file

#DECLARE($privateKeyName : Text; $csrName : Text)

If ($privateKeyName="")
	$privateKeyName:="private_key.key"
End if 

If ($csrName="")
	$csrName:="certificate.csr"
End if 

var $resPath; $keyPath; $configPath; $outPath; $cmd : Text

$resPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)
$keyPath:=$resPath+$privateKeyName
$configPath:=$resPath+"openssl_config.cnf"
$outPath:=$resPath+$csrName

$cmd:="req -new"
$cmd+=" -key "+Char:C90(34)+$keyPath+Char:C90(34)
$cmd+=" -config "+Char:C90(34)+$configPath+Char:C90(34)
$cmd+=" -out "+Char:C90(34)+$outPath+Char:C90(34)

Execute_OpenSSLAsynch($cmd; Formula:C1597(onFileGenerated($outPath)))