import * as path from 'path';
import * as os from 'os';

import * as nconf from 'nconf';

// Get the config. In order of precedence
nconf
  .env()
  .argv({
    directory: {
      alias: 'd',
      default: '.',
      describe: 'The directory to serve',
      type: 'string',
    },
    index: {
      alias: 'i',
      default: true,
      describe: 'Show directory indexs',
      type: 'boolean',
    },
    hidden: {
      default: false,
      describe: 'Show hidden files',
      type: 'boolean',
    },
    port: {
      alias: 'p',
      default: 3141,
      describe: 'The port the serve on',
      type: 'number',
    },
    'content-text': {
      alias: 't',
      default: false,
      describe: `Serve all files with content-type of 'text/plain'`,
      type: 'boolean',
    },
    quiet: {
      alias: 'q',
      default: false,
      describe: 'Print nothing',
      type: 'boolean',
    },
    help: {
      alias: 'h',
      describe: 'Prints help',
    },
  })

  // A config file in the current directoy
  .file(path.join(process.cwd(), '.takepeek.json'))

  // A config file in the users home directory
  .file(path.join(os.homedir(), '.takepeek.json'));
