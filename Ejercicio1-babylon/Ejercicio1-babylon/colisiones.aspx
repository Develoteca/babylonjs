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
        var posicion = 0;
        var i = 0;
        var canvas = document.getElementById("renderCanvas");
        var engine = new BABYLON.Engine(canvas, true);
        var scene = new BABYLON.Scene(engine);
        var Modelo;
        var camera = new BABYLON.ArcRotateCamera("Camera", 0, 0, 10, new BABYLON.Vector3(0, 0, 0), scene);

        var light0 = new BABYLON.PointLight("Omnidir", new BABYLON.Vector3(0, 0, 60), scene);
        var LuzOmni = new BABYLON.DirectionalLight("Omni", new BABYLON.Vector3(-2, -5, 2), scene);


        BABYLON.SceneLoader.ImportMesh("", "./", "nav.babylon", scene, function (newMeshes, particleSystems) {
            Modelo = newMeshes[0];
            Modelo.position = new BABYLON.Vector3(0, 0, 0);
        });

        var ground = BABYLON.Mesh.CreateGroundFromHeightMap("ground", "ftb.jpg", 1000, 1000, 100, 0, 12, scene, true);
        var groundMaterial = new BABYLON.StandardMaterial("groundMat", scene);
        groundMaterial.diffuseTexture = new BABYLON.Texture("img/terre.png", scene);
       // groundMaterial.diffuseTexture.uScale = 5.0;
        //groundMaterial.diffuseTexture.vScale = 5.0;
        ground.material = groundMaterial;
        ground.checkCollisions = true;
        ground.position = new BABYLON.Vector3(0, -20, 0);




        //singe.position.x=3;
        camera.attachControl(canvas);
        if (scene.isReady() && Modelo) {
            Modelo.rotation.z = Math.PI / 2;
        }
        scene.registerBeforeRender(function () {
            if (scene.isReady() && Modelo) {
                // Modelo.rotation.y = Modelo.rotation.y + 0.01;
                camera.target.z = parseFloat(Modelo.position.z);

            }
            if (posicion == 1) {
                Modelo.position.z = Modelo.position.z + 0.1;
            }

        });
        window.addEventListener("resize", function () { engine.resize(); });
        window.addEventListener("keydown", onKeyDown, false);
        window.addEventListener("keyup", onKeyUp, false);

        // Gestion du clavier quand on presse une touche
        function onKeyDown(event) {
            var touche = event.keyCode;
            var ch = String.fromCharCode(touche);
            switch (touche) {
                case 16: // MAJ Le perso cours
                    console.log(16);
                    break;
                case 32: // ESPACE le perso saute			
                    console.log(32);
                    break;
            }


        }

        // Gestion du clavier quand on relache une touche
        function onKeyUp(event) {
            var touche = event.keyCode;
            var ch = String.fromCharCode(touche);
            switch (touche) {
                case 16: // MAJ Le perso marche
                    console.log(16);
                    break;
                case 32: // ESPACE le perso ne saute plus
                    console.log(32);
                    break;
            }

            // Clavier AZERTY

            if (ch == "W") { if (scene.isReady() && Modelo) { posicion = 1; } };
            if (ch == "A") { if (scene.isReady() && Modelo) { } };
            if (ch == "D") { console.log("S") };
            if (ch == "x") { console.log("D") };


        }

        engine.runRenderLoop(function () {
            scene.render();
        });
</script>
</html>