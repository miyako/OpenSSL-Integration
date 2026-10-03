//%attributes = {}
// Method :  handles error, and logs them

var lastErrors : Collection


lastErrors:=Last errors:C1799
customLog(lastErrors[0].message; "4D ERROR")
ALERT:C41("4D ERROR"+lastErrors[0].message)

