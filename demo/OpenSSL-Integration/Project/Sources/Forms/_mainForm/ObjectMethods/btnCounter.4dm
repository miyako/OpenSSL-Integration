Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		Form:C1466.clickCount:=Form:C1466.clickCount+1
		//OBJECT SET VALUE(*; "counterDisplay"; String(Form.clickCount))
		//OBJECT SET VALUE(*; "proofClicks"; String(Form.clickCount))
		
		//// ------------------------------------------------
		
		//// ObjectMethods/inputTyping — On Data Change event
		//Form.charCount:=Length(Form.typingText)
		//OBJECT SET VALUE(*; "proofTyped"; String(Form.charCount))
		
End case 