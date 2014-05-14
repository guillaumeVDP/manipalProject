var glSupported = true;

function init() {
  webGLStart();
  innerFrameResize();
  /*$("*:not(html):not(body):not(.container):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").addClass("fadder");*/
  //$("*:not(html):not(body):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").addClass("fadder");
  $("#mainContainer").addClass("fadder");
}

function onWindowResize() {
	if (glSupported)
  	webGLStart(); // A voir ? Gère le redimensionnement mais ça fait lagger je pense
  innerFrameResize();
}

function innerFrameResize() {

}

function UIstartAnimation() {
	/*$("*:not(html):not(body):not(.container):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").css({*/
		//$("*:not(html):not(body):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").css({
	$("#mainContainer").css({
		opacity: "0.0"
	});
	if (glSupported)
		changeDirection("NA");
}

function UIendAnimation(currentPage) {
	//$("*:not(html):not(body):not(.container):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").css({
	//$("*:not(html):not(body):not(#canvas-cubic-nav):not(#canvasdiv):not(figcaption)").css({
	$("#mainContainer").css({
		opacity: "1.0"
	});
}