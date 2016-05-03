<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Ejercicio1_babylon.WebForm1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Ejercicio1</title>

    <script src="js/babylon.js"></script>
    <script src="js/hand.js"></script>
    <link href="css/style.css" rel="stylesheet" />



</head>
<body>
 <input id="test" type="range" min="1" max="10"  onchange="cambiarTamanio(this.value)"/>
     <input type="file" id="filePicker"/>
    
    <div id="divconCatacteristicas">
        <canvas id="Modelo3D"></canvas>
    </div>
    
    <script>

        //elementos canvas 
        var ElementoCanvas = document.getElementById("Modelo3D");

        // Cargar BABYLON 3D En las canvas
        var MotorBabylon = new BABYLON.Engine(ElementoCanvas, true);

        // Escenario 
        var Escenario = new BABYLON.Scene(MotorBabylon);
        Escenario.ambientColor = new BABYLON.Color3(25, 25,25);

        // Cargar Cámara
        var Camara = new BABYLON.ArcRotateCamera("Camera", 1, 0.8, 10, new BABYLON.Vector3(0, 0, 0), Escenario);

        // La luz 
        var Luz = new BABYLON.PointLight("Omni", new BABYLON.Vector3(10, 10, -30), Escenario);

        // materiales
      

        // Elemento 3D Box 
        var box = BABYLON.Mesh.CreateBox("NombreBox", 6.0, Escenario);
        box.position = new BABYLON.Vector3(-10, 0, 0);

        box.material = new BABYLON.StandardMaterial("Material", Escenario);
        box.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        box.material.bumpTexture = new BABYLON.Texture("texturareal.png", Escenario);
        
    

        // Elemento 3D Cylinder 
        var Cylinder = BABYLON.Mesh.CreateCylinder("Cylinder1", 5, 5, 5, 10, 10, Escenario);
        Cylinder.position = new BABYLON.Vector3(0, 0, -5);


        
        Cylinder.material = new BABYLON.StandardMaterial("Material", Escenario);
        Cylinder.material.diffuseColor = new BABYLON.Color3(1, 0, 0);

        Cylinder.material.emissiveTexture = new BABYLON.Texture("ftb.jpg", Escenario);
        


       



        // Elemento 3D Sphere
        var Sphere = BABYLON.Mesh.CreateSphere("Sphere", 10, 10, Escenario);
        Sphere.position = new BABYLON.Vector3(0, 15, 0);

        Sphere.material = new BABYLON.StandardMaterial("Material", Escenario);
        Sphere.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
        Sphere.material.diffuseTexture = new BABYLON.Texture("ftb.jpg", Escenario);
       
       
        // Elemento 3D Plane
        var Plane = BABYLON.Mesh.CreatePlane("Plano", 10, Escenario);
        Plane.material = new BABYLON.StandardMaterial("Material", Escenario);
        Plane.material.backFaceCulling = false;

        Plane.material.diffuseColor = new BABYLON.Color3(1, 0, 0);
      



        Plane.material.alpha = 0.5;




        Sphere.position = new BABYLON.Vector3(0, 0, 10);



        // Elementos 3D Torus
        var Torus = BABYLON.Mesh.CreateTorus("Torus", 3, 1, 10, Escenario, false);
        Torus.position = new BABYLON.Vector3(10, 0, 0);
        Torus.material = new BABYLON.StandardMaterial("Material", Escenario);
        Torus.material.wireframe = true;

        // Elemento 3D Mesh

        var triangulo = new BABYLON.Mesh("Triangulo", Escenario);

        var posiciones = [
            0, 1, 0,
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
        triangulo.material.wireframe = true;
        triangulo.position = new BABYLON.Vector3(10, 10, 0);



        // Agregar de la cámara al escenario
        Escenario.activeCamera.attachControl(ElementoCanvas);

        // Agregamos un render del escenario
        MotorBabylon.runRenderLoop(function () {
            Escenario.render();
        });

     </script>
    <script>
      
        var handleFileSelect = function (evt) {
            var Archivo = evt.target.files;
            var ArchivoUnico = Archivo[0];

            if (Archivo && ArchivoUnico) {
                var reader = new FileReader();

                reader.onload = function (readerEvt) {
                    var InfoBinaria = readerEvt.target.result;
                    Cylinder.material.diffuseTexture = new BABYLON.Texture("data:image/jpg;base64," + btoa(InfoBinaria), Escenario);
                };

                reader.readAsBinaryString(ArchivoUnico);
            }
        };
      
         if (window.File && window.FileReader && window.FileList && window.Blob) {
            document.getElementById('filePicker').addEventListener('change', handleFileSelect, false);
        }
         function cambiarTamanio(valor){
             Cylinder.position.x = valor;
         }

    </script>

    
    <form id="form1" runat="server">
    <div>
    </div>
    </form>


</body>
</html>
