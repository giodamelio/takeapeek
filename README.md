takeapeek
=========
[![NPM version](https://badge.fury.io/js/takeapeek.png)](https://npmjs.org/package/takeapeek) [![Dependency Status](https://gemnasium.com/giodamelio/takeapeek.png)](https://gemnasium.com/giodamelio/takeapeek)

[![NPM](https://nodei.co/npm/takeapeek.png)](https://nodei.co/npm/takeapeek/)

A simple static webserver with only one command. Heavily inspired by [glance](https://github.com/jarofghosts/glance), this is really more of a learning experience then anything.

Install
-------

You can install from npm

    sudo npm install -g takeapeek

Or get the latest from github(not really necessary, I push to npm often)

    sudo npm install -g https://github.com/giodamelio/takeapeek.git

Usage
-----

    -d, --directory     The directory to serve.                            [default: "."]
    -i, --index         Show directory indexes.                            [default: true]
    -n, --dotfiles      Show dotfiles.                                     [default: false]
    -p, --port          The port to serve on.                              [default: 3141]
    -c, --config        Specify config file                              
    -t, --content-text  Serve all files with content-type of 'text/plain'  [default: false]
    -v, --verbose       Verbose logging.                                   [default: false]
    -q, --quiet         Quiet mode. No output                              [default: false]
    -V, --version       Print the version info.                            [default: false]
    -h, --help          Prints this help.

Config files
------------

takeapeek will automaticly check `.takeapeekrc` and `~/.takeapeekrc`, you can specify a specific config file with the `-c` option.

Config files are parsed as if they were options on the command line. E.g.

    -d .. -v

Would serve the parent directory verbosely

Using as a module
-----------------

You can use takeapeek as a module if you want.

    takeapeek = require "takeapeek"
    tap = new takeapeek options 

The options line up to the long names in the usage above.

Thanks
------

This project would have been a real pain in the ass without these awesome FOSS projects.

 - [Connect](https://github.com/senchalabs/connect)
 - [Optimist](https://github.com/substack/node-optimist)
 - [lodash](https://github.com/bestiejs/lodash/)
 - [colors](https://github.com/Marak/colors.js)