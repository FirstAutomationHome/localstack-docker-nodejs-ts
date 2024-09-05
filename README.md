# Creando docker de la aplicación

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

# Creación de Volúmenes en Docker Compose
 https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html
1. ir a examples y copiar el rq en el archivo init-aws.sh
2. Dentro del archivo colocamos el comando para crear la tabla en DynamoDb
#!/bin/bash
awslocal dynamodb create-table \
    --table-name Thread \
    --attribute-definitions \
        AttributeName=ForumName,AttributeType=S \
        AttributeName=Subject,AttributeType=S \
        AttributeName=LastPostDateTime,AttributeType=S \
    --key-schema \
        AttributeName=ForumName,KeyType=HASH \
        AttributeName=Subject,KeyType=RANGE \
    --local-secondary-indexes \
        "IndexName=LastPostIndex,KeySchema=[{AttributeName=ForumName,KeyType=HASH},{AttributeName=LastPostDateTime,KeyType=RANGE}],Projection={ProjectionType=KEYS_ONLY}" \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --tags Key=Owner,Value=BlueTeam \
    --endpoint-url=http://localhost:4566

3. Eliminar las imagenes del Docker y levantar el localStack
docker-compose up

4. Para probar que el localStack está arriba podemos ejecutar una url de la documentación:
docs = https://docs.localstack.cloud/references/internal-endpoints/

Ejemplo:
http://localhost:4566/_localstack/health

5. Pero al revisar el log del contenedor, vamos a ver un error de permiso aunque la url de prueba respondio 200 OK. Es porque hay que darle permisos de la siguiente forma:
chmod +x ./init-aws.sh

6. Luego volvemos a borrar los contenedores del docker y ejecutamos 
docker-compose up

Debe aparecer en la terminal la tabla que se creó mediante un response con un JSON

7. Para listar las tablas ejecutamos el siguiente comando

aws --endpoint-url http://localhost:4566 --profile dev-localstack dynamodb list-tables

Ejemplo:

PS C:\Users\Fredy\FdyAdla\Front-end\LocalStack-Docker-Nodejs> aws --endpoint-url http://localhost:4566 --profile dev-localstack dynamodb list-tables
{
    "TableNames": []
}




