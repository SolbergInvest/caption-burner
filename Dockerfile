FROM node:18

# Install FFmpeg and manually install Poppins font
RUN apt-get update && apt-get install -y ffmpeg wget unzip && \
    mkdir -p /usr/share/fonts/truetype/poppins && \
    wget https://fonts.google.com/download?family=Poppins -O /tmp/poppins.zip && \
    unzip /tmp/poppins.zip -d /usr/share/fonts/truetype/poppins && \
    fc-cache -f -v

# Create app directory
WORKDIR /app

# Copy everything in
COPY . .

# Install dependencies
RUN npm install

# Run the server
CMD ["node", "server.js"]
