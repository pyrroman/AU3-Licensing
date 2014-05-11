#cs
   License keygen
	  coded by Jefrey S. Santos
		 <jefreysobreira[at]gmail[dot]com>
#ce

;~ Configure here
Global $myPasswd = "abc"

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
 #include <Crypt.au3>
#include <String.au3>

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\Users\Windows\Desktop\cantina\frm\registro.kxf
$Form1_1 = GUICreate("License keygen", 290, 401, 449, 174)
GUISetIcon("C:\Users\Windows\Desktop\cantina\icon.ico", -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "fechar")
$Group1 = GUICtrlCreateGroup(" Machine ID (* = anyone) ", 8, 8, 273, 49)
$usercode = GUICtrlCreateInput("", 16, 24, 257, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup(" Can be used until ", 8, 120, 273, 49)
$register_till = GUICtrlCreateDate(@YEAR & "/" & @MON & "/" & @MDAY, 16, 136, 257, 25, $DTS_UPDOWN)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup(" Valid for ", 8, 64, 273, 49)
$valid_num = GUICtrlCreateInput("", 16, 80, 137, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$valid_unit = GUICtrlCreateCombo("", 160, 80, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Days|Weeks|Months|Years")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup(" Generate ", 8, 176, 273, 161)
$Button1 = GUICtrlCreateButton("Generate", 16, 192, 257, 25)
GUICtrlSetOnEvent(-1, "generate")
$showserial = GUICtrlCreateInput("", 16, 224, 257, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$showinfo = GUICtrlCreateEdit("", 16, 248, 257, 81, BitOR($GUI_SS_DEFAULT_EDIT,$ES_READONLY))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup(" Check serial ", 8, 344, 273, 49)
$tocheck = GUICtrlCreateInput("", 16, 360, 185, 21)
$Button2 = GUICtrlCreateButton("Verify", 208, 360, 65, 25)
GUICtrlSetOnEvent(-1, "checar")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$DTM_SETFORMAT_ = 0x1032 ; $DTM_SETFORMATW
$style = "yyyy/MM/dd"
GUICtrlSendMsg($register_till, $DTM_SETFORMAT_, 0, $style)

While 1
	Sleep(100)
WEnd

Func fechar()
   Exit
EndFunc
Func generate()
   Global $rUsercode = GUICtrlRead($usercode)
   $rRegister_till = GUICtrlRead($register_till)
   $rValid_num = GUICtrlRead($valid_num)
   $rValid_unit = GUICtrlRead($valid_unit)
   $serial = serial($rUsercode, $rRegister_till)
   $info = "Machine ID: " & $rUsercode & @CRLF & _
			"Valid for: " & $rValid_num & " " & StringLower($rValid_unit) & @CRLF & _
			"Serial: " & $serial
   GUICtrlSetData($showserial, $serial)
   GUICtrlSetData($showinfo, $info)
EndFunc

Func validade($num, $unit)
   $unit = StringLower($unit)
   Select
	  Case $unit = "days"
		 $ret = $num
	  Case $unit = "weeks"
		 $ret = $num*7
	  Case $unit = "months"
		 $ret = $num*31
	  Case $unit = "years"
		 $ret = $num*366
   EndSelect
   Return $ret
EndFunc

Func serial($code, $till)
	$fSerial=$code & "\" & $till
	Return _Crypt_EncryptData($fSerial, $code, $CALG_AES_192);8bb2498-84af-4e1b-bcf8-1281fdedf9e
EndFunc

Func checar() ;0xC9AC465CE751DC19F0D59AE4DBF5D4419957943CE9C52B2342A335AC607A8F14DF365376D09A456E25220D8964C626F91BEAB1BD7CC28B416C6C3C53565185BB
	Local $retorno=serialinfo(GUICtrlRead($tocheck))
   If UBound($retorno)<>3 Then
	  MsgBox(0, "Check", "Invalid serial")
   Else
	  MsgBox(0, "Check", "User code: " & $retorno[1] & @CRLF & _
						   "Valid until: " & $retorno[2])
   EndIf
EndFunc

Func serialinfo($serial)
	Global $decrypted=BinaryToString(_Crypt_DecryptData($serial, GUICtrlRead($usercode), $CALG_AES_192))
	MsgBox(32, "", $decrypted)
	$decrypted = StringSplit($decrypted, "\")
	If UBound($decrypted) <> 3 Then Return False
	Dim $retorno[3]
	$retorno[1] = $decrypted[1] ; user id
	$retorno[2] = $decrypted[2] ; days
	Return $retorno
EndFunc

Func validade_decode($val)
   If Mod($val, 366)=0 Then
	  Return Int($val/366) & " years"
   ElseIf Mod($val, 31)=0 Then
	  Return Int($val/31) & " months"
   ElseIf Mod($val, 7)=0 Then
	  Return Int($val/7) & " weeks"
   Else
	  Return $val & " days"
   EndIf
EndFunc