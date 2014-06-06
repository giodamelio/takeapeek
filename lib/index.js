var http = require("http");

var highland = _ = require("highland");
var debug = require("debug")("takeapeek:server");

takeapeek = function(options) {
    this.options = options;
    
    // Create our server
    this.server = http.createServer(function (req, res) {
        debug("Sending Hello World");
        res.writeHead(200, {"Content-Type": "text/plain"});
        res.end("Hello World");
    });
};

// Start our server
takeapeek.prototype.listen = function() {
    debug("Listening on port", this.options.get("port"));
    this.server.listen(this.options.get("port"));
};

// Export our class
module.exports = takeapeek;

