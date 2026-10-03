//%attributes = {}
// Method :  openFile - Opens file sent as argument

#DECLARE($filePath : Text)

var $file : 4D:C1709.File
$file:=File:C1566($filePath)

If ($file.exists)
	// Use platform path for SHOW ON DISK
	//ALERT("File created"+"- Extension: "+$file.extension+" - Showing On Disk")
	SHOW ON DISK:C922($file.platformPath)
End if 