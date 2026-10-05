//%attributes = {}
#DECLARE($params : Object)

var $splashWindowTitle : Text
var $windowRef : Integer
$splashWindowTitle:=Localized string("Startup_WindowTitle")

If (Count parameters:C259=0)
	
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	
	var $i : Integer
	For ($i; 1; Size of array($windows))
		$windowRef:=$windows{$i}
		If (Window process($windowRef)=1) && (Get window title($windowRef)=$splashWindowTitle)
			var $x; $y; $bottom; $right : Integer
			GET WINDOW RECT($x; $y; $bottom; $right; $windowRef)
			CALL FORM($windowRef; Formula(SET WINDOW RECT($x; $y; $bottom; $right; $windowRef)))
			return 
		End if 
	End for 
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	// On Startup Method
	var $isWindows; $isMacOS; $isSilicon; $isArm : Boolean
	var $systemInfo : Object
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
	
	SET MENU BAR(1)
	
	$windowRef:=Open form window:C675("_startupForm"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE($splashWindowTitle; $windowRef)
	DIALOG:C40("_startupForm"; *)
	
End if 