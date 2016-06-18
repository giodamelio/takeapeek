// This still seems a little weird see https://github.com/Microsoft/TypeScript/issues/3337
import * as express from 'express';

import config from './config';

const app = express();

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.listen(config.port, function() {
  console.log(`takepeek listening at http://localhost:${config.port}`);
});
