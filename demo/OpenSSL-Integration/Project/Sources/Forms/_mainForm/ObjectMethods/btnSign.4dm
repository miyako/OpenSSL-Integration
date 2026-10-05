var $resFolder : 4D:C1709.Folder
var $certSource : 4D:C1709.File
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		signXML
		$resFolder:=Folder:C1567(fk resources folder:K87:11)
		
		$certSource:=$resFolder.file("certificate.crt")
		
		If ($certSource.exists)
			
			
		Else 
			
			ALERT:C41(Localized string("Msg_DidYouGenerateCRT"))
			
		End if 
End case 