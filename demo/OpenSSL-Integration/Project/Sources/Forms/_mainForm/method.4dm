// Certificate Manager Form Method


var $res : 4D:C1709.Folder
var $cnfFile : 4D:C1709.File
var $cnfPath; $content; $line : Text
var $lines : Collection
var $isOpenSSL : Boolean


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$res:=Folder:C1567(fk resources folder:K87:11)
		
		$cnfPath:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).platformPath)+"openssl_config.cnf"
		$cnfFile:=File:C1566($cnfPath)
		
		If (Not:C34($cnfFile.exists))
			return 
		End if 
		
		$content:=$cnfFile.getText()
		$lines:=Split string:C1554($content; "\n")
		
		For each ($line; $lines)
			$line:=Trim:C1853($line)
			If (Length:C16($line)>0) & (Substring:C12($line; 1; 1)#"#")
				var $parts : Collection
				$parts:=Split string:C1554($line; "=")
				If ($parts.length>=2)
					var $key; $val : Text
					$key:=Lowercase:C14(Trim:C1853($parts[0]))
					$val:=Trim:C1853($parts[1])
					Case of 
						: ($key="commonname_default") | ($key="cn")
							Form:C1466.dnCN:=$val
						: ($key="0.organizationname_default") | ($key="o")
							Form:C1466.dnOrg:=$val
						: ($key="organizationalunitname_default") | ($key="ou")
							Form:C1466.dnOU:=$val
						: ($key="countryname_default") | ($key="c")
							Form:C1466.dnCountry:=$val
						: ($key="stateorprovincename_default") | ($key="st")
							Form:C1466.dnST:=$val
						: ($key="serialnumber_default") | ($key="serialnumber")
							Form:C1466.dnSerial:=$val
					End case 
				End if 
			End if 
		End for each 
		
		
		Form:C1466.CarpetaBase:=$res.platformPath
		
		
		Form:C1466.xmlPath:=$res.file("payment_request.xml").platformPath
		Form:C1466.outputPath:=$res.file("payment_request.xml.p7s").platformPath
		Form:C1466.certPath:=$res.file("certificate.crt").platformPath
		Form:C1466.keyPath:=$res.file("private_key.key").platformPath
		Form:C1466.Password:="ABC1234"
		
		Form:C1466.keyBits:="2048"
		Form:C1466.keyCipher:="none"
		Form:C1466.keyPassphrase:=""
		
		Form:C1466.certFormat:="PEM"
		Form:C1466.certExp:=365
		If (Storage:C1525.config#Null:C1517)
			
			$isOpenSSL:=Storage:C1525.config.openSSLFound
		End if 
		
		Form:C1466.isOpenSSL:=$isOpenSSL
		
		FORM FIRST PAGE:C250
		
		OBJECT SET ENABLED:C1123(bopenKeyFile; False:C215)
		OBJECT SET ENABLED:C1123(bopenCsrFile; False:C215)
		OBJECT SET ENABLED:C1123(bopenCrtFile; False:C215)
		OBJECT SET ENABLED:C1123(bopenPemFile; False:C215)
		OBJECT SET ENABLED:C1123(bgetCrtInfo; False:C215)
		OBJECT SET ENABLED:C1123(bcopyCert; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "tserverUp"; False:C215)
		OBJECT SET VISIBLE:C603(*; "tserverDown"; False:C215)
		
		Form:C1466.currentPage:=FORM Get current page:C276
		Form:C1466.clickCount:=0
		
		Form:C1466.statusText:="Ready - Select a tab to begin"
		
		If (Form:C1466.privateKey=Null:C1517)
			Form:C1466.privateKey:=""
		End if 
		If (Form:C1466.csr=Null:C1517)
			Form:C1466.csr:=""
		End if 
		If (Form:C1466.certificate=Null:C1517)
			Form:C1466.certificate:=""
		End if 
		If (Form:C1466.pem=Null:C1517)
			Form:C1466.pem:=""
		End if 
		
	: (Form event code:C388=On Page Change:K2:54)
		
		Form:C1466.currentPage:=FORM Get current page:C276
		
		
End case 
