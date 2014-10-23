$PBExportHeader$messageservice.sru
forward
global type messageservice from baseservice
end type
end forward

global type messageservice from baseservice
end type
global messageservice messageservice

forward prototypes
public function decimal getunitcost (string corpnum, string msgtype) throws popbillexception
private function string sendmessage (string msgtype, string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendsms (string corpnum, string sender, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendsms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendsms (string corpnum, string sender, string receiver, string receivername, string content, string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception
public function string geturl (string corpnum, string userid, string togo) throws popbillexception
public function response cancelreserve (string corpnum, string receiptnum, string userid) throws popbillexception
public subroutine getmessageresult (string corpnum, string receiptnum, ref messageresult ref_result[]) throws popbillexception
end prototypes

public function decimal getunitcost (string corpnum, string msgtype) throws popbillexception;decimal unitcost
oleObject result

if (msgType = "SMS" or msgType = "LMS" or msgType = "XMS" or msgType = "MMS" )  = false then throw exception.setCodeNMessage(-99999999,"메시지 유형이 올바르게 입력되지 않았습니다.")

result = httpget("/Message/UnitCost?Type=" + msgType , CorpNum,"")
unitcost = dec(result.Item("unitCost"))
result.DisconnectObject()
destroy result

return unitcost
end function

private function string sendmessage (string msgtype, string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception;oleobject dic
string receiptNum,postData

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if (msgType = "SMS" or msgType = "LMS" or msgType = "XMS" or msgType = "MMS" )  = false then throw exception.setCodeNMessage(-99999999,"메시지 유형이 올바르게 입력되지 않았습니다.")
if isnull(messages) or upperbound(messages) <= 0 then throw exception.setcodenMessage(-99999999,"전송할 메시지가 입력되지 않았습니다.")

postData = '{'

if (isnull(sender) or sender = "") = false then postData += '"snd":"' + escapestring(sender) + '",'
if (isnull(subject) or subject = "") = false then postData += '"subject":"' + escapestring(subject) + '",'
if (isnull(content) or content = "") = false then postData += '"content":"' + escapestring(content) + '",'
if (isnull(reservedt) or reservedt = "") = false then postData += '"sndDT":"' + escapestring(reservedt) + '",'

postData += '"msgs":['
integer i

for i = 1 to upperbound(messages)
	postData += '{"snd":"'+escapestring(messages[i].sender)+'",' + &
					'"rcv":"' + escapestring(messages[i].receiver) + '",' + &
					'"rcvnm":"' + escapestring(messages[i].receivername) + '",' + &
					'"msg":"' + escapestring(messages[i].content) + '",' + &
					'"sjt":"' + escapestring(messages[i].subject) + '"}' 
	if i < upperbound(messages) then postData += ","
next

postData += ']'

postData += '}'

dic = httppost("/" + msgType ,corpnum,postData,userid)
receiptNum = dic.Item("receiptNum")
dic.DisconnectObject()
destroy dic

return receiptNum
end function

public function string sendsms (string corpnum, string sender, string content, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("SMS",corpnum,sender,"",content,messages,reserveDT,userid)
end function

public function string sendsms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("SMS",corpnum,"","","",messages,reservedt,userid)
end function

public function string sendsms (string corpnum, string sender, string receiver, string receivername, string content, string reservedt, string userid) throws popbillexception;mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].content = content

return sendsms(corpnum,l_message,reservedt,userid)
end function

public function string sendlms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("LMS",corpnum,sender,subject,content,messages,reserveDT,userid)
end function

public function string sendlms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("LMS",corpnum,"","","",messages,reservedt,userid)
end function

public function string sendlms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception;mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendlms(corpnum,l_message,reservedt,userid)
end function

public function string sendxms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("XMS",corpnum,sender,subject,content,messages,reserveDT,userid)
end function

public function string sendxms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception;return sendmessage("XMS",corpnum,"","","",messages,reservedt,userid)
end function

public function string sendxms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception;mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendxms(corpnum,l_message,reservedt,userid)
end function

public function string geturl (string corpnum, string userid, string togo) throws popbillexception;string url
oleObject result

result = httpget("/Message/?TG=" + togo , CorpNum,Userid)
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

dic = httpget("/Message/" + receiptNum + "/Cancel" ,corpnum,userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public subroutine getmessageresult (string corpnum, string receiptnum, ref messageresult ref_result[]) throws popbillexception;any dicList[]
integer i
oleobject log

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(receiptNum) or receiptNum = "" then throw exception.setCodeNMessage(-99999999,"접수번호가 입력되지 않았습니다.")

dicList = httpget("/Message/" + receiptNum ,corpnum,"")

for i = 1 to upperbound(dicList)
	log = dicList[i]
	
	ref_result[i].state = log.item("state")
	ref_result[i].msgtype = string(log.item("type"))
	ref_result[i].subject = string(log.item("subject"))
	ref_result[i].content = string(log.item("content"))
	ref_result[i].sendNum = string(log.item("sendNum"))
	ref_result[i].receiveNum = string(log.item("receiveNum"))
	ref_result[i].receiveName = string(log.item("receiveName"))
	ref_result[i].reserveDT = string(log.item("reserveDT"))
	ref_result[i].sendDT = string(log.item("sendDT"))
	ref_result[i].resultDT = string(log.item("resultDT"))
	ref_result[i].sendResult = string(log.item("sendResult"))

	log.DisconnectObject()
	destroy log
	
next


end subroutine

on messageservice.create
call super::create
end on

on messageservice.destroy
call super::destroy
end on

event constructor;call super::constructor;addscope("150")
addscope("151")
addscope("152")
end event

