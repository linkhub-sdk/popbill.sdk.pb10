$PBExportHeader$baseservice.sru
forward
global type baseservice from nonvisualobject
end type
end forward

global type baseservice from nonvisualobject
end type
global baseservice baseservice

type variables
private:
Constant String ServiceID_REAL = "POPBILL"
constant string serviceID_TEST = "POPBILL_TEST"
constant string ServiceURL_REAL = "https://popbill.linkhub.co.kr"
constant string ServiceURL_TEST = "https://popbill_test.linkhub.co.kr"
constant string APIVersion = "1.0"

protected:
token in_token
string in_curCorpNum
boolean in_IsTest
authority in_authority
string scopes[]
popbillexception exception

public:
string linkID
string secretKey

end variables

forward prototypes
private function authority getauthority () throws popbillexception
protected function string getserviceid ()
protected function string getserviceurl ()
protected subroutine addscope (string scope)
public subroutine setistest (boolean istest)
public function double getbalance (string corpnum) throws popbillexception
private function string getsessiontoken (string corpnum, string forwardip) throws popbillexception
public function string getpopbillurl (string corpnum, string userid, string togo) throws popbillexception
public function double getpartnerbalance (string corpnum) throws popbillexception
public function response joinmember (ref joinform joininfo) throws popbillexception
public subroutine listcontact(string corpnum, string userid, ref contact ref_returnlist[]) throws popbillexception
public function response updatecontact(string corpnum, ref contact contactinfo, string userid) throws popbillexception
public function response registcontact(string corpnum, ref contact contactinfo, string userid) throws popbillexception
public function corpinfo getcorpinfo(string corpnum, string userid) throws popbillexception
public function response updatecorpinfo(string corpnum, ref corpinfo corpinfoObj, string userid) throws popbillexception
public function response checkID(string id) throws popbillexception;
private function string contactinfotostring (readonly contact contactInfo)
private function string joinformtostring (readonly joinform joininfo)
private function contact toContactInfo (ref oleobject dic);
private function corpInfo tocorpInfo(ref oleobject dic);
private function string corpInfotoString (readonly corpInfo corpInfoObj);
protected function string escapestring (readonly string input)
public function response checkismember (string corpnum, string a_linkid) throws popbillexception
protected function any parsejson (string inputjson) throws popbillexception
protected function any httpget (string url, string corpnum, string userid) throws popbillexception
protected function any httppost (string url, string corpnum, string postdata, string userid, string action) throws popbillexception
public function any httppost (string url, string corpnum, string postdata, string userid) throws popbillexception
protected function oleobject httppostfiles (string url, string corpnum, string postdata, string postfiles[], string fieldname, string userid) throws popbillexception
protected function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)

end prototypes

private function authority getauthority () throws popbillexception;if isnull(in_authority) then
	if isnull(linkid) or linkID = "" then throw exception.setCodeNMessage(-99999999,"링크아이디가 입력되지 않았습니다.")
	if isnull(secretKey) or secretKey = "" then throw exception.setCodeNMessage(-99999999,"비밀키가 입력되지 않았습니다.")
	in_authority = create authority
	in_authority.linkid = linkid
	in_authority.secretkey = secretKey
end if

return in_authority
end function

protected function string getserviceid ();if in_istest then 
	return serviceid_test
else 
	return serviceid_real
end if
end function

protected function string getserviceurl ();if in_istest then
	return serviceurl_test
else
	return serviceurl_real
end if
end function

protected subroutine addscope (string scope);scopes[UpperBound(scopes)+1] = scope
end subroutine

public subroutine setistest (boolean istest);in_IsTest = istest
end subroutine

public function double getbalance (string corpnum) throws popbillexception;try
	return  getAuthority().getBalance(getsessionToken(corpnum,""),getServiceID())
catch(linkhubexception le)
	throw exception.setcodenmessage(le.getcode(),le.getmessage())
end try

end function

private function string getsessiontoken (string corpnum, string forwardip) throws popbillexception;if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")

boolean changed,expired
expired = true

changed = in_curCorpNum <> corpnum

DateTime now

if not changed and isnull(in_token) = false then
	try 
		now = DateTime(date(mid(getAuthority().getTime(),1,10)) ,time( mid(getAuthority().getTime(),12,8)))
	catch (linkhubexception ex)
		throw exception.setCodeNMessage(ex.getcode(),ex.getmessage())
	end try
	expired = DateTime(date(mid(in_token.expiration,1,10)) ,time( mid(in_token.expiration,12,8))) <  now
end if

