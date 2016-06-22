// This still seems a little weird see https://github.com/Microsoft/TypeScript/issues/3337
import * as express from 'express';
import * as nconf from 'nconf';

import './config';

if (nconf.get('help')) {
  console.log('Usage: takepeek <args>\n');
  nconf.stores.argv.showHelp();
  console.log('Invert boolean options with no prefix (e.g. --no-index)\n');
  process.exit(0);
}

const app = express();

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.listen(nconf.get('port'), function() {
  console.log(`takepeek listening at http://localhost:${nconf.get('port')}`);
});
