takeapeek
=========
[![NPM version](https://badge.fury.io/js/takeapeek.png)](https://npmjs.org/package/takeapeek) [![Dependency Status](https://gemnasium.com/giodamelio/takeapeek.png)](https://gemnasium.com/giodamelio/takeapeek)

[![NPM](https://nodei.co/npm/takeapeek.png)](https://nodei.co/npm/takeapeek/)

A simple static webserver with only one command. Heavily inspired by [glance](https://github.com/jarofghosts/glance), this is really more of a learning experience then anything.

Install
-------

You can install from npm

    npm install -g takeapeek

Usage
-----

    --directory, -d     The directory to serve          [string]  [default: "."]
    --index, -i         Show directory indexs           [boolean] [default: true]
    --hidden            Show hidden files               [boolean] [default: false]
    --port, -p          The port the serve on                     [default: 3141]
    --content-text, -t  Serve all files with content-type of 'text/plain'
                                                        [boolean] [default: false]
    --quiet, -q         Print nothing                   [boolean] [default: false]
    --help, -h          Prints help

Config files
------------

takeapeek will automaticly check `.takeapeek.json` and `~/.takeapeek.json`.

License
-------

This repo is licensed under the MIT license. See `./LICENSE` for the full text.
