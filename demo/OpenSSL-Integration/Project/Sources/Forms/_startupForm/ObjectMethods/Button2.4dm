var $windowRef : Integer
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		Case of 
			: (Is Windows:C1573)
				$windowRef:=Open form window:C675("_installWin"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
				DIALOG:C40("_installWin")
			: (Is macOS:C1572)
				$windowRef:=Open form window:C675("_installMac"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
				DIALOG:C40("_installMac")
				
		End case 
		
End case 

