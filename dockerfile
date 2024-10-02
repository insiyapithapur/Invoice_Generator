# Step 1: Use an official Node image as a base
FROM node:14-alpine

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy `package.json` and `package-lock.json` to the container
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the project files to the container
COPY . .

# Step 6: Build the React application
RUN npm run build

# Step 7: Use an nginx image to serve the built files
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Step 8: Expose the application port
EXPOSE 80

# Step 9: Start nginx server
CMD ["nginx", "-g", "daemon off;"]