var gl;

function initGL(canvas) {
  try {
    gl = canvas.getContext("experimental-webgl") || canvas.getContext("webgl");
    if (window.innerHeight > 850)
      gl.canvas.height = window.innerHeight;
    else
      gl.canvas.height = 850;
    gl.canvas.width  = gl.canvas.height;
    gl.viewportWidth = canvas.width;
    gl.viewportHeight = canvas.height;
  } catch (e) {}
  if (!gl) {
    alert("Could not initialise WebGL, sorry. Your browser may not support it.");
/*  glSupported = false;
    $("#canvas-cubic-nav").css({
      width: 850,
      height: 850,
      backgroundImage: '/images/myBackground.png'
    });*/
  }
}


function getShader(gl, id) {
  var shaderScript = document.getElementById(id);
  if (!shaderScript) {
      return null;
  }
  var str = "";
  var k = shaderScript.firstChild;
  while (k) {
    if (k.nodeType == 3) {
      str += k.textContent;
    }
    k = k.nextSibling;
  }
  var shader;
  if (shaderScript.type == "x-shader/x-fragment") {
      shader = gl.createShader(gl.FRAGMENT_SHADER);
  } else if (shaderScript.type == "x-shader/x-vertex") {
      shader = gl.createShader(gl.VERTEX_SHADER);
  } else {
    return null;
  }
  gl.shaderSource(shader, str);
  gl.compileShader(shader);
  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    alert(gl.getShaderInfoLog(shader));
    return null;
  }
  return shader;
}

var shaderProgram;

function initShaders() {
  var fragmentShader = getShader(gl, "shader-fs");
  var vertexShader = getShader(gl, "shader-vs");

  shaderProgram = gl.createProgram();
  gl.attachShader(shaderProgram, vertexShader);
  gl.attachShader(shaderProgram, fragmentShader);
  gl.linkProgram(shaderProgram);

  if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
      alert("Could not initialise shaders");
  }

  gl.useProgram(shaderProgram);

  shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
  gl.enableVertexAttribArray(shaderProgram.vertexPositionAttribute);

  shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord");
  gl.enableVertexAttribArray(shaderProgram.textureCoordAttribute);

  shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix");
  shaderProgram.mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix");
  shaderProgram.samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler");
}


function handleLoadedTexture(texture) {
  gl.bindTexture(gl.TEXTURE_2D, texture);
  gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
  gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image);
  gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
  gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
  gl.bindTexture(gl.TEXTURE_2D, null);
}

var myTexture;
var numTextures = 1;
var textureImagesLoaded = 0;
function initTexture() {
  myTexture = gl.createTexture();
  myTexture.image = new Image();
  myTexture.image.onload = function () {
    handleLoadedTexture(myTexture);
    textureImagesLoaded++;
    if(textureImagesLoaded >= numTextures) {
      drawScene();
    }
  };
  myTexture.image.src = "/images/myBackground.png";
}

var mvMatrix = mat4.create();
var pMatrix = mat4.create();

function setMatrixUniforms() {
  gl.uniformMatrix4fv(shaderProgram.pMatrixUniform, false, pMatrix);
  gl.uniformMatrix4fv(shaderProgram.mvMatrixUniform, false, mvMatrix);
}

function degToRad(degrees) {
  return degrees * Math.PI / 180;
}

var cubeVertexPositionBuffer;
var cubeVertexTextureCoordBuffer;
var cubeVertexIndexBuffer;

function initBuffers() {
  cubeVertexPositionBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexPositionBuffer);
  vertices = [
      // Front face
      -1.0, -1.0,  1.0,
       1.0, -1.0,  1.0,
       1.0,  1.0,  1.0,
      -1.0,  1.0,  1.0,

      // Back face
      -1.0, -1.0, -1.0,
      -1.0,  1.0, -1.0,
       1.0,  1.0, -1.0,
       1.0, -1.0, -1.0,

      // Top face
      -1.0,  1.0, -1.0,
      -1.0,  1.0,  1.0,
       1.0,  1.0,  1.0,
       1.0,  1.0, -1.0,

      // Bottom face
      -1.0, -1.0, -1.0,
       1.0, -1.0, -1.0,
       1.0, -1.0,  1.0,
      -1.0, -1.0,  1.0,

      // Right face
       1.0, -1.0, -1.0,
       1.0,  1.0, -1.0,
       1.0,  1.0,  1.0,
       1.0, -1.0,  1.0,

      // Left face
      -1.0, -1.0, -1.0,
      -1.0, -1.0,  1.0,
      -1.0,  1.0,  1.0,
      -1.0,  1.0, -1.0,
  ];
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
  cubeVertexPositionBuffer.itemSize = 3;
  cubeVertexPositionBuffer.numItems = 24;

  cubeVertexTextureCoordBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexTextureCoordBuffer);
  var textureCoords = [
    // Front face
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,

    // Back face
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    0.0, 0.0,

    // Top face
    0.0, 1.0,
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,

    // Bottom face
    1.0, 1.0,
    0.0, 1.0,
    0.0, 0.0,
    1.0, 0.0,

    // Right face
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    0.0, 0.0,

    // Left face
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ];
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(textureCoords), gl.STATIC_DRAW);
  cubeVertexTextureCoordBuffer.itemSize = 2;
  cubeVertexTextureCoordBuffer.numItems = 24;

  cubeVertexIndexBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, cubeVertexIndexBuffer);
  var cubeVertexIndices = [
      0, 1, 2,      0, 2, 3,    // Front face
      4, 5, 6,      4, 6, 7,    // Back face
      8, 9, 10,     8, 10, 11,  // Top face
      12, 13, 14,   12, 14, 15, // Bottom face
      16, 17, 18,   16, 18, 19, // Right face
      20, 21, 22,   20, 22, 23  // Left face
  ];
  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(cubeVertexIndices), gl.STATIC_DRAW);
  cubeVertexIndexBuffer.itemSize = 1;
  cubeVertexIndexBuffer.numItems = 36;
}

