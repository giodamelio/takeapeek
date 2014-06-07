var http = require("http");
var fs = require("fs");
var path = require("path");

var _ = require("highland");
var debug = require("debug")("takeapeek:server");

takeapeek = function(options) {
    var self = this;
    self.options = options;
    
    // Create our server
    self.server = http.createServer(function (req, res) {
        this.req = req;
        this.res = res;

        // Handle favicon
        self.favicon.call(this);

        // Serve a single file
        self.serveFile.call(this, path.join(process.cwd(), req.url));
    });
};

// Start our server
takeapeek.prototype.listen = function() {
    debug("Listening on port", this.options.get("port"));
    this.server.listen(this.options.get("port"));
};

// Serve a file
takeapeek.prototype.serveFile = function(filePath) {
    _(fs.createReadStream(filePath))
        .pipe(this.res);
};

// Serve favicon.ico if it exists, otherwise ignore it
takeapeek.prototype.favicon = function() {
    var faviconPath = path.join(process.cwd(), "favicon.ico");
    if (this.req.url == "/favicon.ico") {
        fs.exists(faviconPath, function(exists) {
            debug(exists);
            if (exists) {
                _(fs.createReadStream(faviconPath))
                    .pipe(this.res);
            } else {
                this.res.writeHead(404);
                this.res.end();
            }
        });
    }
};

// Export our class
module.exports = takeapeek;

