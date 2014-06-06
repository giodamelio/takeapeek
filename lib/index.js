var http = require("http");

var highland = _ = require("highland");

takeapeek = function(options) {
    this.options = options;
    
    // Create our server
    this.server = http.createServer(function (req, res) {
        res.writeHead(200, {"Content-Type": "text/plain"});
        res.end("Hello World");
    });
};

// Start our server
takeapeek.prototype.listen = function() {
    this.server.listen(this.options.get("port"));
};

// Export our class
module.exports = takeapeek;

