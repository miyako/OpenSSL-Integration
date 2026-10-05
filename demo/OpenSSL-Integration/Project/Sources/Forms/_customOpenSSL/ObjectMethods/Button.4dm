// Button "Locate OpenSSL" - Object Method
var $selectedFile : 4D:C1709.File
var $filter : Text
var $title; $fileName : Text
var $worker : 4D:C1709.SystemWorker
var $command; $doc : Text

If (Storage:C1525.config.os="Windows")
	$filter:=".exe"
	$title:=Localized string("Msg_LocateOpenSSLExe")
Else 
	$filter:="*"
	$title:=Localized string("Msg_LocateOpenSSLExecutable")
End if 

$doc:=Select document:C905(System folder:C487(Home folder:K41:19); $filter; $title; Use sheet window:K24:11)

If (OK=1)
	$selectedFile:=File:C1566(Convert path system to POSIX:C1106(Document))
	
	
	If ($selectedFile.exists) & (Position:C15("openssl"; $selectedFile.fullName)>0)
		$command:=Char:C90(34)+$selectedFile.path+Char:C90(34)+" version"
		$worker:=4D:C1709.SystemWorker.new($command)
		$worker.wait(5)
		
		If ($worker#Null:C1517) & ($worker.exitCode=0)
			Use (Storage:C1525.config)
				Storage:C1525.config.openSSLPath:=$selectedFile.path
				Storage:C1525.config.openSSLFound:=True:C214
			End use 
			
			Form:C1466.selectedPath:=$selectedFile.path
			Form:C1466.isOpenSSL:=True:C214
			
			OBJECT SET ENABLED:C1123(bgoToApp; Form:C1466.isOpenSSL)
			
			ALERT:C41(Localized string("Msg_CustomConfigured"))
			
		Else 
			ALERT:C41(Localized string("Msg_InvalidExecutable"))
		End if 
	Else 
		ALERT:C41(Replace string(Localized string("Msg_FileNotFoundAt"); "{path}"; $selectedFile.platformPath))
	End if 
End if 