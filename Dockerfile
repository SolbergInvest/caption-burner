FROM node:18

# Install FFmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Install font dependencies
RUN apt-get update && apt-get install -y wget unzip

# Install Poppins (Bold + SemiBold) from GitHub
RUN mkdir -p /usr/share/fonts/truetype/poppins && \
    wget https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Bold.ttf -O /usr/share/fonts/truetype/poppins/Poppins-Bold.ttf && \
    wget https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-SemiBold.ttf -O /usr/share/fonts/truetype/poppins/Poppins-SemiBold.ttf && \
    fc-cache -f -v

WORKDIR /app
COPY . .

RUN npm install

CMD ["node", "server.js"]
