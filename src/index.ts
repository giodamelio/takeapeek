// This still seems a little weird see https://github.com/Microsoft/TypeScript/issues/3337
import * as express from 'express';
import * as nconf from 'nconf';

import './config';

const app = express();

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.listen(nconf.get('port'), function() {
  console.log(`takepeek listening at http://localhost:${nconf.get('port')}`);
});
