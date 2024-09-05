#Creando docker de la aplicación

1. Iniciar el package.json de node.js
npm init -y
2. Instalar TS 
npm install --save-dev typescript
3. Instalar Types de node
npm install --save-dev @types/node
3. Instalar express
npm install express
4. Intalar body-parser
npm install body-parser

5. Crear archivo DockerFile para cargar la imagen de la aplicación de node.js (docker official image = https://hub.docker.com/_/node), lo agregamos en el  archivo Dockerfile

6. ahora para crear la imagen ejecutamos
docker build -t nodejs-app .

7. Ahora ejecutamos la imagen en la terminal
docker run -d -p 3000:3000 nodejs-app

#nota: validar que el container está ejecutánse 
docker ps