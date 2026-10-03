//%attributes = {}
// Method :  onFileGenerated - Call back on file generated, reveals the file in Finder 

#DECLARE($filePath : Text)

var $file : 4D:C1709.File
$file:=File:C1566($filePath)
If ($file.exists)
	//ALERT("File created"+"- Extension: "+$file.extension+" - Showing On Disk")
	SHOW ON DISK:C922($file.platformPath)
End if 

