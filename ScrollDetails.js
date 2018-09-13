function init() {
  var img;
  var x, y;
  // Locate placeholder image so we can use it to position the scrollers.
  img = getImage("tb");
  x = getImagePageLeft(img);
  y = getImagePageTop(img);
  // Create the first scroller and position it.
  scrollBar.create();
  scrollBar.hide();
  scrollBar.moveTo(x+5,y+5);
  scrollBar.setzIndex(100);
  scrollBar.show();
}

// Determine browser.

var isMinNS4 = (navigator.appName.indexOf("Netscape") >= 0 &&
                parseFloat(navigator.appVersion) >= 4) ? 1 : 0;
var isMinIE4 = (document.all) ? 1 : 0;
var isMinIE5 = (isMinIE4 && navigator.appVersion.indexOf("5.") >= 0) ? 1 : 0;

//-----------------------------------------------------------------------------
// Layer visibility.
//-----------------------------------------------------------------------------

function hideLayer(layer) {

  if (isMinNS4)
    layer.visibility = "hide";
  if (isMinIE4)
    layer.style.visibility = "hidden";
}

function showLayer(layer) {

  if (isMinNS4)
    layer.visibility = "show";
  if (isMinIE4)
    layer.style.visibility = "visible";
}

function inheritLayer(layer) {

  if (isMinNS4)
    layer.visibility = "inherit";
  if (isMinIE4)
    layer.style.visibility = "inherit";
}

function getVisibility(layer) {

  if (isMinNS4) {
    if (layer.visibility == "show")
      return "visible";
    if (layer.visibility == "hide")
      return "hidden";
    return layer.visibility;
  }
  if (isMinIE4)
    return layer.style.visibility;
  return "";
}

//-----------------------------------------------------------------------------
// Layer positioning.
//-----------------------------------------------------------------------------

function moveLayerTo(layer, x, y) {

  if (isMinNS4)
    layer.moveTo(x, y);
  if (isMinIE4) {
    layer.style.left = x;
    layer.style.top  = y;
  }
}

function moveLayerBy(layer, dx, dy) {

  if (isMinNS4)
    layer.moveBy(dx, dy);
  if (isMinIE4) {
    layer.style.pixelLeft += dx;
    layer.style.pixelTop  += dy;
  }
}

function getLeft(layer) {

  if (isMinNS4)
    return layer.left;
  if (isMinIE4)
    return layer.style.pixelLeft;
  return -1;
}

function getTop(layer) {

  if (isMinNS4)
    return layer.top;
  if (isMinIE4)
    return layer.style.pixelTop;
  return -1;
}

function getRight(layer) {

  if (isMinNS4)
    return layer.left + getWidth(layer);
  if (isMinIE4)
    return layer.style.pixelLeft + getWidth(layer);
  return -1;
}

function getBottom(layer) {

  if (isMinNS4)
    return layer.top + getHeight(layer);
  if (isMinIE4)
    return layer.style.pixelTop + getHeight(layer);
  return -1;
}

function getPageLeft(layer) {

  var x;

  if (isMinNS4)
    return layer.pageX;
  if (isMinIE4) {
    x = 0;
    while (layer.offsetParent != null) {
      x += layer.offsetLeft;
      layer = layer.offsetParent;
    }
    x += layer.offsetLeft;
    return x;
  }
  return -1;
}

function getPageTop(layer) {

  var y;

  if (isMinNS4)
    return layer.pageY;
  if (isMinIE4) {
    y = 0;
    while (layer.offsetParent != null) {
      y += layer.offsetTop;
      layer = layer.offsetParent;
    }
    y += layer.offsetTop;
    return y;
  }
  return -1;
}

function getWidth(layer) {

  if (isMinNS4) {
    if (layer.document.width)
      return layer.document.width;
    else
      return layer.clip.right - layer.clip.left;
  }
  if (isMinIE4) {
    if (layer.style.pixelWidth)
      return layer.style.pixelWidth;
    else
      return layer.clientWidth;
  }
  return -1;
}

function getHeight(layer) {

  if (isMinNS4) {
    if (layer.document.height)
      return layer.document.height;
    else
      return layer.clip.bottom - layer.clip.top;
  }
  if (isMinIE4) {
    if (layer.style.pixelHeight)
      return layer.style.pixelHeight;
    else
      return layer.clientHeight;
  }
  return -1;
}

