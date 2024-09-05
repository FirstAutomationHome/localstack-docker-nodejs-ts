# Node JS application DockerFile
#1. Buscar una imagen de docker, se puede hacer en Docker hub
FROM node:20.16.0-bookworm

#Create app directory
WORKDIR /usr/src/app

#Install app dependencies
COPY package*.json ./

#Install dependencies
RUN npm ci --omit=dev

#Bundle app source
COPY . .

#Build app
RUN npm run build

#Expose port
EXPOSE 3000

CMD [ "npm", "run", "start" ]
