$PBExportHeader$statementservice.sru
forward
global type statementservice from baseservice
end type
end forward

global type statementservice from baseservice
end type
global statementservice statementservice

type variables

end variables

forward prototypes
private function string statementtojson (ref statement ar_statement)
public function response register (string corpnum, ref statement ar_statement, string userid) throws popbillexception
public function response register (string corpnum, ref statement ar_statement) throws popbillexception
public function response issue (string corpnum, string itemcode, string mgtkey, string memo) throws popbillexception
public function response cancelissue (string corpnum, string itemcode, string mgtkey, string memo) throws popbillexception
public function statementinfo tostatementinfo (ref oleobject dic)
public function statement tostatement (ref oleobject dic)
public function string geturl (string corpnum, string userid, string togo) throws popbillexception
public function response erase (string corpnum, string itemcode, string mgtkey) throws popbillexception
public function statementinfo getinfo (string corpnum, string itemcode, string mgtkey) throws popbillexception
public function boolean checkmgtkeyinuse (string corpnum, string itemcodestr, string mgtkey) throws popbillexception
public function decimal getunitcost (string corpnum, string itemcodestr) throws popbillexception
public function string getitemcode (string textcode)
public function response issue (string corpnum, string itemcodestr, string mgtkey, string memo, string userid) throws popbillexception
public function response cancelissue (string corpnum, string itemcodestr, string mgtkey, string memo, string userid) throws popbillexception
public subroutine getfiles (string corpnum, string itemcodestr, string mgtkey, ref attachedfile ref_filelist[]) throws popbillexception
public function response attachfile (string corpnum, string itemcodestr, string mgtkey, string filepath, string userid) throws popbillexception
public function response deletefile (string corpnum, string itemcodestr, string mgtkey, string fileid, string userid) throws popbillexception
public function statementinfo getinfo (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function statement getdetailinfo (string corpnum, string itemcodestr, string mgtkey) throws popbillexception
public subroutine getlogs (string corpnum, string itemcodestr, string mgtkey, ref statementlog ref_list[]) throws popbillexception
public subroutine getinfos (string corpnum, string itemcodestr, ref string mgtkeylist[], ref statementinfo ref_returnlist[]) throws popbillexception
public function response sendemail (string corpnum, string itemcodestr, string mgtkey, string receiver, string userid) throws popbillexception
public function response sendfax (string corpnum, string itemcodestr, string mgtkey, string sender, string receiver, string userid) throws popbillexception
public function response sendsms (string corpnum, string itemcodestr, string mgtkey, string sender, string receiver, string contents, string userid) throws popbillexception
public function string getprinturl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function string getpopupurl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function string getmassprinturl (string corpnum, string itemcodestr, string mgtkeylist[], string userid) throws popbillexception
public function string getmailurl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function string geteprinturl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function response update (string corpnum, string itemcodestr, string mgtkey, ref statement ar_statement, string userid) throws popbillexception
public function response erase (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception
public function string faxsend(string corpnum, ref statement at_statement, string sendnum, string receivenum) throws popbillexception
public function response registissue (string corpnum, ref statement ar_statement, string memo) throws popbillexception
public function response registissue (string corpnum, ref statement ar_statement, string memo, string userid) throws popbillexception
public function stmtsearchresult tostmtsearchresult (ref oleobject dic)
public function stmtsearchresult search (string corpnum, string dtype, string sdate, string edate, string state[], int itemcode[], string order, int page, int perpage) throws popbillexception
public function response attachstatement (string corpnum, string itemcodestr, string mgtkey, string subitemcode, string submgtkey) throws popbillexception
public function response detachstatement (string corpnum, string itemcodestr, string mgtkey, string subitemcode, string submgtkey) throws popbillexception
end prototypes

private function string statementtojson (ref statement ar_statement);string result

result = ""
result += "{"
result += '"sendNum":"' + escapeString(ar_statement.sendNum) + '",'
result += '"receiveNum":"' + escapeString(ar_statement.receiveNum) + '",'
result += '"itemCode":"' + String(ar_statement.itemCode) + '",'
result += '"writeDate":"' + escapeString(ar_statement.writeDate) + '",'
result += '"purposeType":"' + escapeString(ar_statement.purposeType ) + '",'
result += '"taxType":"' + escapeString(ar_statement.taxType ) + '",'
result += '"formCode":"' + escapeString(ar_statement.formCode ) + '",'
result += '"mgtKey":"' + escapeString(ar_statement.mgtKey ) + '",'
result += '"memo":"' + escapeString(ar_statement.memo ) + '",'

result += '"senderCorpNum":"' + escapeString(ar_statement.senderCorpNum ) + '",'
result += '"senderTaxRegID":"' + escapeString(ar_statement.senderTaxRegID ) + '",'
result += '"senderCorpName":"' + escapeString(ar_statement.senderCorpName ) + '",'
result += '"senderCEOName":"' + escapeString(ar_statement.senderCEOName ) + '",'
result += '"senderAddr":"' + escapeString(ar_statement.senderAddr ) + '",'
result += '"senderBizClass":"' + escapeString(ar_statement.senderBizClass ) + '",'
result += '"senderBizType":"' + escapeString(ar_statement.senderBizType ) + '",'
result += '"senderContactName":"' + escapeString(ar_statement.senderContactName ) + '",'
result += '"senderTEL":"' + escapeString(ar_statement.senderTEL ) + '",'
result += '"senderHP":"' + escapeString(ar_statement.senderHP) + '",'
result += '"senderEmail":"' + escapeString(ar_statement.senderEmail ) + '",'

result += '"receiverCorpNum":"' + escapeString(ar_statement.receiverCorpNum ) + '",'
result += '"receiverTaxRegID":"' + escapeString(ar_statement.receiverTaxRegID ) + '",'
result += '"receiverCorpName":"' + escapeString(ar_statement.receiverCorpName ) + '",'
result += '"receiverCEOName":"' + escapeString(ar_statement.receiverCEOName ) + '",'
result += '"receiverAddr":"' + escapeString(ar_statement.receiverAddr ) + '",'
result += '"receiverBizClass":"' + escapeString(ar_statement.receiverBizClass ) + '",'
result += '"receiverBizType":"' + escapeString(ar_statement.receiverBizType ) + '",'
result += '"receiverContactName":"' + escapeString(ar_statement.receiverContactName ) + '",'
result += '"receiverTEL":"' + escapeString(ar_statement.receiverTEL ) + '",'
result += '"receiverHP":"' + escapeString(ar_statement.receiverHP ) + '",'
result += '"receiverEmail":"' + escapeString(ar_statement.receiverEmail ) + '",'
result += '"supplyCostTotal":"' + escapeString(ar_statement.supplyCostTotal ) + '",'
result += '"taxTotal":"' + escapeString(ar_statement.taxTotal ) + '",'
result += '"totalAmount":"' + escapeString(ar_statement.totalAmount ) + '",'
result += '"serialNum":"' + escapeString(ar_statement.serialNum ) + '",'
result += '"remark1":"' + escapeString(ar_statement.remark1 ) + '",'
result += '"remark2":"' + escapeString(ar_statement.remark2 ) + '",'
result += '"remark3":"' + escapeString(ar_statement.remark3 ) + '",'


if ar_statement.BusinessLicenseYN then
result += '"businessLicenseYN":true,'
end if

if ar_statement.bankBookYN  then
result += '"bankBookYN":true,'
end if

if ar_statement.smssendYN   then
result += '"smssendYN":true,'
end if

Integer i

if upperbound(ar_statement.detailList) > 0 then
	result += '"detailList":['
	
	for i = 1 to upperbound(ar_statement.detailList)
		result += '{'
		result += '"serialNum":' + String(ar_statement.detailList[i].serialNum) + ','	
		result += '"purchaseDT":"' + escapeString(ar_statement.detailList[i].purchaseDT) + '",'
		result += '"itemName":"' + escapeString(ar_statement.detailList[i].itemName) + '",'
		result += '"spec":"' + escapeString(ar_statement.detailList[i].spec) + '",'
		result += '"qty":"' + escapeString(ar_statement.detailList[i].qty) + '",'
		result += '"unitCost":"' + escapeString(ar_statement.detailList[i].unitCost) + '",'
		result += '"supplyCost":"' + escapeString(ar_statement.detailList[i].supplyCost) + '",'
		result += '"tax":"' + escapeString(ar_statement.detailList[i].tax) + '",'
		result += '"remark":"' + escapeString(ar_statement.detailList[i].remark) + '"'
		result += '}'
		if i < upperbound(ar_statement.detailList) then
			result += ','
		end if
	next
	
	result += '],'
end if

string propertystr
for i=1 to upperbound(ar_statement.propertyBag)
	propertystr+= '"'+ar_statement.propertyBag[i].key+'":"'+ar_statement.propertyBag[i].value+'",'
next

if not(isnull(ar_statement.propertybag)) then
	result+= '"propertyBag":'
	result+= '{' 
	result += left(propertystr, len(propertystr)-1)
	result +='}'
end if

result += "}"
return result
end function

public function response register (string corpnum, ref statement ar_statement, string userid) throws popbillexception;response result
oleobject dic

String postData
postData = statementToJson(ar_statement)

dic = httppost("/Statement",corpnum,postData,userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response register (string corpnum, ref statement ar_statement) throws popbillexception;return register(corpnum, ar_statement, "")
end function

public function response issue (string corpnum, string itemcode, string mgtkey, string memo) throws popbillexception;return issue(corpnum, itemcode, mgtkey, memo, "")
end function

public function response cancelissue (string corpnum, string itemcode, string mgtkey, string memo) throws popbillexception;return cancelissue(corpnum, itemcode, mgtkey, memo, "")
end function

public function statementinfo tostatementinfo (ref oleobject dic);statementinfo result

result.itemcode = string(dic.Item("itemcode"))
result.itemkey = string(dic.Item("itemKey"))
result.mgtkey = string(dic.Item("mgtKey"))
result.stateCode = dic.Item("stateCode")
result.taxType = string(dic.Item("taxType"))
result.purposeType = string(dic.Item("purposeType"))
result.writeDate = string(dic.Item("writeDate"))
result.senderCorpName = string(dic.Item("senderCorpName"))
result.senderCorpNum = string(dic.Item("senderCorpNum"))
result.senderPrintYN = dic.Item("senderPrintYN")
result.receiverCorpName = string(dic.Item("receiverCorpName"))
result.receiverCorpNum = string(dic.Item("receiverCorpNum"))
result.receiverPrintYN = dic.Item("receiverPrintYN")
result.supplyCostTotal = string(dic.Item("supplyCostTotal"))
result.taxTotal = string(dic.Item("taxTotal"))
result.issueDT = string(dic.Item("issueDT"))
result.stateDT = string(dic.Item("stateDT"))
result.openYN = dic.Item("openYN")
result.openDT = string(dic.Item("openDT"))
result.stateMemo = string(dic.Item("stateMemo"))
result.regDT = string(dic.Item("regDT"))

return result
end function

public function statement tostatement (ref oleobject dic);statement result

result.itemCode = dic.Item("itemCode")
result.mgtKey = string(dic.Item("mgtKey"))
result.invoiceNum = string(dic.Item("invoiceNum"))
result.formCode = string(dic.Item("formCode"))
result.writeDate = string(dic.Item("writeDate"))
result.taxType = string(dic.Item("taxType"))

result.senderCorpNum = string(dic.Item("senderCorpNum"))
result.senderTaxRegID = string(dic.Item("senderTaxRegID"))
result.senderCorpName = string(dic.Item("senderCorpName"))
result.senderCEOName = string(dic.Item("senderCEOName"))
result.senderAddr = string(dic.Item("senderAddr"))
result.senderBizClass = string(dic.Item("senderBizClass"))
result.senderBizType = string(dic.Item("senderBizType"))
result.senderContactName = string(dic.Item("senderContactName"))
result.senderDeptName = string(dic.Item("senderDeptName"))
result.senderTEL = string(dic.Item("senderTEL"))
result.senderHP = string(dic.Item("senderHP"))
result.senderEmail = string(dic.Item("senderEmail"))
result.senderFAX = string(dic.Item("senderFAX"))

result.receiverCorpNum = string(dic.Item("receiverCorpNum"))
result.receiverTaxRegID = string(dic.Item("receiverTaxRegID"))
result.receiverCorpName = string(dic.Item("receiverCorpName"))
result.receiverCEOName = string(dic.Item("receiverCEOName"))
result.receiverAddr = string(dic.Item("receiverAddr"))
result.receiverBizClass = string(dic.Item("receiverBizClass"))
result.receiverBizType = string(dic.Item("receiverBizType"))
result.receiverContactName = string(dic.Item("receiverContactName"))
result.receiverDeptName = string(dic.Item("receiverDeptName"))
result.receiverTEL = string(dic.Item("receiverTEL"))
result.receiverHP = string(dic.Item("receiverHP"))
result.receiverEmail = string(dic.Item("receiverEmail"))
result.receiverFAX = string(dic.Item("receiverFAX"))

result.taxTotal = string(dic.Item("taxTotal"))
result.supplyCostTotal = string(dic.Item("supplyCostTotal"))
result.totalAmount = string(dic.Item("totalAmount"))
result.purposeType = string(dic.Item("purposeType"))
result.serialNum = string(dic.Item("serialNum"))
result.remark1 = string(dic.Item("remark1"))
result.remark2 = string(dic.Item("remark2"))
result.remark3 = string(dic.Item("remark3"))
result.businessLicenseYN = dic.Item("businessLicenseYN")
result.bankBookYN = dic.Item("bankBookYN")
result.faxsendYN = dic.Item("faxsendYN")
result.smssendYN = dic.Item("smssendYN")
//result.autoacceptYN = dic.Item("autoacceptYN")

Integer i
oleobject detailList[]
detailList = dic.Item("detailList")

for i = 1 to upperbound(detailList)
	result.detailList[i].serialNum = detailList[i].Item("serialNum")
	result.detailList[i].purchaseDT = string(detailList[i].Item("purchaseDT"))
	result.detailList[i].itemName = string(detailList[i].Item("itemName"))
	result.detailList[i].spec = string(detailList[i].Item("spec"))
	result.detailList[i].unit = string(detailList[i].Item("unit"))	
	result.detailList[i].qty = string(detailList[i].Item("qty"))	
	result.detailList[i].unitcost = string(detailList[i].Item("unitcost"))		
	result.detailList[i].supplycost = string(detailList[i].Item("supplycost"))		
	result.detailList[i].tax = string(detailList[i].Item("tax"))
	result.detailList[i].remark = string(detailList[i].Item("remark"))
	result.detailList[i].spare1 = string(detailList[i].Item("spare1"))
	result.detailList[i].spare2 = string(detailList[i].Item("spare2"))
	result.detailList[i].spare3 = string(detailList[i].Item("spare3"))
	result.detailList[i].spare4 = string(detailList[i].Item("spare4"))
	result.detailList[i].spare5 = string(detailList[i].Item("spare5"))
next

oleobject propertyBag
propertyBag = dic.Item("propertyBag")

string keyArr[] 
keyArr = propertyBag.keys()

for i=1 to upperbound(keyArr)
	result.propertyBag[i].key = keyArr[i]
	result.propertyBag[i].value = string(propertyBag.item(result.propertyBag[i].key))
next

return result
end function

public function string geturl (string corpnum, string userid, string togo) throws popbillexception;string url
oleObject result

result = httpget("/Statement/?TG=" + togo , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function response erase (string corpnum, string itemcode, string mgtkey) throws popbillexception;return erase(corpnum, itemcode, mgtkey, "")
end function

public function statementinfo getinfo (string corpnum, string itemcode, string mgtkey) throws popbillexception;return getinfo(corpnum, itemcode, mgtkey,"")
end function

public function boolean checkmgtkeyinuse (string corpnum, string itemcodestr, string mgtkey) throws popbillexception;oleobject dic
string IK
string itemcode

itemcode = string(getItemcode(itemcodeStr))

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

try
	dic = httpget("/Statement/" + itemcode+ "/" + MgtKey , CorpNum,"")
	IK = string(dic.Item("itemKey"))
	return (isnull(IK) or IK = "") = false
	
catch(popbillexception pe)
	if pe.getcode() = -12000004 then return false
	throw pe
end try
end function

public function decimal getunitcost (string corpnum, string itemcodestr) throws popbillexception;decimal unitcost
oleObject result
string itemcode

itemcode = getItemCode(itemcodeStr)

result = httpget("/Statement/"+itemcode+"?cfg=UNITCOST" , CorpNum,"")
unitcost = dec(result.Item("unitCost"))
result.DisconnectObject()
destroy result

return unitcost
end function

public function string getitemcode (string textcode);string result

if (textcode = "거래명세서") then
	result = "121"
elseif (textcode = "청구서") then
	result = "122"
elseif (textcode = "견적서") then
	result = "123"
elseif (textcode = "발주서") then
	result = "124"
elseif (textcode = "입금표") then
	result = "125"
elseif (textcode = "영수증") then
	result = "126"
end if

return result
end function

public function response issue (string corpnum, string itemcodestr, string mgtkey, string memo, string userid) throws popbillexception;response result
oleobject dic
string postData, itemcode

itemcode = getitemcode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{'
postData += '"memo":"'+escapestring(memo)+'"}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"ISSUE")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response cancelissue (string corpnum, string itemcodestr, string mgtkey, string memo, string userid) throws popbillexception;response result
oleobject dic
string postData,itemcode

itemcode = getitemcode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{"memo":"'+escapestring(memo)+'"}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"CANCEL")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public subroutine getfiles (string corpnum, string itemcodestr, string mgtkey, ref attachedfile ref_filelist[]) throws popbillexception;any dicList[]
integer i
oleobject log
string itemcode

itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dicList = httpget("/Statement/" + itemcode + "/" + mgtkey + "/Files",corpnum,"")

for i = 1 to upperbound(dicList)
	log = dicList[i]
	
	ref_filelist[i].serialNum = log.item("serialNum")
	ref_filelist[i].fileID = string(log.item("attachedFile"))
	ref_filelist[i].displayName = string(log.item("displayName"))
	ref_filelist[i].regDT = string( log.item("regDT"))
	
	log.DisconnectObject()
	destroy log
	
next

end subroutine

public function response attachfile (string corpnum, string itemcodestr, string mgtkey, string filepath, string userid) throws popbillexception;response result
oleobject dic
string itemcode

itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dic = httppostfiles("/Statement/" + itemcode + "/" + mgtkey + "/Files" ,corpnum,"",{filepath},"Filedata", userid)
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response deletefile (string corpnum, string itemcodestr, string mgtkey, string fileid, string userid) throws popbillexception;response result
oleobject dic
string itemcode
itemcode = getItemCode(itemcodeStr)
if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")
if isnull(fileid) or fileid = "" then throw exception.setCodeNMessage(-99999999,"파일아이디가 입력되지 않았습니다.")

dic = httppost("/Statement/" + itemcode + "/" + mgtkey + "/Files/" + FileID ,corpnum,"",userid,"DELETE")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function statementinfo getinfo (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;statementInfo result
oleobject dic
string itemcode

itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dic = httpget("/Statement/" + itemcode + "/" + MgtKey , CorpNum,"")
result = tostatementinfo(dic)
dic.DisconnectObject()
destroy dic

return result
end function

public function statement getdetailinfo (string corpnum, string itemcodestr, string mgtkey) throws popbillexception;statement result
oleobject dic
int i
string itemcode
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dic = httpget("/Statement/" + itemcode + "/" + MgtKey + "?Detail" , CorpNum,"")
result = tostatement(dic)
oleobject toDestory[]
toDestory = dic.Item("detailList")
for i = 1 to upperbound(toDestory)
	toDestory[i].DisconnectObject()
	destroy toDestory[i]
next
destroy dic

return result
end function

public subroutine getlogs (string corpnum, string itemcodestr, string mgtkey, ref statementlog ref_list[]) throws popbillexception;any dicList[]
integer i
oleobject log
string itemcode
itemcode = getItemCode(itemCodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dicList = httpget("/Statement/" + itemcode + "/" + mgtkey + "/Logs",corpnum,"")

for i = 1 to upperbound(dicList)
	log = dicList[i]
	
	ref_List[i].docLogType = log.item("docLogType")
	ref_List[i].log = string(log.item("log"))
	ref_List[i].procType =  string(log.item("procType"))
	ref_List[i].procCorpName =  string(log.item("procCorpName"))
	ref_List[i].procMemo = string( log.item("procMemo"))
	ref_List[i].regDT = string( log.item("regDT"))
	ref_List[i].ip = string( log.item("ip"))
	
	log.DisconnectObject()
	destroy log
	
next


end subroutine

public subroutine getinfos (string corpnum, string itemcodestr, ref string mgtkeylist[], ref statementinfo ref_returnlist[]) throws popbillexception;any dicList[]
oleobject infoDic
string postData
Integer i

string itemcode
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(mgtkeylist) or upperbound(mgtkeylist) <= 0  then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData ='['

for i = 1 to upperbound(mgtkeylist)
	postData += '"' + mgtkeyList[i] + '"'
	if i < upperbound(mgtkeyList) then postData += ','
next

postData +=']'

dicList = httppost("/Statement/" + itemcode  ,corpnum,postData,"")

for i = 1 to upperbound(dicList)
	infoDic = dicList[i]
	ref_returnlist[i] = tostatementinfo(infodic)
	
	infoDic.DisconnectObject()
	destroy infoDic
	
next

end subroutine

public function response sendemail (string corpnum, string itemcodestr, string mgtkey, string receiver, string userid) throws popbillexception;response result
oleobject dic
string postData, itemcode
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{"receiver":"'+escapestring(receiver)+'"}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"EMAIL")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response sendfax (string corpnum, string itemcodestr, string mgtkey, string sender, string receiver, string userid) throws popbillexception;response result
oleobject dic
string postData, itemCode
itemCode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{"sender":"'+escapestring(sender)+'","receiver":"'+escapestring(receiver)+'"}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"FAX")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response sendsms (string corpnum, string itemcodestr, string mgtkey, string sender, string receiver, string contents, string userid) throws popbillexception;response result
oleobject dic
string postData, itemcode
itemcode = getItemCode(itemCodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{"sender":"'+escapestring(sender)+'","receiver":"'+escapestring(receiver)+'","contents":"'+escapestring(contents)+'"}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"SMS")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function string getprinturl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;string url, itemcode
oleObject result
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

result = httpget("/Statement/"+itemcode + "/" + mgtkey + "?TG=PRINT" , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function string getpopupurl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;string url, itemcode
oleObject result
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

result = httpget("/Statement/"+itemcode+ "/" + mgtkey + "?TG=POPUP" , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function string getmassprinturl (string corpnum, string itemcodestr, string mgtkeylist[], string userid) throws popbillexception;string url, itemcode
oleObject result
string postData
Integer i

itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(mgtkeylist) or upperbound(mgtkeylist) <= 0 then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData ='['

for i = 1 to upperbound(mgtkeylist)
	postData += '"' + mgtkeyList[i] + '"'
	if i < upperbound(mgtkeyList) then postData += ','
next

postData +=']'

result = httppost("/Statement/"+itemcode + "?Print" , CorpNum,postData,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function string getmailurl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;string url, itemcode
oleObject result

itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

result = httpget("/Statement/"+itemcode + "/" + mgtkey + "?TG=MAIL" , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function string geteprinturl (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;string url, itemcode
oleObject result
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

result = httpget("/Statement/"+itemcode+ "/" + mgtkey + "?TG=EPRINT" , CorpNum,Userid)
url = result.Item("url")
result.DisconnectObject()
destroy result

return url
end function

public function response update (string corpnum, string itemcodestr, string mgtkey, ref statement ar_statement, string userid) throws popbillexception;response result
oleobject dic

String postData, itemcode
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = statementToJson(ar_statement)

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,postData,userid,"PATCH")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response erase (string corpnum, string itemcodestr, string mgtkey, string userid) throws popbillexception;response result
oleobject dic
string itemcode
itemcode = getItemCode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

dic = httppost("/Statement/" + itemcode + "/" + mgtkey ,corpnum,"",userid,"DELETE")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function string faxsend(string corpnum, ref statement ar_statement, string sendnum, string receivenum) throws popbillexception;
oleobject dic
String postData, receiptNum

ar_statement.sendNum = sendnum
ar_statement.receiveNum = receivenum

postData = statementToJson(ar_statement)

dic = httppost("/Statement",corpnum,postData,"","FAX")
receiptNum = dic.Item("receiptNum")
dic.DisconnectObject()
destroy dic

return receiptNum
end function

public function response registissue(string corpnum, ref statement ar_statement, string memo) throws popbillexception;
return registissue(corpnum, ar_statement, memo, "")
end function

public function response registissue (string corpnum, ref statement ar_statement, string memo, string userid) throws popbillexception;
response result
oleobject dic
ar_statement.memo = memo
string postData
postData = statementToJson(ar_statement)

dic = httppost("/Statement",corpnum,postData,userid,"ISSUE")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function stmtsearchresult tostmtsearchresult (ref oleobject dic);
stmtsearchresult result

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
	result.list[i] = tostatementinfo(list[i])
next

return result
end function

public function stmtsearchresult search (string corpnum, string dtype, string sdate, string edate, string state[], int itemcode[], string order, int page, int perpage) throws popbillexception;
oleobject dic
string uri, tmpstr
int i
stmtsearchresult result

uri = "/Statement/Search"
uri += "?DType=" + dtype
uri += "&SDate=" + sdate
uri += "&EDate=" + edate

tmpstr = ""
for i = 1 to upperbound(state)
	tmpstr += state[i] 
	if i < upperbound(state) then tmpstr+= ','
next
uri += "&State=" + tmpstr

tmpstr = ""
for i = 1 to upperbound(itemcode)
	tmpstr += string(itemcode[i]) 
	if i < upperbound(itemcode) then tmpstr+= ','
next
uri += "&ItemCode=" + tmpstr
uri += "&Order=" + order
uri += "&Page=" + string(page)
uri += "&PerPage=" + string(perPage)

dic = httpget(uri,corpnum,"")

result = tostmtsearchresult(dic)
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

public function response attachstatement (string corpnum, string itemcodestr, string mgtkey, string subitemcode, string submgtkey) throws popbillexception;
response result
oleobject dic
string postData, itemcode

itemcode = getitemcode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{'
postData += '"ItemCode":"'+escapestring(subitemcode)+'",'
postData += '"MgtKey":"'+escapestring(submgtkey)+'"'
postData += '}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey + "/AttachStmt" ,corpnum,postData,"","")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

public function response detachstatement (string corpnum, string itemcodestr, string mgtkey, string subitemcode, string submgtkey) throws popbillexception;
response result
oleobject dic
string postData, itemcode

itemcode = getitemcode(itemcodeStr)

if isnull(corpnum) or corpnum = "" then throw exception.setCodeNMessage(-99999999,"회원 사업자번호가 입력되지 않았습니다.")
if isnull(MgtKey) or MgtKey = "" then throw exception.setCodeNMessage(-99999999,"관리번호가 입력되지 않았습니다.")

postData = '{'
postData += '"ItemCode":"'+escapestring(subitemcode)+'",'
postData += '"MgtKey":"'+escapestring(submgtkey)+'"'
postData += '}'

dic = httppost("/Statement/" + itemcode + "/" + mgtkey + "/DetachStmt" ,corpnum,postData,"","")
result.code = dic.Item("code")
result.message = dic.Item("message")
dic.DisconnectObject()
destroy dic

return result
end function

event constructor;call super::constructor;addscope("121")
addscope("122")
addscope("123")
addscope("124")
addscope("125")
addscope("126")
end event

on statementservice.create
call super::create
end on

on statementservice.destroy
call super::destroy
end on

