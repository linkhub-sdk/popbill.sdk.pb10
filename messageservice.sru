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
private function string sendmessage (string msgtype, string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendsms (string corpnum, string sender, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendsms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendsms (string corpnum, string sender, string receiver, string receivername, string content, string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, mmessage messages[], string reservedt, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, string userid) throws popbillexception

public function string sendsms (string corpnum, string sender, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendsms (string corpnum, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendsms (string corpnum, string sender, string receiver, string receivername, string content, string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendlms (string corpnum, mmessage messages[], string reservedt,  boolean adsyn, string userid) throws popbillexception
public function string sendlms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendxms (string corpnum, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendxms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, boolean adsyn, string userid) throws popbillexception

public function string geturl (string corpnum, string userid, string togo) throws popbillexception
public function response cancelreserve (string corpnum, string receiptnum, string userid) throws popbillexception
public subroutine getmessageresult (string corpnum, string receiptnum, ref messageresult ref_result[]) throws popbillexception
public function string sendmms (string corpnum, string sender, string subject, string content, mmessage messages[], string filepaths[], string reservedt, string userid) throws popbillexception
public function string sendmms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string filepaths[], string reservedt, string userid) throws popbillexception
public function string sendmms (string corpnum, mmessage messages[], string filepaths[], string reservedt, string userid) throws popbillexception

public function string sendmms (string corpnum, string sender, string subject, string content, mmessage messages[], string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendmms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception
public function string sendmms (string corpnum, mmessage messages[], string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception

public function msgsearchresult search (string corpnum, string sdate, string edate, string state[], string item[], boolean reserveyn, boolean senderyn, string order, int page, int perpage) throws popbillexception
public function msgsearchresult tomsgsearchresult (ref oleobject dic)
public subroutine getautodenylist (string corpnum, ref autodeny ref_list[]) throws popbillexception

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

private function string sendmessage (string msgtype, string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;oleobject dic
string receiptNum,postData

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if (msgType = "SMS" or msgType = "LMS" or msgType = "XMS" or msgType = "MMS" )  = false then throw exception.setCodeNMessage(-99999999,"메시지 유형이 올바르게 입력되지 않았습니다.")
if isnull(messages) or upperbound(messages) <= 0 then throw exception.setcodenMessage(-99999999,"전송할 메시지가 입력되지 않았습니다.")

postData = '{'

if (isnull(sender) or sender = "") = false then postData += '"snd":"' + escapestring(sender) + '",'
if (isnull(subject) or subject = "") = false then postData += '"subject":"' + escapestring(subject) + '",'
if (isnull(content) or content = "") = false then postData += '"content":"' + escapestring(content) + '",'
if (isnull(reservedt) or reservedt = "") = false then postData += '"sndDT":"' + escapestring(reservedt) + '",'
if adsyn then postData += '"adsYN":true,'
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

public function string sendsms (string corpnum, string sender, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;
return sendmessage("SMS",corpnum,sender,"",content,messages,reserveDT, adsyn, userid)
end function

public function string sendsms (string corpnum, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;return sendmessage("SMS",corpnum,"","","",messages,reservedt,adsyn, userid)
end function

public function string sendsms (string corpnum, string sender, string receiver, string receivername, string content, string reservedt, boolean adsyn, string userid) throws popbillexception;mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].content = content

return sendsms(corpnum, l_message, reservedt, adsyn, userid)
end function

public function string sendlms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;
return sendmessage("LMS",corpnum,sender,subject,content,messages,reserveDT,adsyn, userid)
end function

public function string sendlms (string corpnum, mmessage messages[], string reservedt,boolean adsyn, string userid) throws popbillexception;
return sendmessage("LMS",corpnum,"","","",messages,reservedt,adsyn,userid)
end function

public function string sendlms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, boolean adsyn, string userid) throws popbillexception;mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendlms(corpnum,l_message,reservedt,adsyn, userid)
end function

public function string sendxms (string corpnum, string sender, string subject, string content, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;
return sendmessage("XMS",corpnum,sender,subject,content,messages,reserveDT,adsyn, userid)
end function

public function string sendxms (string corpnum, mmessage messages[], string reservedt, boolean adsyn, string userid) throws popbillexception;
return sendmessage("XMS",corpnum,"","","",messages,reservedt,adsyn, userid)
end function

public function string sendxms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string reservedt, boolean adsyn, string userid) throws popbillexception;
mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendxms(corpnum,l_message,reservedt, adsyn, userid)
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
	ref_result[i].receiptdt = string(log.item("receiptDT"))	
	ref_result[i].receiveNum = string(log.item("receiveNum"))
	ref_result[i].receiveName = string(log.item("receiveName"))
	ref_result[i].reserveDT = string(log.item("reserveDT"))
	ref_result[i].sendDT = string(log.item("sendDT"))
	ref_result[i].resultDT = string(log.item("resultDT"))
	ref_result[i].sendResult = string(log.item("sendResult"))
	ref_result[i].tranNet = string(log.item("tranNet"))

	log.DisconnectObject()
	destroy log
	
next


end subroutine

public function string sendmms (string corpnum, string sender, string subject, string content, mmessage messages[], string filepaths[], string reservedt, string userid) throws popbillexception;
return sendmms(corpnum, sender, subject, content, messages[], filepaths[], reservedt, false, userid)
end function

public function string sendmms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string filepaths[], string reservedt, string userid) throws popbillexception;
mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendmms(corpnum,l_message,filepaths,reservedt, userid)
end function

public function string sendmms (string corpnum, mmessage messages[], string filepaths[], string reservedt, string userid) throws popbillexception;
return sendmms(corpnum,"","","",messages,filepaths,reservedt,false, userid)
end function

public function string sendmms (string corpnum, string sender, string subject, string content, mmessage messages[], string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception;
oleobject dic
string receiptNum,postData

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(filepaths) or upperbound(filepaths) <= 0 then throw exception.setcodenMessage(-99999999,"전송파일 경로가 입력되지 않았습니다.")

postData = '{'

if (isnull(sender) or sender = "") = false then postData += '"snd":"' + escapestring(sender) + '",'
if (isnull(subject) or subject = "") = false then postData += '"subject":"' + escapestring(subject) + '",'
if (isnull(content) or content = "") = false then postData += '"content":"' + escapestring(content) + '",'
if (isnull(reservedt) or reservedt = "") = false then postData += '"sndDT":"' + escapestring(reservedt) + '",'
if adsyn then postData += '"adsYN":true,'

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



dic = httppostfiles("/MMS" ,corpnum,postData,filepaths,"file", userid)
receiptNum = dic.Item("receiptNum")
dic.DisconnectObject()
destroy dic

return receiptNum
end function

public function string sendmms (string corpnum, string sender, string receiver, string receivername, string subject, string content, string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception;
mmessage l_message[]

l_message[1].sender = sender
l_message[1].receiver = receiver
l_message[1].receivername = receivername
l_message[1].subject = subject
l_message[1].content = content

return sendmms(corpnum,l_message,filepaths,reservedt, adsyn, userid)
end function

public function string sendmms (string corpnum, mmessage messages[], string filepaths[], string reservedt, boolean adsyn, string userid) throws popbillexception;
return sendmms(corpnum,"","","",messages,filepaths,reservedt,adsyn, userid)
end function

public function msgsearchresult search (string corpnum, string sdate, string edate, string state[], string item[], boolean reserveyn, boolean senderyn, string order, int page, int perpage) throws popbillexception;
oleobject dic
string uri, tmpstr
int i
msgsearchresult result

uri = "/Message/Search"
uri += "?SDate=" + sdate
uri += "&EDate=" + edate

tmpstr = ""
for i = 1 to upperbound(state)
	tmpstr += state[i] 
	if i < upperbound(state) then tmpstr+= ','
next
uri += "&State=" + tmpstr

tmpstr = ""
for i = 1 to upperbound(item)
	tmpstr += item[i] 
	if i < upperbound(item) then tmpstr+= ','
next
uri += "&Item=" + tmpstr

if not isnull(senderyn) then
	if senderyn then uri += "&SenderYN=1"
	if not(senderyn) then uri += "&SenderYN=0"
end if

if not isnull(reserveyn) then
	if reserveyn then uri += "&ReserveYN=1"
	if not(reserveyn) then uri += "&ReserveYN=0"
end if
uri += "&Order=" + order
uri += "&Page=" + string(page)
uri += "&PerPage=" + string(perPage)

dic = httpget(uri,corpnum,"")

result = tomsgsearchresult(dic)
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

public function msgsearchresult tomsgsearchresult (ref oleobject dic);
msgsearchresult result
oleobject log

result.code = string(dic.Item("code"))
result.message = string(dic.Item("message"))
result.total = string(dic.Item("total"))
result.perPage = string(dic.Item("perPage"))
result.pageNum = string(dic.Item("pageNum"))
result.pageCount = string(dic.Item("pageCount"))

Integer i
oleobject list[]
list = dic.Item("list")

for i = 1 to upperbound(list)
	log = list[i]
	result.list[i].state = log.item("state")
	result.list[i].msgtype = string(log.item("type"))
	result.list[i].subject = string(log.item("subject"))
	result.list[i].content = string(log.item("content"))
	result.list[i].sendNum = string(log.item("sendNum"))
	result.list[i].receiptdt = string(log.item("receiptDT"))	
	result.list[i].receiveNum = string(log.item("receiveNum"))
	result.list[i].receiveName = string(log.item("receiveName"))
	result.list[i].reserveDT = string(log.item("reserveDT"))
	result.list[i].sendDT = string(log.item("sendDT"))
	result.list[i].resultDT = string(log.item("resultDT"))
	result.list[i].sendResult = string(log.item("sendResult"))
	result.list[i].tranNet = string(log.item("tranNet"))

	log.DisconnectObject()
	destroy log
	
next

return result
end function

public subroutine getautodenylist (string corpnum, ref autodeny ref_list[]) throws popbillexception
any dicList[]
integer i
oleobject key

dicList = httpget("/Message/Denied",corpnum,"")

for i = 1 to upperbound(dicList)
	key = dicList[i]
	
	ref_List[i].number = key.item("number")
	ref_List[i].regdt = key.item("regDT")
	
	key.DisconnectObject()
	destroy key
	
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

