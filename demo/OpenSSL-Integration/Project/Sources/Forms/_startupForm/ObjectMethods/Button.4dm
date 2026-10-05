var $windowRef : Integer

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$windowRef:=Open form window:C675("_customOpenSSL"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("_customOpenSSL"; *)
End case 