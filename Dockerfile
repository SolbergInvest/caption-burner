FROM node:18

# Install FFmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Create app directory
WORKDIR /app

# Copy everything in
COPY . .

# Install dependencies
RUN npm install

# Run the server
CMD ["node", "server.js"]
