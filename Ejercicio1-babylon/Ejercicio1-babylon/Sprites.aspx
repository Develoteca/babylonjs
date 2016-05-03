﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sprites.aspx.cs" Inherits="Ejercicio1_babylon.Sprites" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <title>Babylon.js sample code</title>
        <!-- Babylon.js -->
		<script src="http://www.babylonjs.com/babylon.js"></script>
        <style>html, body {overflow: hidden;width: 100%;height: 100%;margin: 0;padding: 0;}
            #renderCanvas {width: 100%;height: 100%;touch-action: none;}
        </style>
    </head>
<body>

<br/>Movimientos:

<input type="button" onclick="Caminar(0);" value="Mov1">
<input type="button" onclick="Caminar(1);" value="Mov2">
<input type="button" onclick="Caminar(2);" value="Mov3">
<input type="button" onclick="Caminar(3);" value="Mov4">
<input type="button" onclick="Caminar(4);" value="Mov5">
<input type="button" onclick="Caminar(5);" value="Mov6">
<input type="button" onclick="Caminar(6);" value="Mov7">
<input type="button" onclick="Caminar(7);" value="Mov8">

<input type="button" onclick="Animar();" value="Animación completa">
<input type="button" onclick="Parar();" value="Stop">

<br/>
<br/>

    <canvas id="renderCanvas"></canvas>

    <script>

        var canvas = document.getElementById("renderCanvas");
        var engine = new BABYLON.Engine(canvas, true);
        var Escenario = new BABYLON.Scene(engine);

        var Luz = new BABYLON.PointLight("Luz", new BABYLON.Vector3(10, 10, 5), Escenario);

        var Camara = new BABYLON.ArcRotateCamera("Camara", 0, 0, 10, new BABYLON.Vector3(0, 0, 0), Escenario);
        Camara.attachControl(canvas, false);


        var Plane = BABYLON.Mesh.CreatePlane("Plano", 10, Escenario);
        Plane.material = new BABYLON.StandardMaterial("Material", Escenario);
        Plane.material.backFaceCulling = false;
        Plane.material.alpha = 0.5; Plane.rotation.y = -Math.PI / 2; Plane.rotation.x = -Math.PI / 10;

        var ManejadorSpritePersonaje1 = new BABYLON.SpriteManager("MPersonaje1", "sprites/MonsterARun.png", 1, 64, Escenario);

        var ManejadorSpritepersonaje2 = new BABYLON.SpriteManager("MPersonaje1", "sprites/human.png", 9, 64, Escenario);

        //Personaje 1
        Personaje1 = new BABYLON.Sprite("Personaje1", ManejadorSpritePersonaje1);
        Personaje1.playAnimation(0, 10, true,200);
        Personaje1.position = new BABYLON.Vector3(0, 0, 0);
        Personaje1.size = 1;

        // Personaje 2
        var Personaje2 = new BABYLON.Sprite("Personaje2", ManejadorSpritepersonaje2);
        Personaje2.playAnimation(32, 40, true, 200);

        Personaje2.cellIndex = 32; // Frame 23
        Personaje2.position = new BABYLON.Vector3(0, 0, 3);
        Personaje2.size = 0.7;

        // Personaje 3
        Personaje3 = new BABYLON.Sprite("Personaje3", ManejadorSpritepersonaje2);

        Personaje3.stopAnimation(); // Parar
        Personaje3.cellIndex = 64; // Frame 64

        Personaje3.position = new BABYLON.Vector3(0, 0, -3);
        Personaje3.size = 0.7;

        Personaje3.invertU = 1; // orientación




        Escenario.render();
        engine.runRenderLoop(function () {
            Escenario.render();
        });

        // funciones de movimiento 

        function Caminar(indice) {
            var movInicial = indice * 8;
            Personaje3.playAnimation(movInicial, movInicial + 8, true, 150);
            Personaje3.cellIndex = movInicial; // Frame x
        }
        function Parar() {
            Personaje3.stopAnimation(); Personaje3.cellIndex = 64; // ir al frame 64
        }
        function Animar() {
            Personaje3.playAnimation(0, 64, true, 150);
            Personaje3.cellIndex = 0;
        }


        
    </script>
</body>
</html>