function getzIndex(layer) {

  if (isMinNS4)
    return layer.zIndex;
  if (isMinIE4)
    return layer.style.zIndex;

  return -1;
}

function setzIndex(layer, z) {

  if (isMinNS4)
    layer.zIndex = z;
  if (isMinIE4)
    layer.style.zIndex = z;
}

//-----------------------------------------------------------------------------
// Layer clipping.
//-----------------------------------------------------------------------------

function clipLayer(layer, clipleft, cliptop, clipright, clipbottom) {

  if (isMinNS4) {
    layer.clip.left   = clipleft;
    layer.clip.top    = cliptop;
    layer.clip.right  = clipright;
    layer.clip.bottom = clipbottom;
  }
  if (isMinIE4)
    layer.style.clip = 'rect(' + cliptop + ' ' +  clipright + ' ' + clipbottom + ' ' + clipleft +')';
}

function getClipLeft(layer) {

  if (isMinNS4)
    return layer.clip.left;
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return 0;
    var clip = getIEClipValues(layer.style.clip);
    return(clip[3]);
  }
  return -1;
}

function getClipTop(layer) {

  if (isMinNS4)
    return layer.clip.top;
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return 0;
    var clip = getIEClipValues(layer.style.clip);
    return clip[0];
  }
  return -1;
}

function getClipRight(layer) {

  if (isMinNS4)
    return layer.clip.right;
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return layer.style.pixelWidth;
    var clip = getIEClipValues(layer.style.clip);
    return clip[1];
  }
  return -1;
}

function getClipBottom(layer) {

  if (isMinNS4)
    return layer.clip.bottom;
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return layer.style.pixelHeight;
    var clip = getIEClipValues(layer.style.clip);
    return clip[2];
  }
  return -1;
}

function getClipWidth(layer) {

  if (isMinNS4)
    return layer.clip.width;
  if (isMinIE4) {
    var str = layer.style.clip;
    if (!str)
      return layer.style.pixelWidth;
    var clip = getIEClipValues(layer.style.clip);
    return clip[1] - clip[3];
  }
  return -1;
}

function getClipHeight(layer) {

  if (isMinNS4)
    return layer.clip.height;
  if (isMinIE4) {
    var str =  layer.style.clip;
    if (!str)
      return layer.style.pixelHeight;
    var clip = getIEClipValues(layer.style.clip);
    return clip[2] - clip[0];
  }
  return -1;
}

function getIEClipValues(str) {

  var clip = new Array();
  var i;

  // Parse out the clipping values for IE layers.

  i = str.indexOf("(");
  clip[0] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[1] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[2] = parseInt(str.substring(i + 1, str.length), 10);
  i = str.indexOf(" ", i + 1);
  clip[3] = parseInt(str.substring(i + 1, str.length), 10);
  return clip;
}

//-----------------------------------------------------------------------------
// Layer scrolling.
//-----------------------------------------------------------------------------

function scrollLayerTo(layer, x, y, bound) {

  var dx = getClipLeft(layer) - x;
  var dy = getClipTop(layer) - y;

  scrollLayerBy(layer, -dx, -dy, bound);
}

function scrollLayerBy(layer, dx, dy, bound) {

  var cl = getClipLeft(layer);
  var ct = getClipTop(layer);
  var cr = getClipRight(layer);
  var cb = getClipBottom(layer);

  if (bound) {
    if (cl + dx < 0)
      dx = -cl;
    else if (cr + dx > getWidth(layer))
      dx = getWidth(layer) - cr;
    if (ct + dy < 0)
      dy = -ct;
    else if (cb + dy > getHeight(layer))
      dy = getHeight(layer) - cb;
  }
  clipLayer(layer, cl + dx, ct + dy, cr + dx, cb + dy);
  moveLayerBy(layer, -dx, -dy);
}

//-----------------------------------------------------------------------------
// Layer background.
//-----------------------------------------------------------------------------

function setBgColor(layer, color) {

  if (isMinNS4)
    layer.bgColor = color;
  if (isMinIE4)
    layer.style.backgroundColor = color;
}

function setBgImage(layer, src) {

  if (isMinNS4)
    layer.background.src = src;
  if (isMinIE4)
    layer.style.backgroundImage = "url(" + src + ")";
}

