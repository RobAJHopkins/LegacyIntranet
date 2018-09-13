<!--#include file="includes/utils2.asp" -->
<%
var host="http://" + Request.ServerVariables("SERVER_NAME") + "/newsfeed/bizplus.xml";
var stories=new Array();
var xml = Server.CreateObject("MSXML2.ServerXMLHTTP");
xml.open("GET",host,false)
try {
  xml.send();
  if(xml.readyState==4 && xml.status==200) {
    var objLst = xml.responseXML.getElementsByTagName("story");
    for(var i=0;i<objLst.length;i++) stories[stories.length]=new storyStruct(objLst[i]);
  }
}
catch (e) {
}
function storyStruct(objLst) {
  this.url=getElement(objLst,"url")
  this.title=getElement(objLst,"title");
  this.summary=getElement(objLst,"summary");F
  this.fullstory=getElement(objLst,"fullstory");
  function getElement(objLst,field) {
    var retval="";
	var tp=objLst.getElementsByTagName(field);
	if(tp.length>0) retval=tp.item(0).text;
	return retval;
  }
}

var user="" + Request.Cookies("USER");
Response.Cookies("USER")=user;
Response.Cookies("USER").expires="27 Apr 2004 00:00:00";
var menu=new Array();
/* Menu structure for homepage boxes - function takes the following format:
- Name: Name of Box
- Abstract: Text to be displayed in box
- Box Name: Title of box to be displayed
- Menu Name: Name of the Drop down menu in the top LHS
- Box image: The image associated with the box, must be in the images directory
- URL: Page to go to once the box is clicked - if it's an iManage page, use the 'showImanageLink' function with the required page as the parameter.
*/
menu[menu.length]=new menuStruct("Knowledge","Links to Knowhow & Library - Precedents, Databases, Websites","Knowledge","Knowledge","law2a.gif","http://algportal/sites/knowledge/Pages/home.aspx");
menu[menu.length]=new menuStruct("Departments & Specialist Practice Groups","Lists Depts. & Practice Group Contact Details & Websites","Departments & Specialist Practice Groups","Dept. & Practice Groups","web2.gif","practice.asp");
menu[menu.length]=new menuStruct("Business Development & Marketing & ","<br> <a style=\"color: green; \" href=\"http://algportal/businessservices/BDMKT/Pages/default.aspx\"></a> ","Business Development & Marketing","Business Development & Marketing","marketing.gif","http://algportal/businessservices/BDMKT/Pages/default.aspx");
menu[menu.length]=new menuStruct("Step Up","Corporate Responsibility Programme <a style=\"color: green;\" href=\"javascript:location.href('http://algportal/businessservices/CR/GS/SitePages/__.aspx')\"><br><u> Energy & Environmental </u></a></b>","Step Up","Step Up","SU.jpg","http://algportal/businessservices/CR");
menu[menu.length]=new menuStruct("Learning & Development","View Learning & Development information","Learning & Development","Learning & Development","communications2.gif","http://algportal/training/Pages/Home.aspx");
menu[menu.length]=new menuStruct("Human Resources","Information about your HR Department","Human Resources","Human Resources","hr2.gif","http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:339:");
menu[menu.length]=new menuStruct("Information Technology","Information about your IT department. <a style=\"color: red;\" href=\"javascript:location.href('http://dmsweb/supportdesk/supisacs.dll')\"><u> Log a call</u></a>","Information Technology","Information Technology","bunnog.png","http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:340:");
menu[menu.length]=new menuStruct("Finance","Links to Finance Information","Finance","Finance","accounts2.gif","http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:1103:");
menu[menu.length]=new menuStruct("Other Links","<a style=\"color: red;\" href=\"javascript:location.href('http://worksite1/WorkSite/scripts/Home.aspx?page=!nrtdms:0:!session:ALGDMS:!database:KNOWHOW:!page:3045:&ext=1')\"><u>GSL Knowhow</u><br></font></a>","Goodbody Secretarial Limited","Other Links","GSL.gif","http://worksite1/WorkSite/scripts/Home.aspx?page=!nrtdms:0:!session:ALGDMS:!database:KNOWHOW:!page:3045:&ext=1");

