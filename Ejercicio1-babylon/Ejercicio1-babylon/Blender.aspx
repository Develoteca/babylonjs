<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Blender.aspx.cs" Inherits="Ejercicio1_babylon.Blender" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cargar un modelo de blender</title>
     <script src="http://www.babylonjs.com/babylon.js"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            padding: 0;
            margin: 0;
            overflow: hidden;
        }

        #renderCanvas {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <canvas id="renderCanvas"></canvas>
 </body>
    <script>
        // Canvas/Escenario/ Etc.
        var canvas = document.getElementById("renderCanvas");
        var engine = new BABYLON.Engine(canvas, true);
        var Escenario = new BABYLON.Scene(engine);
        var Camara = new BABYLON.ArcRotateCamera("Camera",0,0,0, new BABYLON.Vector3(0, 0, 0), Escenario);
        Camara.beta = 1.79;
        Camara.alpha = 8.4;
        Camara.radius = 20;
        Camara.target= new BABYLON.Vector3(-5,-4,0);
        
        // Luz
        var LuzPoint = new BABYLON.PointLight("Omnidir", new BABYLON.Vector3(0, 0, 60), Escenario);
        var LuzDirecional = new BABYLON.DirectionalLight("Omni", new BABYLON.Vector3(-2, -5, 2), Escenario);

        // Plano
        var Piso = BABYLON.Mesh.CreatePlane("piso", 40, Escenario);
        Piso.material = new BABYLON.StandardMaterial("groundMat", Escenario);
        Piso.material.diffuseColor = new BABYLON.Color3(1, 1, 1);
        Piso.material.backFaceCulling = false;
        Piso.position = new BABYLON.Vector3(5, -10, -15);
        Piso.rotation = new BABYLON.Vector3(Math.PI / 2, 0, 0);
        Camara.attachControl(canvas);
        var Modelo;
        BABYLON.SceneLoader.ImportMesh("", "./", "nav.babylon", Escenario, function (newMeshes, particleSystems) {
            Modelo = newMeshes[0];
            Modelo.position = new BABYLON.Vector3(0,0,0);
        });
        Escenario.registerBeforeRender(function () {
            if (Escenario.isReady() && Modelo) {
              
            }

        });
       
        
        window.addEventListener("resize", function () { engine.resize(); });
        engine.runRenderLoop(function () {Escenario.render();});
</script>
</html>