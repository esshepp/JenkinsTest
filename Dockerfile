FROM node:18

WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy application code
COPY server.js ./

# Expose the port the app runs on
EXPOSE 3000

# Start the Node.js application
CMD [ "node", "server.js" ]
