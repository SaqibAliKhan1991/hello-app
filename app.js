const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Hello world 🚀");
});

app.listen(3000, () => console.log("Running on port 3000"));
