#cs ----------------------------------------------------------------------------

 Author:         Jefrey S. Santos

 Script Function:
	Example 2: If the license is expired, it just won't run. Else, it will. Useful if your application calls an external executable.

#ce ----------------------------------------------------------------------------

#include "license.au3"
setlicenseinfo("Example app", "myemail@mailinator.com") ; set your configs
setinfo(False) ; do not show "you have 10 days left" when the license is gonna expire
If Not license_registered() Then Exit

;~ Your application code here
MsgBox(0, "License is valid", "Hello, world!")