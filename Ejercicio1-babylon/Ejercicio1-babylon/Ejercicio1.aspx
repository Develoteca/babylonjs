<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ejercicio1.aspx.cs" Inherits="Ejercicio1_babylon.Ejercicio1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Ejercicio1</title>
    
    <!-- bootstrap css, js-->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <!-- bootstrap css, js-->
    <script src="js/babylon.js"></script>
    <script src="js/hand.js"></script>
    <link href="css/style.css" rel="stylesheet" />
</head>
<body>
 
    <div class="container">
	    <div class="row clearfix">
		    <div class="col-md-3 column">

                    <div class="list-group">
				        <a href="#" class="list-group-item active">Configuración Modelo 3D</a>
		             <div class="list-group-item">
			            Valor x: <input id="test" type="range" min="-5" max="10" value="0"  onchange="cambiarPosX(this.value)"/>
                        <br />Valor y: <input id="Range1" type="range" min="-5" max="10" value="0" onchange="cambiarPosY(this.value)"/>
                        <br />Valor z: <input id="Range2" type="range" min="-5" value="-5" max="10"  onchange="cambiarPosZ(this.value)"/><br />
            
                        <br />Escalar X: <input id="Range3" type="range" min="-5" value="0" max="10"  onchange="cambiarTamanioX(this.value)"/>
                        <br />Escalar Y: <input id="Range4" type="range" min="-5" value="0" max="10"  onchange="cambiarTamanioY(this.value)"/>
                        <br />Escalar Z: <input id="Range5" type="range" min="-5" value="0" max="10"  onchange="cambiarTamanioZ(this.value)"/><br />
            
                        <br />Rotar x: <input id="Range6" type="range" min="-5" value="0" max="90"  onchange="RotarX(this.value)"/>
                        <br />Rotar y: <input id="Range7" type="range" min="-5" value="0" max="90"  onchange="RotarY(this.value)"/>
                        <br />Rotar z: <input id="Range8" type="range" min="-5" value="0" max="90"  onchange="RotarZ(this.value)"/>
                         <br />

                        <br /><input type="file" id="filePicker"/><br />
                        <br /><label for="background-color">Color: </label>
                            <input id="background-color" type="color" value="#ff0000" onchange="cambiarColor(document.getElementById('background-color').value);" />
                        <br />
                    </div>
                </div>
            </div>
        
            <div class="col-md-9 column">
                <div id="divconCatacteristicas">
                    <canvas id="Modelo3D"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>

        //elementos canvas 
        var ElementoCanvas = document.getElementById("Modelo3D");

        // Cargar BABYLON 3D En las canvas
        var MotorBabylon = new BABYLON.Engine(ElementoCanvas, true);

        // Escenario 
        var Escenario = new BABYLON.Scene(MotorBabylon);

        // Cargar Cámara
        var Camara = new BABYLON.ArcRotateCamera("Camera", 1, 0.8, 10, new BABYLON.Vector3(0, 0, 0), Escenario);

        // La luz 
        var Luz = new BABYLON.PointLight("Omni", new BABYLON.Vector3(10, 10, -30), Escenario);

        // Elemento 3D Box 
        var box = BABYLON.Mesh.CreateBox("NombreBox", 6.0, Escenario);
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


       


        // Elemento 3D Cylinder 
        var Cylinder = BABYLON.Mesh.CreateCylinder("Cylinder1", 5, 5, 5, 10, 10, Escenario);
        Cylinder.position = new BABYLON.Vector3(0, 0, -5);
        Cylinder.material = new BABYLON.StandardMaterial("MaterialCylinder", Escenario);
        Cylinder.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        Cylinder.material.emissiveTexture = new BABYLON.Texture("ftb.jpg", Escenario);

        // Elemento 3D Sphere
        var Sphere = BABYLON.Mesh.CreateSphere("Sphere",10,10,Escenario);
        Sphere.position=new BABYLON.Vector3(0,15,0);
        Sphere.material = new BABYLON.StandardMaterial("MaterialSphere1", Escenario);
        Sphere.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        Sphere.material.diffuseTexture = new BABYLON.Texture("ftb.jpg", Escenario);

        // Elemento 3D Plane
        var Plane = BABYLON.Mesh.CreatePlane("Plano", 10, Escenario);
        Plane.material = new BABYLON.StandardMaterial("Material", Escenario);
        Plane.material.backFaceCulling = false;
        Plane.material.alpha = 0.5;
        Sphere.position = new BABYLON.Vector3(0, 0, 10);

        // Elementos 3D Torus
        var Torus = BABYLON.Mesh.CreateTorus("Torus", 3, 1, 10, Escenario, false);
        Torus.position = new BABYLON.Vector3(10, 0, 0);
        Torus.material = new BABYLON.StandardMaterial("MaterialTorus1", Escenario);
        Torus.material.wireframe = true;

        // Elemento 3D Mesh

        var triangulo = new BABYLON.Mesh("Triangulo", Escenario);

        var posiciones = [
            0,  1, 0,
           -1, -1, 0,
            1, -1, 0
        ];

        var normalizar = [
            1, 1, 1,
            1, 1, 1,
            1, 1, 1
        ];

        var indices = [];
        indices.push(0);
        indices.push(1);
        indices.push(2);


        // Los datos
        triangulo.setVerticesData(posiciones, BABYLON.VertexBuffer.PositionKind);
        // La normalización
        triangulo.setVerticesData(normalizar, BABYLON.VertexBuffer.NormalKind);
        // los índices
        triangulo.setIndices(indices);
        
        triangulo.material = new BABYLON.StandardMaterial("Material1", Escenario);
        triangulo.material.backFaceCulling = false;
        triangulo.position = new BABYLON.Vector3(10,10,0);



        // Agregar de la cámara al escenario
        Escenario.activeCamera.attachControl(ElementoCanvas);

        // Agregamos un render del escenario
        MotorBabylon.runRenderLoop(function () {
            Escenario.render();
        });

     </script>
    <script>
       
        function cambiarPosX(valor) {box.position.x = valor;}
        function cambiarPosY(valor) {box.position.y = valor;}
        function cambiarPosZ(valor) { box.position.z = valor; }

        function cambiarTamanioX(valor) {box.scaling.x = valor;}
        function cambiarTamanioY(valor) {box.scaling.y = valor;}
        function cambiarTamanioZ(valor) {box.scaling.z = valor;}

        function RotarX(valor) {box.rotation.x = (Math.PI * valor) / 180;}
        function RotarY(valor) {box.rotation.y = (Math.PI * valor) / 180;}
        function RotarZ(valor) { box.rotation.z = (Math.PI * valor) / 180; }

        var handleFileSelect = function (evt) {
            var Archivo = evt.target.files;
            var ArchivoUnico = Archivo[0];
            if (Archivo && ArchivoUnico) {
                var reader = new FileReader();
                reader.onload = function (readerEvt) {
                    var InfoBinaria = readerEvt.target.result;
                    Sphere.material.diffuseTexture = new BABYLON.Texture("data:image/jpg;base64," + btoa(InfoBinaria), Escenario);
                };
                reader.readAsBinaryString(ArchivoUnico);
            }
        };
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            document.getElementById('filePicker').addEventListener('change', handleFileSelect, false);
        }


        function cambiarColor(valor) {

            R = (parseInt((cutHex(valor)).substring(0, 2), 16));
            G = (parseInt((cutHex(valor)).substring(2, 4), 16));
            B = (parseInt((cutHex(valor)).substring(4, 6), 16));
            Plane.material.diffuseColor = new BABYLON.Color3(R, G, B);

        }
        function cutHex(h) { return (h.charAt(0) == "#") ? h.substring(1, 7) : h }



    </script>
    
    <form id="form1" runat="server">
    <div>
    </div>
    </form>


</body>
</html>
