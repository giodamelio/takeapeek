// This still seems a little weird see https://github.com/Microsoft/TypeScript/issues/3337
import * as path from 'path';
import * as fs from 'fs';

import * as express from 'express';
import * as nconf from 'nconf';
import * as handlebars from 'handlebars';
import * as morgan from 'morgan';

import './config';

if (nconf.get('help')) {
  console.log('Usage: takepeek <args>\n');
  nconf.stores.argv.showHelp();
  console.log('Invert boolean options with "no" prefix (e.g. --no-index)\n');
  process.exit(0);
}

if (nconf.get('quiet')) {
  // Make console.log quiet
  console.log = function() {}
}

// Resolve the directory we are serving
const DIRECTORY = path.resolve(process.cwd(), nconf.get('directory'));

// Setup our index page
const indexTemplate = handlebars.compile(
  fs.readFileSync(path.resolve(__dirname, '../index.html')).toString()
);

const app = express();

// Log the requests
if (!nconf.get('quiet')) {
  app.use(morgan('dev'));
}

// Serve the directory
// Turn expresses indexes off, we are making our own
app.use(express.static(DIRECTORY, {
  index: false,
  setHeaders(res, path, stat) {
    if (nconf.get('content-text')) {
      res.set('Content-Type', 'text/plain');
    }
  },
}));

// Serve the index
if (nconf.get('index')) {
  app.use(function(req, res, next) {
    const dir = path.join(DIRECTORY, req.url);
    if (fs.existsSync(dir)) {
      // List the directory
      const children = fs.readdirSync(dir)
        // Filter out hidden files and directories unless specfied
        .filter(function(file) {
          if (!nconf.get('hidden')) {
            return file[0] !== '.';
          }
          return true;
        });

      // Render our template
      const page = indexTemplate({
        directory: req.url,
        children,
      });

      res.send(page);
    } else {
      next();
    }
  });
}

// The file or directory does not exist
app.use(function(req, res) {
  res.status(400);
  res.send('The file or directory does not exist');
});

app.listen(nconf.get('port'), function() {
  console.log(`takepeek listening at http://localhost:${nconf.get('port')}`);
});
