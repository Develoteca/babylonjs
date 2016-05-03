<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TexturaCielo.aspx.cs" Inherits="Ejercicio1_babylon.TexturaCielo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cargar un modelo de blender</title>
     <script src="js/babylon.js"></script>
     <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
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
     <input type="button" class="on"  id="t1" value="Tiempo1" />
    <input type="button" class="on"  id="t2" value="Tiempo2" />
    <canvas id="renderCanvas"></canvas>
 </body>
    <script>

        

        // Canvas/Escenario/ Etc.
        var canvas = document.getElementById("renderCanvas");
        var engine = new BABYLON.Engine(canvas, true);
        var Escenario = new BABYLON.Scene(engine);
        var Camara = new BABYLON.ArcRotateCamera("Camera", 0, 0, 0, new BABYLON.Vector3(0, 0, 0), Escenario);
        Camara.beta = 1.79;
        Camara.alpha = 8.4;
        Camara.radius = 20;
        Camara.target = new BABYLON.Vector3(-5, -4, 0);
        Camara.attachControl(canvas);

        // Plano
        var Piso = BABYLON.Mesh.CreatePlane("piso", 100, Escenario);
        Piso.specularColor = new BABYLON.Color3(0, 0, 0);
        Piso.position = new BABYLON.Vector3(0,-5,0);
        Piso.rotation = new BABYLON.Vector3(Math.PI / 2, 0, 0);

        
       
        // Cubo y Cielo
        var CuboCielo = BABYLON.Mesh.CreateBox("cielo", 10000, Escenario);
      
        //Cubo con textura
        var Cubo = new BABYLON.Mesh.CreateBox("crate",10, Escenario);
        Cubo.material = new BABYLON.StandardMaterial("Mat", Escenario);
        Cubo.material.diffuseTexture = new BABYLON.Texture("texturareal.png", Escenario);
        Cubo.material.diffuseTexture.hasAlpha = true;
        Cubo.position = new BABYLON.Vector3(0, 10, -10);
        var MaterialCuboCielo = new BABYLON.StandardMaterial("Cielo", Escenario);
        MaterialCuboCielo.backFaceCulling = false;

        MaterialCuboCielo.reflectionTexture = new BABYLON.CubeTexture("textura3/", Escenario, ["_derecha.jpg", "_arriba.jpg", "_atraz.jpg", "_izquierda.jpg", "_abajo.jpg", "_frente.jpg"]);
        MaterialCuboCielo.reflectionTexture.coordinatesMode = BABYLON.Texture.SKYBOX_MODE;
        MaterialCuboCielo.diffuseColor = new BABYLON.Color3(0, 0, 0);
        MaterialCuboCielo.specularColor = new BABYLON.Color3(0, 0, 0);

        CuboCielo.material = MaterialCuboCielo;

        // REFLEJO 

        var MaterialReflejante = new BABYLON.StandardMaterial("texture4", Escenario);
        MaterialReflejante.reflectionTexture = new BABYLON.MirrorTexture("mirror", 512, Escenario, true); //Create a mirror texture
        MaterialReflejante.reflectionTexture.mirrorPlane = new BABYLON.Plane(0, -1.0, 0, -10.0);
        MaterialReflejante.reflectionTexture.renderList = [Cubo, CuboCielo];
        MaterialReflejante.reflectionTexture.level = 1;



        // Luz
        var LuzPoint = new BABYLON.PointLight("Omnidir", new BABYLON.Vector3(0, -50, 0), Escenario);
        var LuzDirecional = new BABYLON.DirectionalLight("Omni", new BABYLON.Vector3(-2, -50, 50), Escenario);
        // Sombras
        var shadowGenerator = new BABYLON.ShadowGenerator(1024, LuzDirecional);
        shadowGenerator.getShadowMap().renderList.push(Cubo);
        shadowGenerator.useVarianceShadowMap = true;

        LuzDirecional.setDirectionToTarge = Cubo;
        Piso.receiveShadows = true;

        MaterialReflejante.diffuseColor = new BABYLON.Color3(0, 0, 0);
        MaterialReflejante.specularColor = new BABYLON.Color3(0, 0, 0);



        Piso.material = MaterialReflejante;
        Piso.material.backFaceCulling = false;

        console.log(CuboCielo);


        window.addEventListener("resize", function () { engine.resize(); });
        engine.runRenderLoop(function () { Escenario.render(); });

        $(".on").click(function () {

            theid = this.id;
            if (theid == 't1') {
                CuboCielo.material = MaterialReflejante;

            }
            else {
                
                CuboCielo.material = MaterialCuboCielo;
            }

        });


</script>
</html>