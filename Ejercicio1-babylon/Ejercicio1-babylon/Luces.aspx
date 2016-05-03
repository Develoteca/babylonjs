<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Luces.aspx.cs" Inherits="Ejercicio1_babylon.Luces" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Ejercicio1</title>
    
    <!-- bootstrap css, js-->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <!-- bootstrap css, js-->
    <script src="js/babylon.js"></script>
    <script src="js/hand.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <link href="css/style.css" rel="stylesheet" />
</head>
<body>
 
    <div class="container">
	    <div class="row clearfix">
		    <div class="col-md-3 column">

                    <div class="list-group">
				        <a href="#" class="list-group-item active">Configuración Modelo 3D</a>
		             <div class="list-group-item">

                        <input type="button" class="on"  id="Luz0" value="Point" />
                        <input type="button" class="on"  id="Luz1" value="Dir" />
                        <input type="button" class="on"  id="Luz2" value="Spot" />
                        <input type="button" class="on"  id="Luz3" value="Hemi" />
                       
                         Animación:<br />
                        <input type="button" onclick="Animar(1);" value="Rotar" />
                        <input type="button" onclick="Animar(2);" value="Scalar" />
                        <input type="button" onclick="Animar(3);" value="Trasladar" />

                         

                         <br /><br />
                         
                        Valor x: <input id="test" type="range" min="-100" max="300" value="0"  onchange="cambiarPosX(this.value)"/>
                        <br />Valor y: <input id="Range1" type="range"  min="-100" max="300" value="0" onchange="cambiarPosY(this.value)"/>
                        <br />Valor z: <input id="Range2" type="range"  min="-100" max="300" value="-5"  onchange="cambiarPosZ(this.value)"/><br />


                    </div>
                </div>
            </div>
        
            <div class="col-md-9 column">
                <div id="divconCatacteristicas">
                    <canvas id="Modelo3D" style=" height:500px;"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        var stado = 1;
        var Luzactiva = Luz0;

        //elementos canvas 
        var ElementoCanvas = document.getElementById("Modelo3D");

        // Cargar BABYLON 3D En las canvas
        var MotorBabylon = new BABYLON.Engine(ElementoCanvas, true);

        // Escenario 
        var Escenario = new BABYLON.Scene(MotorBabylon);

        // Cargar Cámara
        // 37.38340023424918, y: 4.829769361711816, z: -103.32983013220478
        var Camara = new BABYLON.ArcRotateCamera("Camera", 1, 0.8, 200, new BABYLON.Vector3(0, 0, 0), Escenario);
        Camara.position = new BABYLON.Vector3(37.38340023424918, 4.829769361711816, -103.32983013220478);

        // PointLigth
        var Luz0 = new BABYLON.PointLight("Point", new BABYLON.Vector3(10, 10, -30), Escenario);
        Luz0.diffuse = new BABYLON.Color3(1, 0, 0);
        Luz0.specular = new BABYLON.Color3(1,1,1);
        
        // DirectionalLight
        var Luz1 = new BABYLON.DirectionalLight("Dir", new BABYLON.Vector3(10, 10, -30), Escenario);
        Luz1.diffuse = new BABYLON.Color3(1, 0, 0);
        Luz1.specular = new BABYLON.Color3(1, 1, 1);

        //SpotLight
        var Luz2 = new BABYLON.SpotLight("Spot", new BABYLON.Vector3.Zero(), new BABYLON.Vector3.Zero(), 0, 0, Escenario);
        Luz2.position = new BABYLON.Vector3(0, 30, -10);
        Luz2.direction = new BABYLON.Vector3(0, -1, 0);
        Luz2.angle = 0.8;
        Luz2.exponent = 2;
        Luz2.intensity = 0.5;
        Luz2.diffuse = new BABYLON.Color3(1, 1, 1);
        Luz2.specular = new BABYLON.Color3(1, 1, 1);
        
        // HemisphericLigth
        var Luz3 = new BABYLON.HemisphericLight("Hemi", new BABYLON.Vector3(0, 1, 0), Escenario);
        Luz3.diffuse = new BABYLON.Color3(1, 1, 1);
        Luz3.specular = new BABYLON.Color3(1, 1, 1);
        Luz3.groundColor = new BABYLON.Color3(0, 0, 0);


        // Elemento 3D Box 
        var box = BABYLON.Mesh.CreateBox("NombreBox", 10, Escenario);
        box.position = new BABYLON.Vector3(-10, 0, 0);
        box.material = new BABYLON.StandardMaterial("MaterialBox1", Escenario);
        box.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        box.material.bumpTexture = new BABYLON.Texture("texturareal.png", Escenario);

        // Ejemplo de traslación
        box.position.x = 30;
        box.position = new BABYLON.Vector3(10, 0, 0);

        // Ejemplo de escala
        box.scaling = new BABYLON.Vector3(2, 2, 2);

        // Ejemplo de rotación 
        box.rotation.x = (Math.PI * 45) / 180;
        box.rotation.y = (Math.PI * 45) / 180;
        box.rotation.z = (Math.PI * 45) / 180;



        var animacionBox = new BABYLON.Animation("NombreAnimacionBasica", "rotation.x", 0.1, BABYLON.Animation.ANIMATIONTYPE_FLOAT, BABYLON.Animation.ANIMATIONLOOPMODE_CYCLE);

        var keys = [];

        keys.push({
            frame: 0,
            value: 1
        });
        keys.push({
            frame: 20,
            value: 180
        });
        keys.push({
            frame: 100,
            value: 1
        });
        animacionBox.setKeys(keys);
        box.animations.push(animacionBox);
        Escenario.beginAnimation(box, 0, 100, true);


        var Sphere = BABYLON.Mesh.CreateSphere("sphere", 20, 20, Escenario);
        Sphere.position.x = 40;
        Sphere.material = new BABYLON.StandardMaterial("MaterialSphere1", Escenario);
        Sphere.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        Sphere.material.diffuseTexture = new BABYLON.Texture("ftb.jpg", Escenario);

        var MarcaAnimacionScalar = 1;
        var contadorMarcaScalar = 1;
        var MarcaAnimacionTrasladar = 1;
        var contadorMarcaTrasladar = 1;

        Escenario.registerBeforeRender(function () {
            switch(stado)
            {
                case 1:
                    Sphere.rotation.x = Sphere.rotation.x + 0.1;
                    Sphere.rotation.y = Sphere.rotation.y + 0.1;
                    Sphere.rotation.z = Sphere.rotation.z + 0.1;
                    break;
                case 2:

                    if (MarcaAnimacionScalar == 1) {
                        if (contadorMarcaScalar == 10) { MarcaAnimacionScalar = 0; }
                        Sphere.scaling.x = Sphere.scaling.x + 0.1;
                        Sphere.scaling.y = Sphere.scaling.y + 0.1;
                        Sphere.scaling.z = Sphere.scaling.z + 0.1;
                        contadorMarcaScalar++;
                    }
                    if (MarcaAnimacionScalar == 0) {
                        if (contadorMarcaScalar == 1) { MarcaAnimacionScalar = 1; }
                        Sphere.scaling.x = Sphere.scaling.x - 0.1;
                        Sphere.scaling.y = Sphere.scaling.y - 0.1;
                        Sphere.scaling.z = Sphere.scaling.z - 0.1;
                        contadorMarcaScalar--;
                    }
                    break;
                case 3:
                    if (MarcaAnimacionTrasladar == 1) {
                        if (contadorMarcaTrasladar == 10) { MarcaAnimacionTrasladar = 0; }
                        Sphere.position.x = Sphere.position.x + 1;
                        Sphere.position.y = Sphere.position.y + 1;
                        Sphere.position.z = Sphere.position.z + 1;
                        contadorMarcaTrasladar++;
                    }
                    if (MarcaAnimacionTrasladar == 0) {
                        if (contadorMarcaTrasladar == 1) { MarcaAnimacionTrasladar = 1; }
                        Sphere.position.x = Sphere.position.x - 1;
                        Sphere.position.y = Sphere.position.y - 1;
                        Sphere.position.z = Sphere.position.z - 1;
                        contadorMarcaTrasladar--;
                    }
                    break;
            }
                
        });




        // Agregar de la cámara al escenario
       Escenario.activeCamera.attachControl(ElementoCanvas);
       


        // Agregamos un render del escenario
        MotorBabylon.runRenderLoop(function () {
            Escenario.render();
             
        });

        $(".on").click(function () {

            theid = this.id;
            eval('Luzactiva=' + theid);
            if (this.className == "on") {
                this.className = "off";
                eval(theid + '.setEnabled(false);');
            } else {
                this.className = "on";
                eval(theid + '.setEnabled(true);');
            }

        });

     </script>
    
    <script>

        function cambiarPosX(valor) { Luzactiva.position.x = valor; }
        function cambiarPosY(valor) { Luzactiva.position.y = valor; }
        function cambiarPosZ(valor) { Luzactiva.position.z = valor; }
        function Animar(Cambio) {
            stado = Cambio;

        }
        
    </script>
    
    <form id="form1" runat="server">
    <div>
    </div>
    </form>


</body>
</html>
