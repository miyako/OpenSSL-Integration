//%attributes = {}
// Method :  web - Launches 4D Web  - HTTPS with generated certificates

#DECLARE()->$success : Boolean

var $webServer : 4D:C1709.WebServer
var $settings : Object
var $status : Object
var $httpCode : Integer
var $response : Text

$success:=False:C215

$webServer:=WEB Server:C1674

$webServer.stop()

$settings:=New object:C1471
$settings.HTTPEnabled:=True:C214
$settings.HTTPPort:=80
$settings.HTTPSEnabled:=True:C214
$settings.HTTPSPort:=443

Try
	$status:=$webServer.start($settings)
	DELAY PROCESS:C323(Current process:C322; 120)
	$httpCode:=HTTP Get:C1157("https://127.0.0.1/"; $response)
	
Catch
	
	ON ERR CALL:C155("errorHandler"; ek global:K92:2)
End try


If ($httpCode=200)
	$success:=True:C214
	ALERT:C41(Localized string("Msg_HTTPSActive"))
	
	OBJECT SET VISIBLE:C603(*; "tserverUp"; True:C214)
	OBJECT SET VISIBLE:C603(*; "tserverDown"; False:C215)
	
	
Else 
	ALERT:C41(Replace string(Localized string("Msg_FailedCode"); "{code}"; String:C10($httpCode)))
	OBJECT SET VISIBLE:C603(*; "tserverDown"; True:C214)
	
	OBJECT SET VISIBLE:C603(*; "tserverUp"; False:C215)
End if 

return $success