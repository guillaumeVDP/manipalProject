function init() {
  webGLStart();
  innerFrameResize();
}

function onWindowResize() {
  webGLStart(); // A voir ? Gère le redimensionnement mais ça fait lagger je pense
  innerFrameResize();
}

function innerFrameResize() {
	$("#canvas-cubic-nav").css({
	  width: $("body").width(),
	  height: $("body").height()
	});
}