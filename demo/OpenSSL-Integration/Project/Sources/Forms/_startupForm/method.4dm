var $binPath; $os : Text
var $isOpenSSL : Boolean
var binstallOpenSSL; bcustomOpenSSL : Object
Case of 
	: (Form event code:C388=On Load:K2:1)  // Read from Storage
		If (Storage:C1525.config#Null:C1517)
			$binPath:=Storage:C1525.config.openSSLPath
			$os:=Storage:C1525.config.os
			$isOpenSSL:=Storage:C1525.config.openSSLFound
			
		Else 
			$binPath:=""
		End if 
		
		Form:C1466.openSSLPath:=$binPath
		Form:C1466.platform:=$os
		Form:C1466.isOpenSSL:=$isOpenSSL
		
		OBJECT SET VISIBLE:C603(bgoToApp; $isOpenSSL)
		
End case 

