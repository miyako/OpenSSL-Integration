
// ----------------------------------------------------
// User name (OS): Al Mahdi
// Date and time: 02/19/26, 15:26:15
// ----------------------------------------------------
// Method: OpenSSLWorker
// Description
// 
//
// Parameters
// ----------------------------------------------------


property onComplete : 4D:C1709.Function
property timeout : Integer

Class constructor($onComplete : 4D:C1709.Function)
	This:C1470.onComplete:=$onComplete
	This:C1470.timeout:=10
	
Function onResponse($param1 : Object; $param2 : Object)
	// $param1 = SystemWorker
	// $param2.type = "response"
	customLog($param2.type)
	
Function onDataError($param1 : Object; $param2 : Object)
	// $param1 = SystemWorker
	// $param2.type = "error"
	// $param2.data = error data
	
	customLog($param2.data; $param2.type)
	
Function onError($param1 : Object; $param2 : Object)
	// $param1 = SystemWorker
	// $param2.type = "error"
	customLog($param2.type)
	
Function onData($param1 : Object; $param2 : Object)
	// $param1 = SystemWorker
	// $param2.type = "data"
	// $param2.data = received data
	customLog($param2.data; $param2.type)
	//ALERT("Data received: "+$param2.data)
	
Function onTerminate($param1 : Object; $param2 : Object)
	// $param1 = SystemWorker
	// $param2.type = "termination"
	var $isError : Boolean
	
	$isError:=(($param1.responseError#"") | ($param1.exitCode#0))
	
	Case of 
		: ($isError)
			//ALERT("OpenSSL Error: "+$param1.responseError)
			customLog($param1.responseError; "SSL ERROR")
			
		: (This:C1470.onComplete#Null:C1517)
			This:C1470.onComplete.call(Null:C1517; $param1)
			
	End case 