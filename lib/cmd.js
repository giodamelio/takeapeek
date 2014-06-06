#!/usr/bin/env node
path = require("path");

nconf = require("nconf");
debug = require("debug")("takeapeek:commandline");

// Load our configuration
debug("Loading configuration");
nconf
    // Load the command line arguments
    .argv()
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

// Setup our server with our options
takeapeek = require("./index.js");

// Make an instence of our server and start it
server = new takeapeek(nconf);
server.listen();

// Cross platform home directory location
function getUserHome() {
    return process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE;
}

