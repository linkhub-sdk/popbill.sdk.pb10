$PBExportHeader$faxservice.sru
forward
global type faxservice from baseservice
end type
end forward

global type faxservice from baseservice
end type
global faxservice faxservice

forward prototypes
public function decimal getunitcost (string corpnum) throws popbillexception
public function string geturl (string corpnum, string userid, string togo) throws popbillexception
public function response cancelreserve (string corpnum, string receiptnum, string userid) throws popbillexception
public function string sendfax (string corpnum, string sendnum, faxreceiver receivers[], string filepaths[], string reservedt, string userid) throws popbillexception
public function string sendfax (string corpnum, string sendnum, string receivenum, string receivename, string filepaths[], string reservedt, string userid) throws popbillexception
public function string sendfax (string corpnum, string sendnum, string receivenum, string receivename, string filepath, string reservedt, string userid) throws popbillexception
public function string sendfax (string corpnum, string sendnum, faxreceiver receivers[], string filepath, string reservedt, string userid) throws popbillexception
public subroutine getfaxresult (string corpnum, string receiptnum, ref faxresult ref_result[]) throws popbillexception
end prototypes

public function decimal getunitcost (string corpnum) throws popbillexception;decimal unitcost
oleObject result

result = httpget("/FAX/UnitCost" , CorpNum,"")
unitcost = dec(result.Item("unitCost"))
result.DisconnectObject()
destroy result

return unitcost
end function

public function string geturl (string corpnum, string userid, string togo) throws popbillexception;string url
oleObject result

result = httpget("/FAX/?TG=" + togo , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function response cancelreserve (string corpnum, string receiptnum, string userid) throws popbillexception;response result
oleobject dic
string postData

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(receiptnum) or receiptnum = "" then throw exception.setCodeNMessage(-99999999,"접수번호가 입력되지 않았습니다.")

dic = httpget("/FAX/" + receiptNum + "/Cancel" ,corpnum,userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function string sendfax (string corpnum, string sendnum, faxreceiver receivers[], string filepaths[], string reservedt, string userid) throws popbillexception;oleobject dic
string receiptNum,postData

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(receivers) or upperbound(receivers) <= 0 then throw exception.setcodenMessage(-99999999,"수신자 정보가 입력되지 않았습니다.")
if isnull(filepaths) or upperbound(filepaths) <= 0 then throw exception.setcodenMessage(-99999999,"전송파일 경로가 입력되지 않았습니다.")
if upperbound(filepaths)  > 5 then throw exception.setcodenMessage(-99999999,"동시 전송파일은 최대 5개입니다.")

postData = '{'

if (isnull(sendnum) or sendnum = "") = false then postData += '"snd":"' + escapestring(sendnum) + '",'
if (isnull(reservedt) or reservedt = "") = false then postData += '"sndDT":"' + escapestring(reservedt) + '",'

postData += '"fCnt":"' + string(upperbound(filepaths)) + '",'

postData += '"rcvs":['
integer i

for i = 1 to upperbound(receivers)
	postData += '{"rcv":"' + escapestring(receivers[i].receivenum) + '",' + &
					'"rcvnm":"' + escapestring(receivers[i].receivename) + '"}'
				
	if i < upperbound(receivers) then postData += ","
next

postData += ']'

postData += '}'

dic = httppostfiles("/FAX" ,corpnum,postData,filepaths,"file", userid)
receiptNum = dic.Item("receiptNum")
dic.DisconnectObject()
destroy dic

return receiptNum
end function

public function string sendfax (string corpnum, string sendnum, string receivenum, string receivename, string filepaths[], string reservedt, string userid) throws popbillexception;faxreceiver l_receivers[]

l_receivers[1].receivenum = receivenum
l_receivers[1].receivename = receivename

return sendfax(corpnum,sendnum,l_receivers,filepaths,reservedt,userid)
end function

public function string sendfax (string corpnum, string sendnum, string receivenum, string receivename, string filepath, string reservedt, string userid) throws popbillexception;return sendfax(corpnum,sendnum,receivenum,receivename,{filepath},reservedt,userid)
end function

public function string sendfax (string corpnum, string sendnum, faxreceiver receivers[], string filepath, string reservedt, string userid) throws popbillexception;return sendfax(corpnum,sendnum,receivers,{filepath},reservedt,userid)
end function

public subroutine getfaxresult (string corpnum, string receiptnum, ref faxresult ref_result[]) throws popbillexception;any dicList[]
integer i
oleobject log

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(receiptNum) or receiptNum = "" then throw exception.setCodeNMessage(-99999999,"접수번호가 입력되지 않았습니다.")

dicList = httpget("/FAX/" + receiptNum ,corpnum,"")

for i = 1 to upperbound(dicList)
	log = dicList[i]
	
	ref_result[i].sendstate = log.item("sendState")
	ref_result[i].convstate = log.item("convState")
	ref_result[i].sendNum = string(log.item("sendNum"))
	ref_result[i].receiveNum = string(log.item("receiveNum"))
	ref_result[i].receiveName = string(log.item("receiveName"))

	ref_result[i].sendPageCnt = integer(log.item("sendPageCnt"))
	ref_result[i].successPageCnt = integer( log.item("successPageCnt"))
	ref_result[i].failPageCnt = integer(log.item("failPageCnt"))
	ref_result[i].refundPageCnt = integer(log.item("refundPageCnt"))
	ref_result[i].cancelPageCnt =integer( log.item("cancelPageCnt"))
	
	ref_result[i].reserveDT = string(log.item("reserveDT"))
	ref_result[i].sendDT = string(log.item("sendDT"))
	ref_result[i].resultDT = string(log.item("resultDT"))
	ref_result[i].sendResult = integer(log.item("sendResult"))

	log.DisconnectObject()
	destroy log
	
next


end subroutine

on faxservice.create
call super::create
end on

on faxservice.destroy
call super::destroy
end on

event constructor;call super::constructor;addscope("160")
end event