if expired then
	try
		in_token = getauthority().gettoken(getServiceID(),CorpNum,scopes,forwardip)
	catch (linkhubexception le)
		in_curCorpNum = ""
		throw exception.setCodeNMessage(le.getcode(),le.getmessage())
	end try
	in_curCorpNUm = corpNum
end if

return in_token.session_token
end function

public function string getpopbillurl (string corpnum, string userid, string togo) throws popbillexception;string url
oleObject result

result = httpget("/?TG=" + togo , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function double getpartnerbalance (string corpnum) throws popbillexception;try
	return  getAuthority().getPartnerBalance(getsessionToken(corpnum,""),getServiceID())
catch(linkhubexception le)
	throw exception.setcodenmessage(le.getcode(),le.getmessage())
end try

end function

public function response joinmember (ref joinform joininfo) throws popbillexception;response result
oleobject dic

String postData

postData = joinFormToString(joinInfo)

dic = httppost("/Join","",postData,"")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public subroutine listcontact(string corpnum, string userid, ref contact ref_returnlist[]) throws popbillexception;
any dicList[]
oleobject infoDic
Integer i

dicList = httpget("/IDs"  ,corpnum,userid)

for i = 1 to upperbound(dicList)
	infoDic = dicList[i]
	ref_returnlist[i] = toContactInfo(infodic)
	
	infoDic.DisconnectObject()
	destroy infoDic
	
next
end subroutine

public function response updatecontact(string corpnum, ref contact contactinfo, string userid) throws popbillexception;
response result
oleobject dic

String postData

postData = contactInfoToString(contactInfo)

dic = httppost("/IDs", corpnum, postData, userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response registcontact(string corpnum, ref contact contactinfo, string userid) throws popbillexception;
response result
oleobject dic

String postData

postData = contactInfoToString(contactInfo)

dic = httppost("/IDs/New", corpnum, postData, userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function corpinfo getcorpinfo(string corpnum, string userid) throws popbillexception;
corpInfo result
oleobject dic 
dic = httpget("/CorpInfo",corpnum, userid)
result = tocorpinfo(dic)
dic.DisconnectObject()
destroy dic
return result
end function

public function response updatecorpinfo(string corpnum, ref corpinfo corpinfoObj, string userid) throws popbillexception
response result
oleobject dic

String postData

postData = corpInfotoString(corpInfoObj)

dic = httppost("/CorpInfo", corpnum, postData, userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response checkID(string id) throws popbillexception;
response result
oleObject dic

dic = httpget("/IDCheck?ID="+id ,"","")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

private function string contactInfoToString (readonly contact contactInfo);//contactInfo to jsonString
string result
result = ""

result += "{"
if contactInfo.searchAllAllowYN then
result += '"searchAllAllowYN":true,'
end if
if contactInfo.mgrYN then
result += '"mgrYN":true,'
end if
result += '"id":"' + escapeString(contactInfo.id) + '",'
result += '"personName":"' + escapeString(contactInfo.personName) + '",'
result += '"email":"' + escapeString(contactInfo.email) + '",'
result += '"tel":"' + escapeString(contactInfo.tel) + '",'
result += '"hp":"' + escapeString(contactInfo.hp) + '",'
result += '"fax":"' + escapeString(contactInfo.fax) + '",'
result += '"pwd":"' + escapeString(contactInfo.pwd) + '",'
result += '"email":"' + escapeString(contactInfo.email) + '"'
result += "}"

return result
end function

private function string joinformtostring (readonly joinform joininfo);//joinForm to jsonString
string result
result = ""

result += "{"
result += '"LinkID":"' + escapeString(joininfo.LinkID) + '",'
result += '"CorpNum":"' + escapeString(joininfo.CorpNum) + '",'
result += '"CEOName":"' + escapeString(joininfo.CEOName) + '",'
result += '"CorpName":"' + escapeString(joininfo.CorpName) + '",'
result += '"Addr":"' + escapeString(joininfo.Addr) + '",'
result += '"ZipCode":"' + escapeString(joininfo.ZipCode) + '",'
result += '"BizType":"' + escapeString(joininfo.BizType) + '",'
result += '"BizClass":"' + escapeString(joininfo.BizClass) + '",'
result += '"ContactName":"' + escapeString(joininfo.ContactName) + '",'
result += '"ContactEmail":"' + escapeString(joininfo.ContactEmail) + '",'
result += '"ContactTEL":"' + escapeString(joininfo.ContactTEL) + '",'
result += '"ContactHP":"' + escapeString(joininfo.ContactHP) + '",'
result += '"ContactFAX":"' + escapeString(joininfo.ContactFAX) + '",'
result += '"ID":"' + escapeString(joininfo.ID) + '",'
result += '"PWD":"' + escapeString(joininfo.PWD) + '"'
result += "}"

return result
end function

private function contact toContactInfo (ref oleobject dic);
contact result

result.id = string(dic.Item("id"))
result.personName = string(dic.Item("personName"))
result.email = string(dic.Item("email"))
result.hp = string(dic.Item("hp"))
result.fax = string(dic.Item("fax"))
result.tel = string(dic.Item("tel"))
result.regDT = string(dic.Item("regDT"))
result.mgrYN = dic.Item("mgrYN")
result.searchAllAllowYN =  dic.Item("searchAllAllowYN")
return result
end function

private function corpInfo tocorpInfo(ref oleobject dic);
corpInfo result
result.ceoname = string(dic.Item("ceoname"))
result.corpName = string(dic.Item("corpName"))
result.addr = string(dic.Item("addr"))
result.bizType = string(dic.Item("bizType"))
result.bizClass = string(dic.Item("bizClass"))
return result
end function

private function string corpInfotoString (readonly corpInfo corpInfoObj);//corpInfo to jsonString
string result
result = ""

result += "{"
result += '"ceoname":"' + escapeString(corpInfoObj.ceoname) + '",'
result += '"corpName":"' + escapeString(corpInfoObj.corpName) + '",'
result += '"addr":"' + escapeString(corpInfoObj.addr) + '",'
result += '"bizType":"' + escapeString(corpInfoObj.bizType) + '",'
result += '"bizClass":"' + escapeString(corpInfoObj.bizClass) + '"'
result += "}"

return result
end function

protected function string escapestring (readonly string input);
string result 

result = input

result = of_replaceall(result,'\','\\')
result = of_replaceall(result,'/','\/')
result = of_replaceall(result,'"','\"')
result = of_replaceall(result,"'","\'")
result = of_replaceall(result,'~b','\b')
result = of_replaceall(result,'~t','\t')
result = of_replaceall(result,'~n','\n')
result = of_replaceall(result,'~f','\f')
result = of_replaceall(result,'~r','\r')

return result
end function

public function response checkismember (string corpnum, string a_linkid) throws popbillexception;response result
oleObject dic

dic = httpget("/Join?CorpNum=" + CorpNum + "&LID=" + a_linkid ,"","")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

protected function any parsejson (string inputjson) throws popbillexception;try
	return getauthority().parsejson(inputjson)
catch(linkhubexception le)
	throw exception.setcodenmessage(le.getcode(),le.getmessage())
end try
end function

protected function any httpget (string url, string corpnum, string userid) throws popbillexception;OLEObject lo_httpRequest,dic
any anyReturn
string ls_result

lo_httpRequest = CREATE OLEObject
if lo_httpRequest.ConnectToNewObject("MSXML2.XMLHTTP.6.0") <> 0 then throw exception.setCodeNMessage(-99999999,"HttpRequest Create Fail.")
lo_httpRequest.open("GET",getServiceURL() + url,false)
if (isnull(corpnum) or corpnum = "") = false then
	lo_httpRequest.setRequestHeader("Authorization","Bearer " + getsessionToken(corpnum,""))
end if
if (isnull(userid) or userid = "") = false then lo_httpRequest.setRequestHeader("x-pb-userid",userid)
lo_httpRequest.setRequestHeader("Accept-Encoding", "gzip,deflate")
lo_httpRequest.send()

ls_result = string(lo_httpRequest.ResponseText)

if lo_httpRequest.Status <> 200 then 
	dic = parsejson(ls_result)
	exception.setCodeNMessage(dic.Item("code"),dic.Item("message"))
	lo_httpRequest.DisconnectObject()
	destroy lo_httpRequest
	dic.DisconnectObject()
	destroy dic
	throw exception
end if

lo_httpRequest.DisconnectObject()
destroy lo_httpRequest

anyReturn = parsejson(ls_result)

return anyReturn
end function

protected function any httppost (string url, string corpnum, string postdata, string userid, string action) throws popbillexception;OLEObject lo_httpRequest, dic
any returnobj
string ls_result

lo_httpRequest = CREATE OLEObject
if lo_httpRequest.ConnectToNewObject("MSXML2.XMLHTTP.6.0") <> 0 then throw exception.setCodeNMessage(-99999999,"HttpRequest Create Fail.")
lo_httpRequest.open("POST",getServiceURL() + url,false)
lo_httpRequest.setRequestHeader("Content-Type", "Application/json")
lo_httpRequest.setRequestHeader("Accept-Encoding","gzip,deflate")

if (isnull(corpnum) or corpnum = "") = false then
	lo_httpRequest.setRequestHeader("Authorization","Bearer " + getsessionToken(corpnum,""))
end if

if (isnull(action) or action = "") = false then
	lo_httpRequest.setRequestHeader("X-HTTP-Method-Override",action)
end if


if (isnull(userid) or userid = "") = false then lo_httpRequest.setRequestHeader("x-pb-userid",userid)

lo_httpRequest.send(postData)

ls_result = string(lo_httpRequest.ResponseText)

if lo_httpRequest.Status <> 200 then 
	dic = parsejson(ls_result)
	exception.setCodeNMessage(dic.Item("code"),dic.Item("message"))
	lo_httpRequest.DisconnectObject()
	destroy lo_httpRequest
	dic.DisconnectObject()
	destroy dic
	throw exception
end if

lo_httpRequest.DisconnectObject()
destroy lo_httpRequest

returnobj = parsejson(ls_result)

return returnobj
end function

public function any httppost (string url, string corpnum, string postdata, string userid) throws popbillexception;return httppost(url,corpnum,postdata,userid,"")
end function

protected function oleobject httppostfiles (string url, string corpnum, string postdata, string postfiles[], string fieldname, string userid) throws popbillexception;OLEObject lo_httpRequest, dic
any returnobj
string ls_result
string boundary
boundary = "------------LINKHUB-PB"

lo_httpRequest = CREATE OLEObject
if lo_httpRequest.ConnectToNewObject("MSXML2.XMLHTTP.6.0") <> 0 then throw exception.setCodeNMessage(-99999999,"HttpRequest Create Fail.")
lo_httpRequest.open("POST",getServiceURL() + url,false)
lo_httpRequest.setRequestHeader("Accept-Encoding", "gzip,deflate")
lo_httpRequest.setRequestHeader("Content-Type", "multipart/form-data; boundary=" + boundary)

if (isnull(corpnum) or corpnum = "") = false then
	lo_httpRequest.setRequestHeader("Authorization","Bearer " + getsessionToken(corpnum,""))
end if

if (isnull(userid) or userid = "") = false then lo_httpRequest.setRequestHeader("x-pb-userid",userid)

blob toSend
toSend = blob("",encodingUTF8!)

if (isnull(postData) or postData = "") = false then
	toSend += blob("--" + boundary + "~r~n" + &
						'Content-Disposition: form-data; name="form"~r~n' + &
						'Content-Type: Application/json~r~n' + &
						'~r~n' + &
						postData,encodingUTF8!)
end if

integer i
for i = 1 to upperbound(postFiles)
	long ll_fileLen,l_fileHandle
	string l_filePath
	string l_justFileName
	blob lb_file

	l_filePath = postFiles[i]
	
	l_justFileName = mid(l_filePath,lastpos(l_filePath,"\",len(l_filepath)) + 1,len(l_filePath))
	
	if isnull(l_filePath) or l_filePath = "" then exception.setcodenmessage(-99999999,"전송할 파일 경로가 입력되지 않았습니다.")
	if FileLength(l_filePath) <= 0 then exception.setcodenmessage(-99999999,"전송할 파일이 올바르지 않거나 존재하지 않습니다.")
	
	toSend += blob("~r~n--" + boundary + "~r~n" + &
						'Content-Disposition: form-data; name="'+ fieldName +'"; filename="' + l_justFileName + '"~r~n' + &
						'Content-Type: application/octet-stream~r~n' + &
						'~r~n' ,encodingUTF8!)
	
	l_fileHandle = FileOpen(l_filePath,StreamMode!)
	
	if FileReadEx(l_fileHandle,lb_file) <= 0 then exception.setcodenmessage(-99999999,"전송할 파일을 읽는중 오류가 발생하였습니다.")
	
	FileClose(l_fileHandle)
	
	toSend += lb_file
	
next

toSend += blob("~r~n--" + boundary + "--~r~n" ,encodingUTF8!)

lo_httpRequest.send(toSend)

ls_result = string(lo_httpRequest.ResponseText)

if lo_httpRequest.Status <> 200 then 
	dic = parsejson(ls_result)
	exception.setCodeNMessage(dic.Item("code"),dic.Item("message"))
	lo_httpRequest.DisconnectObject()
	destroy lo_httpRequest
	dic.DisconnectObject()
	destroy dic
	throw exception
end if

lo_httpRequest.DisconnectObject()
destroy lo_httpRequest

returnobj = parsejson(ls_result)

return returnobj
end function

protected function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring

end function

on baseservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on baseservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;setnull(in_authority)
exception  = create popbillexception
scopes[1] = "member"

end event

