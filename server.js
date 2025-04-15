const express = require("express");
const multer = require("multer");
const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");
const { v4: uuidv4 } = require("uuid");

const app = express();
const port = process.env.PORT || 3000;
const upload = multer({ dest: "uploads/" });

app.post("/burn", upload.fields([{ name: "video" }, { name: "subtitles" }]), async (req, res) => {
  try {
    const videoFile = req.files["video"][0];
    const subtitleFile = req.files["subtitles"][0];
    const outputName = `${uuidv4()}.mp4`;
    const outputPath = path.join(__dirname, "outputs", outputName);

    if (!fs.existsSync("outputs")) {
      fs.mkdirSync("outputs");
    }

    const cmd = `ffmpeg -i ${videoFile.path} -vf "ass=${subtitleFile.path},scale=720:-2" -preset ultrafast -c:a copy ${outputPath}`;


    exec(cmd, (error, stdout, stderr) => {
      if (error) {
        console.error(stderr);
        return res.status(500).json({ error: "FFmpeg failed", details: stderr });
      }

      res.json({ message: "Video processed", url: `/outputs/${outputName}` });
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Something went wrong", details: err.message });
  }
});

app.use("/outputs", express.static("outputs"));

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
