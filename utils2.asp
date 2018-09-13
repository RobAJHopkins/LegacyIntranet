<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<%
String.prototype.noSpaces=_noSpaces;
var days=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");
var months=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
var smmonths=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
var hasMenu=false;
var Conn=openDatabase();
var now=new Date();
var sql="SELECT * FROM menu WHERE menu_date='" + now.getDate() + " " + months[now.getMonth()] + " " + now.getFullYear() + "' ORDER BY menuID DESC";
var qs=Conn.Execute(sql);
if(!qs.EOF) hasMenu=true;

function openDatabase() {
  var Conn=Server.CreateObject("ADODB.Connection");
  Conn.open("Intranet", "alternatesa", "4lt3rn4t354");
  return Conn;
}

function showMenuBoxes() {
%>

<table border=0 width=758 style="border-left: 2px white solid;" cellpadding=0 cellspacing=0>
<%
var count=0;
for(var i=0;i<menu.length;i++) {
  if(count==0) {
	if(i>0) {
	  Response.write("<tr>");
	  for(var j=0;j<4;j++) {
	    Response.write("<td ");
		if(menu[(i+j-4)].url.length>0) {
  		  Response.write("onClick=\"");
  	      if(menu[(i+j-4)].url.toLowerCase().indexOf("showimanagelink")==-1) Response.write("location.href='" + menu[(i+j-4)].url + "'");
  	      else Response.write(menu[(i+j-4)].url);
		  Response.write(";\" ");
          Response.write("onmouseout=\"unhighlightbox(this,'" + menu[(i+j-4)].name + "');\" onMouseOver=\"highlightbox(this,'" + menu[(i+j-4)].name + "');\" ");
          Response.write("style=\"" + filterstyle + " cursor: hand;\" ");
		}
        Response.write("bgcolor=\"#C1BEB8\" id=\"" + menu[(i+j-4)].name + "2\"><img src=\"images/greybottom.gif\"></td><td></td>\n");
	  }
	  Response.write("</tr>");
      Response.write("<tr><td colspan=5 bgcolor=\"white\"><img src=\"images/spacer.gif\" width=1 height=2></td></tr>\n");
	}
    Response.write("<tr>");
  }
%>
  <td width=25% height=100% id="<%=menu[i].name%>1" <%
  if(menu[i].url.length>0) {
    Response.write("onClick=\"");
    if(menu[i].url.toLowerCase().indexOf("showimanagelink")==-1) Response.write("location.href='" + menu[i].url + "'");
	else Response.write(menu[i].url);
    Response.write(";\" style=\"" + filterstyle + " cursor: hand;\" onmouseout=\"unhighlightbox(this,'" + menu[i].name + "');\" onMouseOver=\"highlightbox(this,'" + menu[i].name + "');\"");
  }
  %>  bgcolor="#C1BEB8" valign=top><table border=0 cellpadding=0 cellspacing=0 style="font: 11px arial;"><tr><td colspan=4 align=right><img src="images/greytop2.gif" width="12" height="11" border="0" alt=""></td></tr>
	  <tr>
  <td><img src="images/spacer.gif" width=4 height=1></td>
  <td valign=top width=100% id="<%=menu[i].name%>txt"><b><u><%=menu[i].box_name%></b></u><br>
  <%=menu[i].abstract%>
  </td>
  <td valign=top><img src="images/<%=menu[i].box_image%>" width="35" height="50" border="0" alt=""></td>
  <td><img src="images/spacer.gif" width=6 height=50></td></tr>
  </table></td>
<%
  if(count!=3) Response.write("<td bgcolor=\"white\"><img src=\"images/spacer.gif\" width=2 height=1 border=0></td>\n");
  count++;
  if(count==4) {
    count=0;
    Response.write("</tr>");
  }
}
Response.write("<tr>");
if(count==0) count=4;
for(var j=0;j<count;j++) {
  Response.write("<td ");
  if(menu[(i+j-count)].url.length>0) {
    Response.write("style=\"" + filterstyle + " cursor: hand;\" onClick=\"");
    if(menu[(i+j-count)].url.toLowerCase().indexOf("showimanagelink")==-1) Response.write("location.href='" + menu[(i+j-count)].url + "'");
    else Response.write(menu[(i+j-count)].url);
    Response.write("\" onmouseout=\"unhighlightbox(this,'" + menu[i+j-count].name + "');\" onMouseOver=\"highlightbox(this,'" + menu[i+j-count].name + "');\"");
  }
  Response.write(" bgcolor=\"#C1BEB8\" id=\"" + menu[(i+j-count)].name +"2\"><img src=\"images/greybottom.gif\"></td><td></td>\n");
}
Response.write("</tr>");
}

function showMenuButtons() {
  var count=0;
  for(var i=0;i<menu.length;i++) {
    if(i>0 && count==0) Response.write("<tr><td colspan=3><img src=\"images/spacer.gif\" width=1 height=3></td></tr>\n");
    if(count==0) Response.write("<tr>");
    else Response.write("<td><img src=\"images/spacer.gif\" width=5 height=1></td>\n");
    Response.write("<td id=\"" + menu[i].name.noSpaces() + "menu\" onMouseOver=\"menu_hl('" + menu[i].name.noSpaces() + "menu');\" onmouseout=\"menu_unhl('" + menu[i].name.noSpaces() + "menu');\" style=\"" + filterstyle + " cursor: hand; border: 1px white solid; width: 140px; padding-left: 3px;\" bgcolor=\"#CBCBD9\" title=\"" + menu[i].name.noSpaces() + "\"><DIV ID=\"" + menu[i].name.noSpaces() + "menu_menu\" onClick=\"show(this," + menu[i].name.noSpaces() + "menu_menufull);\" class=\"menu\"><table border=0 cellpadding=0 cellspacing width=100% style=\"font: 8pt arial;\"><tr><td width=100% id=\"" + menu[i].name.noSpaces() + "menutxt\">" + menu[i].menu_name + "</td>\n");
    Response.write("<td><img src=\"images/wht2.gif\"></td>\n");
    Response.write("<td><img src=\"images/spacer.gif\" width=5 height=1></td>\n");
    Response.write("</tr></table></div></td>\n");
    count++;
    if(count==2) {
      count=0;
  	Response.write("</tr>\n");
    }
  }
}

function _noSpaces() {
  var retval="" + this;
  var re1=new RegExp(" ",["gi"]);
  var re2=new RegExp("&",["gi"]);
  retval=retval.replace(re1,"");
  retval=retval.replace(re2,"");
  return retval;
}
%>
