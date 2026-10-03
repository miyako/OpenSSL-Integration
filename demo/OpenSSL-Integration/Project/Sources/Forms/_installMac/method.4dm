
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.Text:="/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
		Form:C1466.Text1:="brew install openssl"
		Form:C1466.Text2:="openssl version"
		
End case 