//-----------------------------------------------------------------------------
// Layer utilities.
//-----------------------------------------------------------------------------

function getLayer(name) {

  if (isMinNS4)
    return findLayer(name, document);
  if (isMinIE4)
    return eval('document.all.' + name);
  return null;
}

function findLayer(name, doc) {

  var i, layer;

  for (i = 0; i < doc.layers.length; i++) {
    layer = doc.layers[i];
    if (layer.name == name)
      return layer;
    if (layer.document.layers.length > 0)
      if ((layer = findLayer(name, layer.document)) != null)
        return layer;
  }
  return null;
}

//-----------------------------------------------------------------------------
// Image utilities.
//-----------------------------------------------------------------------------

function getImage(name) {

  if (isMinNS4) {
    return findImage(name, document);
  }
  if (isMinIE4)
    return eval('document.all.' + name);
  return null;
}

function findImage(name, doc) {

  var i, img;

  for (i = 0; i < doc.images.length; i++)
    if (doc.images[i].name == name)
      return doc.images[i];
  for (i = 0; i < doc.layers.length; i++)
    if ((img = findImage(name, doc.layers[i].document)) != null) {
      img.container = doc.layers[i];
      return img;
    }
  return null;
}

function getImagePageLeft(img) {

  var x, obj;

  if (isMinNS4) {
    if (img.container != null)
      return img.container.pageX + img.x;
    else
      return img.x;
  }
  if (isMinIE4) {
    x = 0;
    obj = img;
    while (obj.offsetParent != null) {
      x += obj.offsetLeft;
      obj = obj.offsetParent;
    }
    x += obj.offsetLeft;
    return x;
  }
  return -1;
}

function getImagePageTop(img) {

  var y, obj;

  if (isMinNS4) {
    if (img.container != null)
      return img.container.pageY + img.y;
    else
      return img.y;
  }
  if (isMinIE4) {
    y = 0;
    obj = img;
    while (obj.offsetParent != null) {
      y += obj.offsetTop;
      obj = obj.offsetParent;
    }
    y += obj.offsetTop;
    return y;
  }
  return -1;
}

//-----------------------------------------------------------------------------
// Window and page properties.
//-----------------------------------------------------------------------------

function getWindowWidth() {

  if (isMinNS4)
    return window.innerWidth;
  if (isMinIE4)
    return document.body.clientWidth;
  return -1;
}

function getWindowHeight() {

  if (isMinNS4)
    return window.innerHeight;
  if (isMinIE4)
    return document.body.clientHeight;
  return -1;
}

function getPageWidth() {

  if (isMinNS4)
    return document.width;
  if (isMinIE4)
    return document.body.scrollWidth;
  return -1;
}

function getPageHeight() {

  if (isMinNS4)
    return document.height;
  if (isMinIE4)
    return document.body.scrollHeight;
  return -1;
}

function getPageScrollX() {

  if (isMinNS4)
    return window.pageXOffset;
  if (isMinIE4)
    return document.body.scrollLeft;
  return -1;
}

function getPageScrollY() {

  if (isMinNS4)
    return window.pageYOffset;
  if (isMinIE4)
    return document.body.scrollTop;
  return -1;
}

/******************************************************************************
* scr_upload.js                                                               *
*                                                                             *
* Copyright 1999 by Mike Hall.                                                *
******************************************************************************/

function Scroller(x, y, width, height, border, padding) {

  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  this.border = border;
  this.padding = padding;

  this.items = new Array();
  this.created = false;

  // Set default colors.

  this.fgColor = "#000000";
  this.bgColor = "#ffffff";
  this.bdColor = "#000000";

  // Set default font.

  this.fontFace = "Verdana, Arial, Helvetica, sans-serif";
  this.fontSize = "2";

  // Set default scroll timing values.

  this.speed = 50;
  this.pauseTime = 2000;

  // Define methods.

  this.setColors = scrollerSetColors;
  this.setFont = scrollerSetFont;
  this.setSpeed = scrollerSetSpeed;
  this.setPause = scrollersetPause;
  this.addItem = scrollerAddItem;
  this.create = scrollerCreate;
  this.show = scrollerShow;
  this.hide = scrollerHide;
  this.moveTo = scrollerMoveTo;
  this.moveBy = scrollerMoveBy;
  this.getzIndex = scrollerGetzIndex;
  this.setzIndex = scrollerSetzIndex;
  this.stop = scrollerStop;
  this.start = scrollerStart;
}

