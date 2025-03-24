# Use an official Node.js runtime as a parent image
FROM node:18

# Install the Express Generator globally
RUN npm install -g express-generator

# Create a working directory for the new app
WORKDIR /usr/src/app

# Use the Express Generator to scaffold a new app.
# In this example, we choose the Pug view engine.
RUN express --view=pug .

# Install the app dependencies
RUN npm install

# Expose the port that the app runs on
EXPOSE 3000

# Define the command to run your app using npm
CMD [ "npm", "start" ]
