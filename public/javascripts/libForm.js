<!--
function submitIt(){
	document.forms[0].submit();
}

function getSelectedObj(form)
{
 //var listObj = form;
 //var listlength = listObj.length;
 //for (var i = 0; i < listlength; i++) 
 //{
  //if (listObj.options[i].selected)
  //{
   //return listObj.options[i].value;
  //}
 //}
 //return null;
 return form.options[form.selectedIndex].value;
}

function NewWindow(mypage, myname, w, h, scroll)
{
  var winl = (screen.width - w) / 2;
  var wint = (screen.height - h) / 2;
  winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable,locationbar,toolbar=yes';
  win = window.open(mypage, myname, winprops);
   if (parseInt(navigator.appVersion) >= 4)
   { 
    win.window.focus();
   }
}

function RandomValue(r) {
	r = Math.round(Math.random() * 100) + 1;
	return r;
}

function getHostName()
{
 var hostname = location.hostname;
 return hostname;
}

function getPort()
{
 var port = location.port;
 return port;
}

function resetPage(page)
{
 // Removed "location.replace" to avoid disabling the back-button browser.
 // Opps...I had to put it back. Window.location would not work.
 location.replace("http://" + getHostName() + ":" + getPort() + page);
}


// overly simplistic test for IE
isIE = (document.all ? true : false);
// both IE5 and NS6 are DOM-compliant
isDOM = (document.getElementById ? true : false);

// get the true offset of anything on NS4, IE4/5 & NS6, even if it's in a table!
function getAbsX(elt) { return (elt.x) ? elt.x : getAbsPos(elt,"Left"); }
function getAbsY(elt) { return (elt.y) ? elt.y : getAbsPos(elt,"Top"); }
function getAbsPos(elt,which) {
 iPos = 0;
 while (elt != null) {
  iPos += elt["offset" + which];
  elt = elt.offsetParent;
 }
 return iPos;
}

function getDivStyle(divname) {
 var style;
 if (isDOM) { style = document.getElementById(divname).style; }
 else { style = isIE ? document.all[divname].style
                     : document.layers[divname]; } // NS4
 return style;
}

function hideElement(divname) {
 getDivStyle(divname).visibility = 'hidden';
}

// annoying detail: IE and NS6 store elt.top and elt.left as strings.
function moveBy(elt,deltaX,deltaY) {
 elt.left = parseInt(elt.left) + deltaX;
 elt.top = parseInt(elt.top) + deltaY;
}

function toggleVisible(divname) {
 divstyle = getDivStyle(divname);
 if (divstyle.visibility == 'visible' || divstyle.visibility == 'show') {
   divstyle.visibility = 'hidden';
 } else {
   fixPosition(divname);
   divstyle.visibility = 'visible';
 }
}

