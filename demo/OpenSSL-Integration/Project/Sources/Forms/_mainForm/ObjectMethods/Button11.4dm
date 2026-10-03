var $resFolder : 4D:C1709.Folder
var $certSource : 4D:C1709.File
var $keySource : 4D:C1709.File
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$resFolder:=Folder:C1567(fk database folder:K87:14)
		
		
		$certSource:=$resFolder.file("cert.pem")
		$keySource:=$resFolder.file("key.pem")
		
		If ($certSource.exists) & ($keySource.exists)
			web
			
		Else 
			ALERT:C41("Missing certificate and/or private key. Did you copy the files in step 1?")
			
		End if 
End case 