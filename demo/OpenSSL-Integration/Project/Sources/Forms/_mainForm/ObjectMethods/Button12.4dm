
var $webServer : 4D:C1709.WebServer

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		$webServer:=WEB Server:C1674
		
		$webServer.stop()
		
		If (Not:C34($webServer.isRunning))
			ALERT:C41("Web Server Stopped")
			OBJECT SET VISIBLE:C603(*; "tserverDown"; True:C214)
			
			OBJECT SET VISIBLE:C603(*; "tserverUp"; False:C215)
		End if 
		
End case 