function menu_hl(inp) {
  showBoxMenu(inp);
  if(document.all[inp].style.backgroundColor=='gray') return;
  document.all[inp].style.backgroundColor='gray';
  document.all[inp].style.cursor='hand';
  document.all[inp + 'txt'].style.color='white';
}

function menu_unhl(inp) {
  clearBoxMenu(inp);
  if(cm!=null) {
    if(cm.style.display!='none') {
      var cmid=cm.id;
	  var parts=cm.id.split("_");
	  if(parts[0]==inp) return;
	}
  }
  var el=event.toElement;
  var found=false;
  while (el) {
    if(el.id==inp) return;
    el=el.parentElement
  }
  document.all[inp].style.backgroundColor='#CBCBD9';
  document.all[inp].style.cursor='hand';
  document.all[inp + 'txt'].style.color='black';
}

function showImanageLink(inp) {
  var new_href='/worksite/showimanagelink.asp?' + escape(inp);
  location.href=new_href;
}


function highlightbox(src,inp) {
  for(var i=1;i<3;i++) {
    if(document.all[inp + i].style.backgroundColor=='gray') return;
    document.all[inp + i].filters.item(0).Apply(); 
    document.all[inp + i].style.backgroundColor='gray';
    document.all[inp + 'txt'].style.color='white';
  }
  document.all[inp + '1'].filters.item(0).Play(); 
  document.all[inp + '2'].filters.item(0).Play(); 
}

function unhighlightbox(src,inp) {
  var el=event.toElement;
  var found=false;
  while (el) {
    if(el.id==inp + '1' || el.id==inp + '2') return;
    el=el.parentElement
  }
  document.all[inp + '1'].style.backgroundColor='#C1BEB8';
  document.all[inp + '2'].style.backgroundColor='#C1BEB8';
  document.all[inp + 'txt'].style.color='black';
}

function searchResults(inp) {
	if (escape(document.all['search'].value) == "showall")
	{
			var url='showlist.asp?' + escape(document.all['search'].value);
			window.open(url,'Results','toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=yes,resizable=1,width=500,height=600'); 
	}
	else
	{
		if(inp.length==0) 
		{
			alert('Sorry, but your Query: \'' + document.all['search'].value + '\' returned no results');
		}
		else {
			var url='showlist.asp?' + inp + ':-:' + escape(document.all['search'].value) + ':-:'  + new Date().valueOf();
			window.open(url,'Results','toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=yes,resizable=0,width=400,height=400'); 
		}
	}
}

function doSearch() {
  if(document.all['search'].value.length==0 || document.all['search'].value=='SEARCH') 
	{
    alert('Please enter the search in the box provided');
    if(document.all['search'].value.length==0) document.all['search'].focus();
  }
  else {
    document.all['searchframe'].src='checksearch.asp?' + escape(document.all['search'].value) + ":-:" + new Date().valueOf();
  }
  return false;
}

var timerID=-1;

var cm=null;
document.onclick = new Function("show()")
function getPos(el,sProp) {
	var iPos = 0
	while (el!=null) {
		iPos+=el["offset" + sProp]
		el = el.offsetParent
	}
	return iPos

}

function show(el,m) {
  try {
    window.event.cancelBubble=true;
    if(m) {
      m.filters.item(0).Apply(); 
  	  m.style.display='';
  	  m.style.pixelLeft = getPos(el,"Left")
	  m.style.pixelTop = getPos(el,"Top") + el.offsetHeight + 4
      m.filters.item(0).Play(); 
      var mid=m.id;
	  var toppart=mid.split("_")[0];
	  document.all[toppart].style.cursor='default';
    }
    if ((m!=cm) && (cm)) {
      var cmid=cm.id;
	  var toppart=cmid.split("_")[0];
      cm.style.display='none';
      document.all[toppart].style.backgroundColor='#CBCBD9';
      document.all[toppart + 'txt'].style.color='black';
    }
    cm=m;
  }
  catch(e) {
  }
}

function closeWindow() {
  if(cm) {
    var cmid=cm.id;
	var toppart=cmid.split("_")[0];
    cm.style.display='none';
    document.all[toppart].style.backgroundColor='#CBCBD9';
    document.all[toppart + 'txt'].style.color='black';
	timerID=-1;
  }
}

function clearBoxMenu(inp) {
  if(cm) {
    var cmid=cm.id;
    var toppart=cmid.split("_")[0];
    if(toppart==inp) clearBox();
  }
}

function showBoxMenu(inp) {
  if(cm) {
    var cmid=cm.id;
    var toppart=cmid.split("_")[0];
    if(toppart==inp) showBox();
  }
}

function clearBox(inp) {
  if(timerID!=-1) window.clearTimeout(timerID);
  timerID=window.setTimeout("closeWindow()",3000);
}

function showBox(inp) {
  if(timerID!=-1) window.clearTimeout(timerID);
}
