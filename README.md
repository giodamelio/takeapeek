takeapeek
=========

A simple static webserver with only one command. Heavily inspired by [glance](https://github.com/jarofghosts/glance), this is really more of a learning experience then anything.

Usage
-----

    -d, --directory     The directory to serve.                            [default: "."]
    -i, --index         Show directory indexes.                            [default: true]
    -n, --dotfiles      Show dotfiles.                                     [default: false]
    -p, --port          The port to serve on.                              [default: 3141]
    -c, --config        Specify config file                              
    -t, --content-text  Serve all files with content-type of 'text/plain'  [default: false]
    -v, --verbose       Verbose logging.                                   [default: false]
    -q, --quite         Quite mode. No output                              [default: false]
    -V, --version       Print the version info.                            [default: false]
    -h, --help          Prints this help.

Config files
------------

takeapeek will automaticly check `.takeapeekrc` and `~/.takeapeekrc`, you can specify a specific config file with the `-c` option.

Config files are parsed as if they were options on the command line. E.g.

    -d .. -v

Would serve the parent directory verbosely