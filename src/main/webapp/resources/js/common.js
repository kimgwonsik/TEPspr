function isNullCheck(str) {
    if (str == null) return true;
    if (str == "NaN") return true;
    if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}

function isLoginCheck(sessionID) {
	if (isNullCheck(sessionID)) {
		alertify.error("로그인 상태가 아닙니다.");
		return false;
	} else {
		return true;
	}
}

function CustomSubmit(opt_formId) {
    this.formId = isNullCheck(opt_formId) == true ? "commonForm" : opt_formId;
    this.url = "";
     
    if(this.formId == "commonForm"){
        $("#commonForm")[0].reset();
    }
     
    this.setUrl = function setUrl(url){
        this.url = url;
    };
     
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
    };
     
    this.submit = function submit(method){
        var frm = $("#"+this.formId)[0];
        frm.action = this.url;
        frm.method = isNullCheck(method) ? "POST":method;
        frm.submit();   
    };
}