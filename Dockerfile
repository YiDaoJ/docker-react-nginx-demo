# stage 1: build docker image of react app
FROM node:20-alpine as build

# create working directory / set working directory
WORKDIR /app

# copy package.json from current directory to docker
COPY package*.json ./

# install all depnedencies
RUN npm install

# copy all files from current directory to docker
COPY . .

# build app
RUN npm run build # a build folder will be created automatically



# stage 2: copy the react app build above in nginx

FROM nginx:1.24.0-alpine as production
# set working directory to nginx asset director
WORKDIR /usr/share/nginx/html

# remove default ningx static assets 
# RUN rm -rf ./*

# copy static assets from build stage
COPY --from=build /app/build .

# Containers run nginx with global directives and daemon off
CMD [ "nginx", "-g", "daemon off;" ]


