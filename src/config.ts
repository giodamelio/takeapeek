import * as path from 'path';
import * as os from 'os';

import * as nconf from 'nconf';

// Get the config. In order of precedence
nconf
  .env()
  .argv()

  // A config file in the current directoy
  .file(path.join(process.cwd(), '.takepeek.json'))

  // A config file in the users home directory
  .file(path.join(os.homedir(), '.takepeek.json'))

  .defaults({
    port: 3141,
  });
