const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
 
app.get('/', (req, res) => {
  res.send('Hello Heena! This is your Dockerized Node.js App running on EKS 🚀');
});
 
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