function drawScene() {
  gl.viewport(0, 0, gl.viewportWidth, gl.viewportHeight);
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
  mat4.perspective(45, gl.viewportWidth / gl.viewportHeight, 0.1, 100.0, pMatrix);
  mat4.identity(mvMatrix);
  if (cam > -3.42)
    cam = -3.42;
  mat4.translate(mvMatrix, [0.0, 0.0, cam]);
/*  if (rCubeX > 90)
    rCubeX = 90;
  if (rCubeY > 90)
    rCubeY = 90;*/
  mat4.rotate(mvMatrix, degToRad(rCube), [x, 0, 0]);
  mat4.rotate(mvMatrix, degToRad(rCube), [0, y, 0]);
  mat4.rotate(mvMatrix, degToRad(rCube), [0, 0, z]);
  gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexPositionBuffer);
  gl.vertexAttribPointer(shaderProgram.vertexPositionAttribute, cubeVertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0);
  gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexTextureCoordBuffer);
  gl.vertexAttribPointer(shaderProgram.textureCoordAttribute, cubeVertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0);
  gl.activeTexture(gl.TEXTURE0);
  gl.bindTexture(gl.TEXTURE_2D, myTexture);
  gl.uniform1i(shaderProgram.samplerUniform, 0);
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, cubeVertexIndexBuffer);
  setMatrixUniforms();
  gl.drawElements(gl.TRIANGLES, cubeVertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0);
}

var rCube = 0;
var rCubeX = 0;
var rCubeY = 0;
var rCubeZ = 0;
var cam = -3.42;
var x = 0;
var y = 0;
var z = 0;

var lastTime = 0;
var animated = false;
var zoomSpeed = 12;
var rotationSpeed = 100;
var zoomEnd = false;
var flag = true;

function animate() {
  var timeNow = new Date().getTime();
  if (lastTime != 0) {
    var elapsed = timeNow - lastTime;
    if (animated) {
      if (rCube < 90) {
        rCube += (rotationSpeed * elapsed) / 1000.0;
      } else
        rCube = 90;
      if (zoomEnd == false && cam <= -3.42 && cam >= -10.0) {
        cam -= (zoomSpeed * elapsed) / 1000.0; // We Dezoom
      } else if (cam < -3.42) {
        zoomEnd = true;
        cam += (zoomSpeed * elapsed) / 1000.0; // We Dezoom
      } else {
        cam = -3.42;
        animated = false;
        endAnimation();
      }
    }
  }
  lastTime = timeNow;
}

function tick() {
  if (animated == true) {
    drawScene();
    animate();
    requestAnimFrame(tick);
  }
}

function webGLStart() {
  var canvas = document.getElementById("canvas-cubic-nav");
  initGL(canvas);
  if (gl) {
    initShaders();
    initBuffers();
    initTexture();
    gl.clearColor(0.0, 0.0, 0.0, 0.0);
    gl.enable(gl.DEPTH_TEST);
  }
}

function reinitCube() {
  rCube = 0;
  rCubeX = 0;
  rCubeY = 0;
  rCubeZ = 0;
  x = 0;
  y = 0;
  z = 0;
  lastTime = 0;
  flag = true;
  zoomEnd = false;
}

var direction = "";
var currentPage = ".accueil"
function changeDirection(dir) {
  direction = dir;
  animated = true;
  reinitCube();
  x = 1;
  y = 1;
  //randDir();
  /*$("body").animate({ scrollTop: "0px" });*/
  if (gl)
    setTimeout("tick()", 600);
}

function randDir() {
  var rand = Math.floor(Math.random() * 3) + 1;
  switch (rand) {
    case 1:
      x = 1;
      break;
    case 2:
      x = -1;
      break;
    case 3:
      x = 0;
      break;
    default:
      x = 1;
      break;
  }
  rand = Math.floor(Math.random() * 3) + 1;
  switch (rand) {
    case 1:
      y = 1;
      break;
    case 2:
      y = -1;
      break;
    case 3:
      y = 0;
      break;
    default:
      y = 1;
      break;
  }
  if (x == 0 && y == 0) {
    x = 1;
  }
}

function endAnimation() {
  reinitCube();
  drawScene();
  UIendAnimation(direction);
}