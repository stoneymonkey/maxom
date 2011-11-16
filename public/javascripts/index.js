// Set Document Title
document.title = "Main Page :: Maxom";

var _payroll_date_ = null;

/*function getAccountBalance(form, URL)
{
 var element = getSelectedObj(form);
 if (element == "null") { return; }
 location.reload(URL);
 NewWindow("AccountBalances.jsp?tbl="+element, "none"+RandomValue(), 200, 200, "no");

}*/

function getAccountBalance(bank, URL)
{
 alert("test");
 var element = bank;
 if (element == "null") { return; }
 //location.reload(URL);
 NewWindow("AccountBalances.jsp?tbl="+element, "none"+RandomValue(), 200, 200, "no");

}

function getPayrollBookkeeper(){
  if (_payroll_date_ == "null") { return; }
  NewWindow("Payroll_Bookkeeper.jsp?date="+_payroll_date_,"none"+RandomValue(), 700, 400, "yes");
  document.forms[0].payroll_bk.value = "2004-"
}

function setViewTarget(value) {
 if (value == "null") { return; }
 _payroll_date_ = value;
}