function setPosition(elt,positionername,isPlacedUnder) {
 var positioner;
 if (isIE) {
  positioner = document.all[positionername];
 } else {
  if (isDOM) {
    positioner = document.getElementById(positionername);
  } else {
    // not IE, not DOM (probably NS4)
    // if the positioner is inside a netscape4 layer this will *not* find it.
    // I should write a finder function which will recurse through all layers
    // until it finds the named image...
    positioner = document.images[positionername];
  }
 }
 elt.left = getAbsX(positioner)-25;
 elt.top = getAbsY(positioner)+ 20 + (isPlacedUnder ? positioner.height : 0);
}
   

   // how reliable is this test?
         isIE = (document.all ? true : false);
	 isDOM = (document.getElementById ? true : false);

         // Initialize arrays.
         var months = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
	 "Aug", "Sep", "Oct", "Nov", "Dec");
         var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31,
            30, 31, 30, 31);
	 var displayMonth = new Date().getMonth();
	 var displayYear = new Date().getFullYear();
	 var displayDivName;
	 var displayElement;

         function getDays(month, year) {
            // Test for leap year when February is selected.
            if (1 == month)
               return ((0 == year % 4) && (0 != (year % 100))) ||
                  (0 == year % 400) ? 29 : 28;
            else
               return daysInMonth[month];
         }

         function getToday() {
            // Generate today's date.
            this.now = new Date();
            this.year = this.now.getFullYear();
            this.month = this.now.getMonth();
            this.day = this.now.getDate();
         }

         // Start with a calendar for today.
         today = new getToday();

         function newCalendar(eltName,attachedElement) {
	    if (attachedElement) {
	       if (displayDivName && displayDivName != eltName) hideElement(displayDivName);
	       displayElement = attachedElement;
	    }
	    displayDivName = eltName;
            today = new getToday();
            var parseYear = parseInt(displayYear + '');
            var newCal = new Date(parseYear,displayMonth,1);
            var day = -1;
            var startDayOfWeek = newCal.getDay();
            if ((today.year == newCal.getFullYear()) &&
                  (today.month == newCal.getMonth()))
	    {
               day = today.day;
            }
            var intDaysInMonth =
               getDays(newCal.getMonth(), newCal.getFullYear());
            var daysGrid = makeDaysGrid(startDayOfWeek,day,intDaysInMonth,newCal,eltName)
	    if (isIE) {
	       var elt = document.all[eltName];
	       elt.innerHTML = daysGrid;
            } else if (isDOM) {
	       var elt = document.getElementById(eltName);
	       elt.innerHTML = daysGrid;
	    } else {
	       var elt = document.layers[eltName].document;
	       elt.open();
	       elt.write(daysGrid);
	       elt.close();
	    }
	 }

	 function incMonth(delta,eltName) {
	   displayMonth += delta;
	   if (displayMonth >= 12) {
	     displayMonth = 0;
	     incYear(1,eltName);
	   } else if (displayMonth <= -1) {
	     displayMonth = 11;
	     incYear(-1,eltName);
	   } else {
	     newCalendar(eltName);
	   }
	 }

	 function incYear(delta,eltName) {
	   displayYear = parseInt(displayYear + '') + delta;
	   newCalendar(eltName);
	 }

	 function makeDaysGrid(startDay,day,intDaysInMonth,newCal,eltName) {
	    var daysGrid;
	    var month = newCal.getMonth();
	    var year = newCal.getFullYear();
	    var isThisYear = (year == new Date().getFullYear());
	    var isThisMonth = (day > -1)
	    daysGrid = '<table border=1 cellspacing=0 cellpadding=2><tr><td bgcolor=#ffffff nowrap>';
	    daysGrid += '<font face="courier new, courier" size=2>';
	    daysGrid += '<a href="javascript:hideElement(\'' + eltName + '\')">x</a>';
	    daysGrid += '&nbsp;&nbsp;';
	    daysGrid += '<a href="javascript:incMonth(-1,\'' + eltName + '\')">&laquo; </a>';

	    daysGrid += '<b>';
	    if (isThisMonth) { daysGrid += '<font color=red>' + months[month] + '</font>'; }
	    else { daysGrid += months[month]; }
	    daysGrid += '</b>';

	    daysGrid += '<a href="javascript:incMonth(1,\'' + eltName + '\')"> &raquo;</a>';
	    daysGrid += '&nbsp;&nbsp;&nbsp;';
	    daysGrid += '<a href="javascript:incYear(-1,\'' + eltName + '\')">&laquo; </a>';

	    daysGrid += '<b>';
	    if (isThisYear) { daysGrid += '<font color=red>' + year + '</font>'; }
	    else { daysGrid += ''+year; }
	    daysGrid += '</b>';

	    daysGrid += '<a href="javascript:incYear(1,\'' + eltName + '\')"> &raquo;</a><br>';
	    daysGrid += '&nbsp;Su Mo Tu We Th Fr Sa&nbsp;<br>&nbsp;';
	    var dayOfMonthOfFirstSunday = (7 - startDay + 1);
	    for (var intWeek = 0; intWeek < 6; intWeek++) {
	       var dayOfMonth;
	       for (var intDay = 0; intDay < 7; intDay++) {
	         dayOfMonth = (intWeek * 7) + intDay + dayOfMonthOfFirstSunday - 7;
		 if (dayOfMonth <= 0) {
	           daysGrid += "&nbsp;&nbsp; ";
		 } else if (dayOfMonth <= intDaysInMonth) {
		   var color = "blue";
		   if (day > 0 && day == dayOfMonth) color="red";
		   daysGrid += '<a href="javascript:setDay(';
		   daysGrid += dayOfMonth + ',\'' + eltName + '\')" '
		   daysGrid += 'style="color:' + color + '">';
		   var dayString = dayOfMonth + "</a> ";
		   if (dayString.length == 6) dayString = '0' + dayString;
		   daysGrid += dayString;
		 }
	       }
	       if (dayOfMonth < intDaysInMonth) daysGrid += "<br>&nbsp;";
	    }
	    return daysGrid + "</td></tr></table>";
	 }

	 function setDay(day,eltName) {
	   //displayElement.value = (displayMonth + 1) + "/" + day + "/" + displayYear;
         displayElement.value =  displayYear+ "-" +(displayMonth + 1)  + "-" + day;
	   hideElement(eltName);
	 }

// fixPosition() attaches the element named eltname
// to an image named eltname+'Pos'
//
function fixPosition(divname) {
 divstyle = getDivStyle(divname);
 positionerImgName = divname + 'Pos';
 // hint: try setting isPlacedUnder to false
 isPlacedUnder = false;
 if (isPlacedUnder) {
  setPosition(divstyle,positionerImgName,true);
 } else {
  setPosition(divstyle,positionerImgName)
 }
}

function toggleDatePicker(eltName,formElt) {
  var x = formElt.indexOf('.');
  var formName = formElt.substring(0,x);
  var formEltName = formElt.substring(x+1);
  newCalendar(eltName,document.forms[formName].elements[formEltName]);
  toggleVisible(eltName);
}

// fixPositions() puts everything back in the right place after a resize.
function fixPositions()
{
 // add a fixPosition call here for every element
 // you think might get stranded in a resize/reflow.
 fixPosition('daysOfMonth');
 fixPosition('daysOfMonth2');
}

function validate(elem, option){
   //var  tType = getSelectedObj(option);
   var val = option.options[option.selectedIndex].value
   var amt = elem.value;
   if (parseInt(tType) == 0 ) { return; }
   if ( (parseInt(tType) == 3) || (parseInt(tType) == 4) || (parseInt(tType) == 5) ) {
       if (amt.indexOf("-") == 0 )
        { 
          //alert("It seems a negative sign was added by mistake, please correct.");
          var newStr = amt.substring(1,amt.length);
          
          elem.value = newStr;
        }
   } else {
        if (amt.indexOf("-") != 0)
         {
          elem.value = "-"+amt;
         }
     }

  return;
}

function delete_alert(table, id) {
  var res = "/" + table + "/destroy/" + id
  var answer = confirm ("Please click on OK to continue, or CANCEL to stop the deletion.")
  //var answer = confirm (res)
  if (!answer)
  return
  //else window.location="http://lres.dyndns.org/RemoveItem.jsp?table="+table+"&id="+id
  else resetPage(res)
}

//-->