menu[menu.length]=new menuStruct("General Services & Facilities"," <a style=\"color: green; \" href=\"javascript:location.href('http://worksite1/Worksite/scripts/Home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:362:&tabid=!nrtdms:0:!session:DMS1:!database:MAIN:!Tab:1123331:&&id=')\"><u><b>   ++FIRST AID++    </b></u><br> <a style=\"color: red; \" href=\"javascript:location.href('http://worksite1/generalservices/MeetingRoomPlan.pdf')\"><b>MEETING ROOM PLAN<b></br>","General Services & Facilities","Gen. Services & Facilities","facilities.gif","http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:362:");


menu[menu.length]=new menuStruct("Extranets","<a style=\"color: black;\" href=\"javascript:location.href('http://algportal/businessservices/IT/training/SitePages/Home.aspx')\"> See the IT Training Calendar</a><BR><br><font color=red><strong>FAQs</strong></font>","IT Training","Extranets","training.png","http://algportal/businessservices/IT/training/SitePages/Home.aspx");


menu[menu.length]=new menuStruct("Noticeboard","Great Place to Work <br> ","GPTW","Wellness at ALG","gptw.jpg","http://algportal/businessservices/GPTW/default.aspx");

function menuStruct(name,abstract,box_name,menu_name,box_image,url) {
  this.name=name;
  this.abstract=abstract;
  this.box_name=box_name;
  this.menu_name=menu_name;
  this.box_image=box_image;
  this.url=url;
}
var filterstyle="filter:revealTrans(Duration=0.2, Transition=12);";
var menufilterstyle="filter:progid:DXImageTransform.Microsoft.fade(duration=0.3);"
%>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" 
      type="image/png" 
      href="images/icon.png" />>
