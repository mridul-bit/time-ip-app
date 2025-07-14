const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    const response = {
        timestamp: new Date().toISOString(),
	ip: req.headers['x-forwarded-for'] || req.connection.remoteAddress    };
    res.json(response);
});

app.listen(port, () => {
    console.log(`time-ip-app running on port ${port}`);
});

