FROM node:18

# Install FFmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Install font
RUN apt-get update && apt-get install -y fonts-poppins

# Create app directory
WORKDIR /app

# Copy everything in
COPY . .

# Install dependencies
RUN npm install

# Run the server
CMD ["node", "server.js"]
