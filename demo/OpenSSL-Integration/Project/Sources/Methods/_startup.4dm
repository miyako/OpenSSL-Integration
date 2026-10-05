//%attributes = {}
#DECLARE($OK : Integer)
If (Count parameters:C259=0)
	BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; "Demo"; 1; *))
Else 
	
	// On Startup Method
	var $isWindows; $isMacOS; $isSilicon; $isArm : Boolean
	var $systemInfo : Object
	var $windowRef : Integer
	var $openSSLPath : Text
	var $openSSLFile : 4D:C1709.File
	var $os : Text
	var $openSSLFound : Boolean
	
	// Get system information
	$systemInfo:=System info:C1571
	
	// Check platform
	$isWindows:=Is Windows:C1573
	$isMacOS:=Is macOS:C1572
	
	If ($isMacOS)
		$isSilicon:=Not:C34($systemInfo.macRosetta)
	Else 
		var $processor : Text
		$processor:=System info:C1571.processor
		$isArm:=["apple"; "snapdragon"; "qualcomm"; "oryon"; "sq"; "ampere"; "altra"; "neoverse"; "graviton"; "cobalt"; "cortex"; "arm"].some(Formula:C1597($2=("@"+$1.value+"@")); $processor)
	End if 
	
	// Determine OS
	Case of 
		: ($isWindows)
			$os:="Windows"
		: ($isMacOS & $isSilicon)
			$os:="macOS Silicon"
		: ($isMacOS & Not:C34($isSilicon))
			$os:="macOS Intel"
		Else 
			$os:="Unknown"
	End case 
	
	Case of 
		: ($isWindows)
			If ($isArm)
				$openSSLPath:="C:\\Program Files\\OpenSSL-Win64-ARM\\bin\\openssl.exe"
			Else 
				$openSSLPath:="C:\\Program Files\\OpenSSL-Win64\\bin\\openssl.exe"
			End if 
			$openSSLFile:=File:C1566($openSSLPath; fk platform path:K87:2)
			
		: ($isMacOS & $isSilicon)
			$openSSLPath:="/opt/homebrew/opt/openssl@3.5/bin/openssl"
			$openSSLFile:=File:C1566($openSSLPath)
			
		: ($isMacOS & Not:C34($isSilicon))
			$openSSLPath:="/usr/local/opt/openssl@3.5/bin/openssl"
			$openSSLFile:=File:C1566($openSSLPath)
			
	End case 
	
	$openSSLFound:=$openSSLFile.exists
	
	Use (Storage:C1525)
		If (Storage:C1525.config=Null:C1517)
			Storage:C1525.config:=New shared object:C1526()
		End if 
		
		Use (Storage:C1525.config)
			// Store OS
			Storage:C1525.config.os:=$os
			Storage:C1525.config.arch:="x86_64"
			If ($isSilicon) || ($isArm)
				Storage:C1525.config.arch:="arm64"
			End if 
			
			// Store OpenSSL information
			Storage:C1525.config.openSSLFound:=$openSSLFound
			If ($openSSLFound)
				Storage:C1525.config.openSSLPath:=$openSSLFile.path
			Else 
				Storage:C1525.config.openSSLPath:=""
			End if 
		End use 
	End use 
	
	$windowRef:=Open form window:C675("_startupForm"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("_startupForm")
	CLOSE WINDOW:C154($windowRef)
	
End if 