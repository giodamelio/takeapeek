#!/usr/bin/env node
var path = require("path");
var fs = require("fs");

var nconf = require("nconf");
var debug = require("debug")("takeapeek:commandline");

// Load our configuration
debug("Loading configuration");
nconf
    // Load the command line arguments
    .argv({
        "directory": { alias: "d", default: "." },
        "index": { alias: "i", default: true, boolean: true },
        "dotfiles": { alias: "n", default: false, boolean: true },
        "port": { alias: "p", default: 3141 },
        "config": { alias: "c", },
        "content": { alias: "t-text", default: false, boolean: true },
        "quiet": { alias: "q", default: false, boolean: true },
        "version": { alias: "V", default: false, boolean: true },
        "help": { alias: "h" }
    })
    // Load the enviroment variables
    .env()
    // Load from cwd's config file
    .file(path.join(__dirname, ".takeapeekrc"))
    // Load from global config
    .file(path.join(getUserHome(), ".takeapeekrc"))
    // Set our defaults
    .defaults({
        "port": 3141
    });

// If help is called, print it then exit
if (nconf.get("h")) {
    console.log(fs.readFileSync(path.join(__dirname, "usage.txt")).toString());
    process.exit(0);
}

// Setup our server with our options
var takeapeek = require("./index.js");

// Make an instence of our server and start it
var server = new takeapeek(nconf);
server.listen();

// Cross platform home directory location
function getUserHome() {
    return process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE;
}

