var $textToCopy : Text

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$textToCopy:=Form:C1466.Text2
		SET TEXT TO PASTEBOARD:C523($textToCopy)
		ALERT:C41("Copied to pasteboard")
		
		
End case 