//*****************************************************************************
// Scroller methods.
//*****************************************************************************

function scrollerSetColors(fgcolor, bgcolor, bdcolor) {

  if (!this.created) {
    this.fgColor = fgcolor;
    this.bgColor = bgcolor;
    this.bdColor = bdcolor;
  }
}

function scrollerSetFont(face, size) {

  if (!this.created) {
    this.fontFace = face;
    this.fontSize = size;
  }
}

function scrollerSetSpeed(pps) {

  if (!this.created)
    this.speed = pps;
}

function scrollersetPause(ms) {

  if (!this.created)
    this.pauseTime = ms;
}

function scrollerAddItem(str) {

  if (!this.created)
    this.items[this.items.length] = str;
}

function scrollerCreate() {

  var start, end;
  var str;
  var i, j;
  var x, y;

  if (!isMinNS4 && !isMinIE4)
    return;

  // On first scroller, start interval timer.

  if (scrollerList.length == 0)
    setInterval('scrollerGo()', scrollerInterval);

  // Create the scroller only once.

  if (this.created)
    return;
  this.created = true;

  // Copy first item to the end of the list, this lets us scroll from the last
  // defined item to the first without jumping.

  this.items[this.items.length] = this.items[0];

  // Set up HTML code for item text.

  start = '<table border=0'
        + ' cellpadding=' + (this.padding + this.border) + ' cellspacing=0'
        + ' width=' + this.width + ' height=' + this.height + '>'
        + '<tr><td>'
        + '<font color="' + this.fgColor + '" face="' + this.fontFace + '"'
        + ' size=' + this.fontSize + '>';
  end   = '</font></td></tr></table>';

  // Build the layers.

  if (isMinNS4) {
    this.baseLayer = new Layer(this.width);
    this.scrollLayer = new Layer(this.width, this.baseLayer);
    this.scrollLayer.visibility = "inherit";
    this.itemLayers = new Array();
    for (i = 0; i < this.items.length; i++) {
      this.itemLayers[i] = new Layer(this.width, this.scrollLayer);
      this.itemLayers[i].document.open();
      this.itemLayers[i].document.writeln(start + this.items[i] + end);
      this.itemLayers[i].document.close();
      this.itemLayers[i].visibility = "inherit";
    }

    // Set background colors.

    setBgColor(this.baseLayer, this.bdColor);
    setBgColor(this.scrollLayer, this.bgColor);
  }

  if (isMinIE4) {
    i = scrollerList.length;
    str = '<div id="scroller' + i + '_baseLayer"'
        + ' style="position:absolute;'
        + 'left:0px; top:0px;'
        + 'background-color:' + this.bdColor + ';'
        + 'width:' + this.width + 'px;'
        + 'height:' + this.height + 'px;'
        + 'overflow:hidden;'
        + 'visibility:hidden;">\n'
        + '<div id="scroller' + i + '_scrollLayer"'
        + ' style="position:absolute;'
        + 'background-color: ' + this.bgColor + ';'
        + 'width:' + this.width + 'px;'
        + 'height:' + (this.height * this.items.length) + 'px;'
        + 'visibility:inherit;">\n';
    for (j = 0; j < this.items.length; j++) {
      str += '<div id="scroller' + i + '_itemLayer' + j + '"'
          +  ' style="position:absolute;'
          +  'width:' + this.width + 'px;'
          +  'height:' + this.height + 'px;'
          +  'visibility:inherit;">\n'
          +  start + this.items[j] + end
          +  '</div>\n';
    }
    str += '</div>\n'
        +  '</div>\n';

    // Insert HTML code at end of page. For IE4, need to scroll window to
    // end of page, insert and scroll back to correct bug.

    if (!isMinIE5) {
      x = getPageScrollX();
      y = getPageScrollY();
      window.scrollTo(getPageWidth(), getPageHeight());
    }
    document.body.insertAdjacentHTML("beforeEnd", str);
    if (!isMinIE5)
      window.scrollTo(x, y);

    // Get handles to each layer.

    this.baseLayer = getLayer("scroller" + i + "_baseLayer");
    this.scrollLayer = getLayer("scroller" + i + "_scrollLayer");
    this.itemLayers = new Array();
    for (j = 0; j < this.items.length; j++)
      this.itemLayers[j] = getLayer("scroller" + i + "_itemLayer" + j);
  }

  // Position and clip base and scroll layers.

  moveLayerTo(this.baseLayer, this.x, this.y);
  clipLayer(this.baseLayer, 0, 0, this.width, this.height);
  moveLayerTo(this.scrollLayer, this.border, this.border);
  clipLayer(this.scrollLayer, 0, 0,
            this.width - 2 * this.border, this.height - 2 * this.border);

  // Position and clip each item layer.

  x = 0;
  y = 0;
  for (i = 0; i < this.items.length; i++) {
    moveLayerTo(this.itemLayers[i], x, y);
    clipLayer(this.itemLayers[i], 0, 0, this.width, this.height);
    y += this.height;
  }

  // Set up scrolling parameters.

  this.stopped = false;
  this.currentY = 0;
  this.stepY = this.speed / (1000 / scrollerInterval);
  this.stepY = Math.min(this.height, this.stepY);
  this.nextY = this.height;
  this.maxY = this.height * (this.items.length - 1);
  this.paused = true;
  this.counter = 0;

  // Add to global list.

  scrollerList[scrollerList.length] = this;

  // Display it.

  showLayer(this.baseLayer);
}

