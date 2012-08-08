// hello there...
// this is my javascript stuff....

// ....i hope i dont blow anything up!


////////////////////////////////////////////////////////////////////////////////
// COOKIES!!!!

// setting
function setCookie(c_name,value,exdays) {
  var exdate=new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  document.cookie=c_name + "=" + c_value;
}

// getting
function getCookie(c_name) {
  var i,x,y,ARRcookies=document.cookie.split(";");
  for (i=0;i<ARRcookies.length;i++) {
    x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
    y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
    x=x.replace(/^\s+|\s+$/g,"");
    if (x==c_name) {
      return unescape(y);
    }
  }
}

// getting username for logging-in porpuses!
function checkCookie() {
  var username=getCookie("username");
  if (username!=null && username!="") {
    // alert("Welcome again " + username);
  }
  else {
    username=prompt("Please enter your name:","");
    if (username!=null && username!="") {
      setCookie("username",username,1);
    }
  }
}

// clearing cookie
function clearCookie(c_name) {
  // i believe this should work...
  document.cookie=c_name + "="
}

