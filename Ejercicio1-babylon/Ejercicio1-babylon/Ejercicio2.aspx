<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ejercicio2.aspx.cs" Inherits="Ejercicio1_babylon.Ejercicio2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>

<script src="js/babylon.js"></script>
<script src="js/hand.js"></script>

</head>
<body>
<style>
    html, body, div, canvas {
            width: 100%;
            height: 100%;
            padding: 0;
            margin: 0;
            overflow: hidden;
    }

</style>
<div id="DivConCaracterística">
  <canvas id="Modelado3D"></canvas>
</div>

<script>
    // Elemento canvas 
    var ElementoCanvas = document.getElementById("Modelado3D");
     // Cargar BABYLON 3D en las canvas
    var Motorbabylon = new BABYLON.Engine(ElementoCanvas, true);
    var Escenario = new BABYLON.Scene(Motorbabylon);

    //Cargar la cámara
    var Camara = new BABYLON.ArcRotateCamera("Camera", 1, 0.8, 10, new BABYLON.Vector3(0, 0, 0), Escenario);
    //var Camara = new BABYLON.FreeCamera("FreeCamera", new BABYLON.Vector3(0, 1, -15), Escenario);
    //Camara.orthoLeft = true;
    //var Camara = new BABYLON.TouchCamera("TouchCamera", new BABYLON.Vector3(0, 1, -15), Escenario);
    //var Camara = new BABYLON.DeviceOrientationCamera("Cam0", new BABYLON.Vector3(0, 1, -15), Escenario);
    // var Camara = new BABYLON.VirtualJoysticksCamera("Camjt", new BABYLON.Vector3(0, 1, -15), Escenario);
    //var Camara = new BABYLON.OculusCamera("CamOculus", new BABYLON.Vector3(0, 20, -45), Escenario);
    // var Camara = new BABYLON.AnaglyphArcRotateCamera("anaRotateCamera", -Math.PI / 2, Math.PI / 4, 20, new BABYLON.Vector3.Zero(), 1.0, Escenario);
    //var Camara = new BABYLON.GamepadCamera("GamePadcamera", new BABYLON.Vector3(0, 10, -45), Escenario);






    //Escenario.activeCamera.alpha += .01;
    // Agregamos la luz
    var Luz = new BABYLON.PointLight("Omni", new BABYLON.Vector3(10, 10, -30), Escenario);
 

    // elemento 3D (esfera)
    var plan = BABYLON.Mesh.CreatePlane("Plane", 50.0, Escenario);
    plan.material = new BABYLON.StandardMaterial("material", Escenario);
    plan.material.backFaceCulling = false;
    // Agregar la cámara al escenario
    Escenario.activeCamera.attachControl(ElementoCanvas);
    // Agregamos un render del escenario
    Motorbabylon.runRenderLoop(function () {
        Escenario.render();
    });


</script>
</body>
</html>