<title>Intranet Homepage</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.fieldprtn { font-family: Verdana, Arial, Sans-serif; font-weight: normal; color: #333333; background-color: #D0C6C7; font-size: 10px; width: 80px;; border: 1px #FFFFFF solid;}
</style>
<script language="JavaScript" src="includes/scrolldetails.js"></script>
<script language="JavaScript" src="includes/menudetails.js"></script>
<script language="JavaScript">

// Define the scroller.
var scrollBar = new Scroller(0, 0, 300, 98, 0, 0); // Position on screen of the scrollbar
scrollBar.setColors("#FFFFFF", "#333333", "#333333");
scrollBar.setFont("Verdana, Arial, Helvetica, sans-serif", 1);
scrollBar.setPause(5500); // How much time each item stays on screen for
/*
Add each of the Scrollbar items using the 'addItem()' function below
*/
<%
/*
for(var i=0;i<stories.length;i++) {
  scrollBar.addItem("<b>stories[i].title</b><br>stories[i].summary<br><a href=\"news.asp? Response.write(escape(stories[i].url));\" style=\"color: yellow;\">Read More ></a><br><img src=\"images/spacer.gif\" width=1 height=150>");
}
*/
if(stories.length==0) Response.write("scrollBar.addItem(\"&nbsp;\")");
%>
function gotoCLI() {
  alert('Click \'OK\' below and another box will pop up.  Click \'open\' and CLI will launch.')
  location.href='http://worksite1/knowall/cli.cmd'
//  document.all['cli'].submit();
}
</SCRIPT>
<style>
A { text-decoration: none; }
A:hover { text-decoration: underline; }
.submenu {position:absolute;background-color:#77AADD;width:200;<%=menufilterstyle%>}
</STYLE>
</head>
<body onLoad="// init();" style="cursor: default;" leftmargin=0 topmargin=0>
<%
/*
Each of the menu boxes must have an associated drop down in the top LHS.  The drop down
is a <DIV> item, with a table inside.  The table contains the full contents for the desired
menu box.  Each div item MUST be named according to the menu box name.  For example, if
the Menu Box in the menuStruct above is named 'Human Resources', the drop down DIV must 
have an ID of: 'HumanReourcesmenu_menufull', i.e. any spaces in the Name are removed
and the suffix 'menu_menufull' in order for the drop down to operate correctly.
*/
%>
<DIV ID="Knowledgemenu_menufull" CLASS="submenu" STYLE="width: 284px; background-color:lightgrey; display:none" onMouseOver="showBox('Lawmenu_menufull');" onMouseOut="clearBox('Lawmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">

<tr>
<td onClick="location.href='http://algportal/sites/knowledge/Pages/home.aspx';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Knowledge Page</td>

</tr>



</table>

</DIV>


<DIV ID="DepartmentsSpecialistPracticeGroupsmenu_menufull" CLASS="submenu" STYLE="width: 160px; background-color: lightgrey; display:none" onMouseOver="showBox('DepartmentsSpecialistPracticeGroupsmenu_menufull');" onMouseOut="clearBox('DepartmentsSpecialistPracticeGroupsmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr>
<td width=160 bgcolor="gray" style="border-bottom: 1px white solid; border-right: 1px white solid; color: white; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Departments</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/worksite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:905:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Corporate</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:903:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Banking & Financial Services</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:906:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Litigation & Dispute Resolution</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:907:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Pensions</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:908:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Private Client</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:1238:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Property</td>
</tr>
<tr>
<td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:910:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Tax</td>
</tr>
<tr>
<td width=160 bgcolor="gray" style="border-bottom: 1px white solid; border-right: 1px white solid; color: white; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Specialist Practice Groups</td>
</tr>
<tr>
<td onClick="location.href='practice.asp'" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin; border-right: groove thin;">Click here for Full Listing</td>
</tr>
</table>
</DIV>

<DIV ID="Committeesmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none" onMouseOver="showBox('hrmenu_menufull');" onMouseOut="clearBox('hrmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:967:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Management Committee</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:964:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Policy Committee</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:970:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Professional Practices Committee</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:968:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Administration Committee</td></tr>
<tr><td onClick="location.href='http://worksite1/social/newsite/index.htm';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Social Committee</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:971:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Charities Committee</td></tr>
</table>
</DIV>

<DIV ID="Extranetsmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:1713:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Extranets</td></tr>
</table>
</DIV>

<DIV ID="Marketingmenu_menufull" CLASS="submenu" STYLE="width: 140px; background-color: lightgrey; display:none" onMouseOver="showBox('Business_Development_Marketingtmenu_menufull');" onMouseOut="clearBox('Business_Development_Marketingmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://algportal/businessservices/BDMKT/Pages/default.aspx';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Marketing Home Page</td></tr>
</table>
</DIV>


<DIV ID="HumanResourcesmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none" onMouseOver="showBox('hrmenu_menufull');" onMouseOut="clearBox('hrmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:339:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Introduction</td></tr>
<tr><td onClick="location.href='/hr/newsletter/default.asp'" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Newsletters</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:339:&tabid=item-7';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">HR Forms</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:339:&tabid=item-15';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Vacancies</td></tr>
</table>
</DIV>

<DIV ID="InformationTechnologymenu_menufull" CLASS="submenu" STYLE="width: 140px; background-color: lightgrey; display:none" onMouseOver="showBox('itmenu_menufull');" onMouseOut="clearBox('itmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:340:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">IT Department Personnel</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:340:&tabid=item-4';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">IT Training/Keystone Manuals</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:340:&tabid=item-1';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Helpdesk & Operations</td></tr>
</table>
</DIV>


<DIV ID="Accountsmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none" onMouseOver="showBox('accmenu_menufull');" onMouseOut="clearBox('accmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<!-- <tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:361:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Accounts Personnel</td></tr>
-->
<tr><td style="cursor: default; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Under Construction</td></tr>
</table>
</DIV>

<DIV ID="GeneralServicesFacilitiesmenu_menufull" CLASS="submenu" STYLE="width: 140px; background-color: lightgrey; display:none" onMouseOver="showBox('facmenu_menufull');" onMouseOut="clearBox('facmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:362:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Safety Information Guide</td></tr>
<tr><td onClick="location.href='http://worksite1/GeneralServices/meetingroomplan.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Meeting Room Plan</td></tr>
</table>
</DIV>

<DIV ID="OtherLinksmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none" onMouseOver="showBox('otherlinksmenu_menufull');" onMouseOut="clearBox('otherlinksmenu_menufull');">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">

<tr><td onClick="location.href='http://worksite1/employeemanual/Exigent/ExigentCribSheet.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Exigent - Guidelines</td></tr>

<tr><td onClick="location.href='http://worksite1/employeemanual/socialmedia.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Social Media - Guidelines</td></tr>


<tr><td onClick="location.href='http://www.bankofireland.com/ALGoodbody';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Bank at Work</td></tr>

<tr><td onClick="location.href='http://worksite1/employeemanual/secondment.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Secondment Info</td></tr>

<tr><td onClick="location.href='/JuniorAchievement/A&LGoodbody2011.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Junior Achievement</td></tr>


<tr><td onClick="location.href='http://intranet/services/noticeboard/default.aspx';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Noticeboard</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:778:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Gym</td></tr>
<tr><td onClick="location.href='http://worksite1/offers/ALG&Renault.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Renault Service Offer</td></tr>
<tr><td onClick="location.href='http://algs.stems.ie/';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Flowers</td></tr>
<tr><td onClick="location.href='/imanagelink.asp?497374:1:MAIN';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Croline Rota</td></tr>
<tr><td onClick="location.href='/imanagelink.asp?330666:1:MAIN';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">GSL Company Distrib. List</td></tr>
<tr><td onClick="location.href='http://worksite1/club/The%20Club%20Directory%202012.pdf';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">The Club Directory</td></tr>
<tr><td onClick="location.href='http://worksite1/general/fooddrink/booklunch.asp';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Book A Client Lunch</td></tr></table>



</DIV>
<DIV ID="Noticeboardmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://www.employeesfirst.ie/resources/';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Wellness at ALG</td></tr>
</table>
</DIV>





<DIV ID="Financemenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:1103:';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px; border-bottom: groove thin;">Finance General</td></tr>
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=!nrtdms:0:!session:dms1:!database:MAIN:!page:1103:&tabid=item-1';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Keystone Upgrade</td></tr></table>
</table>
</div>

<DIV ID="TrainingDevelopmentmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://moodle.algoodbody.ie/';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">T&D Home Page</td></tr></table>
</table>
</div>

<DIV ID="MoneyLaunderingmenu_menufull" CLASS="submenu" STYLE="width: 141px; background-color: lightgrey; display:none">
<table border=0 width=100% cellpadding=0 cellspacing=0 style="border-top: groove thin; border-left: 1px white solid; border-right: groove thin; border-bottom: groove thin; font: 8pt arial;">
<tr><td onClick="location.href='http://worksite1/WorkSite/scripts/home.aspx?page=%24nrtdms%3B0%3B%24session%3Bdms1%3B%24database%3BKNOWHOW%3B%24page%3B1069%3B&ext=1';" onMouseOver="this.style.backgroundColor='navy'; this.style.color='white';" onMouseOut="this.style.color='black'; this.style.backgroundColor='lightgrey';" style="cursor: hand; padding-left: 3px; padding-bottom: 3px; padding-top: 3px;">Money Laundering</td></tr></table>
</table>
</div>
<center>
<table border=0 width=760 cellpadding=0 cellspacing=0>
<tr><td valign=top style="border-left: 3px white solid; border-right: 2px white solid; border-top: 2px white solid;" bgcolor="#333333"><table border=0 cellpadding=0 cellspacing=0>
<tr><td colspan=4><img src="images/spacer.gif" width=299 height=1></td></tr>
<tr><td valign=top align=center><table border=0 width="98%" cellpadding=0 cellspacing=0 style="font: 8pt arial;">
<tr><td align=left style="padding: 4px;">
<img src="images/3.3.2 logo_NewColour.png"  border="0" alt=""></td>
<td align=right><img src="images/spacer.gif" width=1 height=1><br>
  </td>
</tr>
<tr><td colspan=2 align=center><table border=0 width=100% style="font: 8pt arial;">
<tr><td><table border=0 cellpadding=0 cellspacing=0 style="font: 8pt arial;color: #2cd5c4;">
<tr><td colspan=3><u><b>Quick Links:</b></u>  - Click a section for full contents</td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<% showMenuButtons(); %>
</table>
<tr><td border=1>
<center><a href="objective.asp"><img border=0 src="images/objectives.png"></a></center>
</td></tr>
<tr><td border=1>
<center><a href="/employeemanual/"><img border=0 src="images/manual.png"></a></center>
</td></tr>
<tr><td border=1>
<center><a href="http://www.algoodbody.com\news"><img border=0 src="images/legalnews.png"></a></center>
</td></tr>
<tr><td border=1>
<center><a href="http://worksite1/iso/iso.asp"><img border=0 src="images/BelfastCaR.png"></a></center>
</td></tr>
<tr><td border=1>
<center><a href="/Safety/default.asp"><img border=0 src="images/safety.png"></a></center>
</td></tr>
</td></tr></table>
</td></tr>
</table></td>

<td><img src="images/spacer.gif" width=1 height=160></td>
</tr>
<tr><td align=center>
<div style="width:200px;height:25px;border:2px solid white;">
<center>
<a style="color: white;"  style="font: 12pt arial; color: white; text-align: center;" href="http://algportal/notice/SitePages/Home.aspx"> ALG Noticeboard</a></center>
</div>
</td><td colspan=2><img src="images/greybottom.gif" width="12" height="11" border="0" alt=""></td></tr>
</table></td>
<td valign=top width=461 bgcolor="#333333" style="border-top: 2px white solid;"><table border=0 cellpadding=0 cellspacing=0>
<tr><td colspan=2><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td></td><td style="font: 8pt arial; color: white;"><b><%
var now=new Date();
Response.write(days[now.getDay()] + ", " + now.getDate());
if(now.getDate()==1 || now.getDate()==21 || now.getDate()==31) Response.write("st");
else if(now.getDate()==2 || now.getDate()==22) Response.write("nd");
else if(now.getDate()==3 || now.getDate()==23) Response.write("rd");
else Response.write("th");
Response.write(" " + months[now.getMonth()] + " " + now.getFullYear());
%></b></td></tr>
<tr><td colspan=2><img src="images/spacer.gif" width=1 height=1></td></tr>
<tr><td colspan=2>
<tr><td><img src="images/spacer.gif" width=10 height=1></td>
<td><table border=0 cellpadding=0 cellspacing=0>
<tr>
<td><img src="images/businessnews.gif" width="252" height="17" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=5 height=1></td>
<td><img src="images/internet_links.gif" width=120 height=17></td>
</tr>
<tr><td style="font: 8pt arial white; color: white; border: 1px  solid;  background-color: #333333;">
<style type="text/css">
A:link { text-decoration: none; color: white;}
A:visited {text-decoration: none; color: white;}
A:active {text-decoration: none; color: white;}
A:hover {text-decoration: underline; color: white;}
</style>


<div id="widgetmain" style="border: 0px solid rgb(51, 51, 51); border-image: none; width: 250px; text-align: left; -ms-overflow-x: hidden; -ms-overflow-y: auto;" bgcolor="005Daa">
<!-- start sw-rss-feed code --> 
<script type="text/javascript"> 
<!-- 
rssfeed_url = new Array(); 
rssfeed_url[0]="https://www.rte.ie/news/rss/business-headlines.xml";  
rssfeed_frame_width="250"; 
rssfeed_frame_height="200"; 
rssfeed_scroll="on"; 
rssfeed_scroll_step="6"; 
rssfeed_scroll_bar="off"; 
rssfeed_target="_blank"; 
rssfeed_font_size="10"; 
rssfeed_font_face=""; 
rssfeed_border="on"; 
rssfeed_css_url=""; 
rssfeed_title="off"; 
rssfeed_title_name=""; 
rssfeed_title_bgcolor="#333333"; 
rssfeed_title_color="#005daa"; 
rssfeed_title_bgimage=""; 
rssfeed_footer="off"; 
rssfeed_footer_name="rss feed"; 
rssfeed_footer_bgcolor="#333333"; 
rssfeed_footer_color="#333"; 
rssfeed_footer_bgimage=""; 
rssfeed_item_title_length="50"; 
rssfeed_item_title_color="#fff"; 
rssfeed_item_bgcolor="#333333"; 
rssfeed_item_bgimage=""; 
rssfeed_item_border_bottom="on"; 
rssfeed_item_source_icon="off"; 
rssfeed_item_date="off"; 
rssfeed_item_description="on"; 
rssfeed_item_description_length="120"; 
rssfeed_item_description_color="#fff"; 
rssfeed_item_description_link_color="#333"; 
rssfeed_item_description_tag="off"; 
rssfeed_no_items="0"; 
rssfeed_cache = "cbcea1d068055e209d10d5c3090ee038"; 
//--> 
</script> 
<script type="text/javascript" src="//feed.surfing-waves.com/js/rss-feed.js"></script> 
<!-- The link below helps keep this service FREE, and helps other people find the SW widget. Please be cool and keep it! Thanks. --> 
<div style="text-align:right; width:250px;"><a href="http://www.surfing-waves.com/feed.htm" target="_blank" style="color:#ccc;font-size:10px">feedwidget @</a> <a href="http://www.surfing-waves.com" target="_blank" style="color:#ccc;font-size:10px">Surfing Waves</a></div> 
<!-- end sw-rss-feed code -->



</noscript>

</td><td></td>
<td valign=center style="border-left: 1px white solid; border-bottom: 1px white solid; border-right: 1px white solid;"><table border=0 cellpadding=0 cellspacing=0 width=118 style="font: 8pt arial; color: white;">
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;" href="http://www.algoodbody.com">A&L Goodbody</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;" href="http://worksite1/club/The%20Club%20Directory%202014.pdf">The Club Directory</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;" href="http://worksite1/TelephoneDirectoryEnquires.asp">Telephone Directory Enquires</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;" href="http://www.google.ie">Google</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>

<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;" href="admin/mail.asp">Request Presentation</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;"href = "http://algportal/businessservices/TP/SitePages/Home.aspx">Trainee Solicitors</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;"href = "http://clients.premiereglobal.eu/algoodbody/
">Teleconferencing</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td valign=top><img src="images/wht.gif" width="9" height="12" border="0" alt=""></td>
<td><img src="images/spacer.gif" width=3 height=1></td>
<td><a style="color: white;"href = "http://algportal/businessservices/rooms/SitePages/Home.aspx
">Temporary Meeting Rooms</a></td></tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
</table></td>
</tr>
</table></td></tr>

<tr><td colspan=2><img src="images/spacer.gif" width=1 height=5></td></tr>
<tr><td></td>
<td align=center><table border=0 cellpadding=0 cellspacing=0><tr><td><img src="images/internal_personnel_sm3.gif" width="195" height="17" border="0" alt="Type your Search in the Box below"></td>
<td><img src="images/spacer.gif" width=12 height=1></td>
<td><img src="images/restaurant_menu.gif" width="170" height="17" border="0" alt=""></td></tr>
<tr><td style="border: 1px white solid;" align=center><table border=0 cellpadding=0 cellspacing=0>


	

<tr><td>	   
             
		<a style="color: white;" href="http://worksite1/advancedsearch/staffsearch.asp"><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Click Here To Search</a>
	</td>
<td><img src="images/spacer" width=1 height=25></td>
<td><br><img src="images/spacer.gif" width=1 height=1></td>
</tr>

</table>
</td><td></td>
<%
if(hasMenu) {
%>
<td align=center onClick="window.open('todaysmenu.asp','menu','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=yes,resizable=0,width=370,height=400'); return false"; onMouseOut="this.style.textDecoration='none';" onMouseOver="this.style.textDecoration='underline';" style="cursor: hand; border-left: 1px white solid; border-bottom: 1px white solid; border-right: 1px white solid; font: 8pt arial; color: white;">
Today's Menu: <% Response.write(now.getDate() + " " + smmonths[now.getMonth()] + " " + now.getFullYear()); %></td>
<%
}
else {
%>
<td align=center style="border-left: 1px white solid; border-bottom: 1px white solid; border-right: 1px white solid; font: 8pt arial; color: white;">
Today's Menu is not yet available 

<%
}
%>
</tr>
<tr><td colspan="2"  valign=top align="right">
<center>
<img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #2cd5c4;" style="font: 8pt arial; color: white;" href="http://worksite1/travelrequest">Travel Request Form</a> 


<img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #2cd5c4;" style="font: 8pt arial; color: white;" href="
http://www.thedx.ie/corporate/customer-area/more-about-dx-exchange/member-directory-services/online-directory/
">Hayes DX</a> 

&nbsp;&nbsp;&nbsp;
</center>
</td>
<td>
<!-- <left><img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #2cd5c4;" style="font: 8pt arial; color: white;" href="http://inventory/facilities/restaurant.asp" target="_blank">OLD Prox Bal</a>
 --><left><img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #2cd5c4;" style="font: 8pt arial; color: white;" href="http://inventory/facilities/midasrestaurant.asp" target="_blank">Proximity Bal</a>
<left><img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #2cd5c4;" style="font: 8pt arial; color: white;" href="http://worksite1/canteen/ordersand.asp">Order Sandwich</a> 
<br> 

<!-- 
<img src="images/wht.gif" width="9" height="12" border="0" alt=""><a style="color: #FF9900;" style="font: 8pt arial; color: white;" href="http://worksite1/WorkSite/scripts/Home.aspx?page=!nrtdms%3A0%3A!session%3AALGDMS%3A!database%3AMAIN%3A!page%3A362%3A&tabid=!nrtdms%3A0%3A!session%3AALGDMS%3A!database%3AMAIN%3A!Tab%3A1323225%3A">Restaurant News</a></left>   -->



<p>

</tr></td>

</table>
<table>
<tr>
<td>
<a href="http://algportal/sites/cs">  <img src="images/Algorithm-logo.png" width="200" height="50" border="0"> </a></center>
</td>
</tr>
</table>

</td></tr>
</a></center> 

</table>
</td>

<td align=right valign=top bgcolor="#333333"><img src="images/blue_corner.gif"></td>

</tr>
<tr><td colspan=3><img src="images/spacer.gif" width=1 height=2></td></tr>
<tr><td colspan=3 style="border-left: 3px white solid;" bgcolor="#2cd5c4"><table border=0 cellpadding=0 cellspacing=0>
<tr><td><img src="images/spacer.gif" width=6 height=18></td>
<td style="font: 8pt arial;"><b>Intranet Sections - Click a section for full details</b></td></tr>
</table></td></tr>
<tr><td colspan=3 bgcolor="white"><img src="images/spacer.gif" width=1 height=2></td></tr>
</table>
<% showMenuBoxes() %>
<p>
<form method="get" name="cli" id="cli" action="file://ifsc_fileserv/applications/Legal%20Journals/Current%20Legal%20Information.lnk"></form>
<iframe name="searchframe" src="about:" style="display: none;"></iframe>
</table><p>
</body>
</html>
