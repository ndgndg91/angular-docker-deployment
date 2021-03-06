# Stage 1
FROM node:12-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm install -g @angular/cli
RUN ng build --prod
RUN ls /app/dist/

# Stage 2
FROM nginx:1.19.2-alpine
COPY --from=build-step /app/dist/angular-docker-aws /usr/share/nginx/html