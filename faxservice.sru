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
public function faxsearchresult search (string corpnum, string sdate, string edate, string state[], boolean reserveyn, boolean senderonly, string order, int page, int perpage) throws popbillexception
public function faxsearchresult tofaxsearchresult (ref oleobject dic)
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
integer i, j 
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
	
	ref_result[i].receiptDT= string( log.item("receiptDT"))
	ref_result[i].reserveDT = string(log.item("reserveDT"))
	ref_result[i].sendDT = string(log.item("sendDT"))
	ref_result[i].resultDT = string(log.item("resultDT"))
	ref_result[i].sendResult = string(log.item("sendResult"))
	
	string fileNames[]
	fileNames= log.item("fileNames")

	for j = 1 to upperbound(fileNames)
		ref_result[i].fileNames[j]= string(fileNames[j])
	next
	
	log.DisconnectObject()
	destroy log
	
next


end subroutine

public function faxsearchresult search (string corpnum, string sdate, string edate, string state[], boolean reserveyn, boolean senderonly, string order, int page, int perpage) throws popbillexception;

oleobject dic
string uri, tmpstr
int i
faxsearchresult result

uri = "/FAX/Search"
uri += "?SDate=" + sdate
uri += "&EDate=" + edate

tmpstr = ""
for i = 1 to upperbound(state)
	tmpstr += state[i] 
	if i < upperbound(state) then tmpstr+= ','
next
uri += "&State=" + tmpstr

if not isnull(reserveyn) then
	if reserveyn then uri += "&ReserveYN=1"
	if not(reserveyn) then uri += "&ReserveYN=0"
end if

if not isnull(senderonly) then
	if senderonly then uri += "&SenderOnly=1"
	if not(senderonly) then uri += "&SenderOnly=0"
end if

uri += "&Page=" + string(page)
uri += "&PerPage=" + string(perPage)

dic = httpget(uri,corpnum,"")

result = tofaxsearchresult(dic)
oleobject toDestory[]
toDestory = dic.Item("list")
for i = 1 to upperbound(toDestory)
	toDestory[i].DisconnectObject()
	destroy toDestory[i]
next
dic.DisconnectObject()
destroy dic

return result
end function

public function faxsearchresult tofaxsearchresult (ref oleobject dic);
faxsearchresult result
oleobject log

result.code = string(dic.Item("code"))
result.message = string(dic.Item("message"))
result.total = string(dic.Item("total"))
result.perPage = string(dic.Item("perPage"))
result.pageNum = string(dic.Item("pageNum"))
result.pageCount = string(dic.Item("pageCount"))

Integer i, j
oleobject list[]
list = dic.Item("list")

for i = 1 to upperbound(list)
	log = list[i]
	result.list[i].sendState = log.item("sendState")
	result.list[i].convState = log.item("convState")
	result.list[i].sendNum = string(log.item("sendNum"))
	result.list[i].receiveNum = string(log.item("receiveNum"))
	result.list[i].receiveName = string(log.item("receiveName"))
	result.list[i].sendPageCnt = integer(log.item("sendPageCnt"))
	result.list[i].successPageCnt = integer(log.item("successPageCnt"))
	result.list[i].failPageCnt = integer(log.item("failPageCnt"))
	result.list[i].refundPageCnt = integer(log.item("refundPageCnt"))
	result.list[i].cancelPageCnt = integer(log.item("cancelPageCnt"))
	result.list[i].receiptDT = string(log.item("receiptDT"))
	result.list[i].reserveDT = string(log.item("reserveDT"))
	result.list[i].sendDT = string(log.item("sendDT"))
	result.list[i].resultDT = string(log.item("resultDT"))
	result.list[i].sendResult = string(log.item("sendResult"))
	
	string fileNames[]
	fileNames= log.Item("fileNames")

	for j = 1 to upperbound(fileNames)
		result.list[i].fileNames[j]= fileNames[j]
	next
	
	log.DisconnectObject()
	destroy log
next

return result
end function

on faxservice.create
call super::create
end on

on faxservice.destroy
call super::destroy
end on

event constructor;call super::constructor;addscope("160")
end event