function scrollerShow() {

  if (this.created)
    showLayer(this.baseLayer);
}

function scrollerHide() {

  if (this.created)
    hideLayer(this.baseLayer);
}

function scrollerMoveTo(x, y) {

  if (this.created)
    moveLayerTo(this.baseLayer, x, y);
}

function scrollerMoveBy(dx, dy) {

  if (this.created)
    moveLayerBy(this.baseLayer, dx, dy);
}

function scrollerGetzIndex() {

  if (this.created)
    return(getzIndex(this.baseLayer));
  else
    return(0);
}

function scrollerSetzIndex(z) {

  if (this.created)
    setzIndex(this.baseLayer, z);
}

function scrollerStart() {

  this.stopped = false;
}

function scrollerStop() {

  this.stopped = true;
}

//*****************************************************************************
// Code for scrolling.
//*****************************************************************************

// An array is used to hold a pointer to each scroller that is defined. The
// scrollerGo() function runs at regular intervals and updates each scroller
// in this list.

var scrollerList     = new Array();
var scrollerInterval = 20;

function scrollerGo() {

  var i;

  // Update each scroller object in the list.

  for (i = 0; i < scrollerList.length; i++) {

    // If stopped, skip.

    if (scrollerList[i].stopped);

    // If paused, update counter.

    else if (scrollerList[i].paused) {
      scrollerList[i].counter += scrollerInterval;
      if (scrollerList[i].counter > scrollerList[i].pauseTime)
        scrollerList[i].paused = false;
    }

    // Scroll it.

    else {
      scrollerList[i].currentY += scrollerList[i].stepY;

      // Pause it if the next item has scrolled into view.

      if (scrollerList[i].currentY >= scrollerList[i].nextY) {
        scrollerList[i].paused = true;
        scrollerList[i].counter = 0;
        scrollerList[i].currentY = scrollerList[i].nextY;
        scrollerList[i].nextY += scrollerList[i].height;
      }

      // When we reach the end, start over.

      if (scrollerList[i].currentY >= scrollerList[i].maxY) {
        scrollerList[i].currentY -= scrollerList[i].maxY;
        scrollerList[i].nextY = scrollerList[i].height;
      }
      scrollLayerTo(scrollerList[i].scrollLayer,
                    0, Math.round(scrollerList[i].currentY),
                    false);
    }
  }
}

//*****************************************************************************
// Code to handle a window resize.
//*****************************************************************************

// These variables are used to determine if a resize event is a true one in
// older releases of NS4.

var origWidth;
var origHeight;

// Reload page in case of a browser resize.

if (isMinNS4) {
  origWidth  = window.innerWidth;
  origHeight = window.innerHeight;
}
window.onresize = scrollerReload;

function scrollerReload() {

  if (isMinNS4 && origWidth == window.innerWidth && origHeight == window.innerHeight)
    return;

  // For IE, reload on a timer in case the Windows 'Show window contents while
  // dragging' display option is on.

  if (isMinIE4)
    setTimeout('window.location.href = window.location.href', 2000);
  else
    window.location.href = window.location.href;
}

