var http = require("http");
var fs = require("fs");
var path = require("path");

var connect = require("connect");
var _ = require("highland");
var debug = require("debug")("takeapeek:server");

// Create the middleware
takeapeek = function(options) {
    var self = this;
    self.options = options;
    
    return function(req, res, next) {
        this.req = req;
        this.res = res;
        this.next = next;

        var filePath = path.join(process.cwd(), req.url);

        // Check if the file or directory exists
        if (fs.existsSync(filePath)) {
            // If the path is a file, serve it
            var info = fs.statSync(filePath);
            if (info.isFile()) {
                serveFile.call(this, filePath);
            }
        } else {
            res.writeHead(404);
            res.end("Error 404: " + this.req.url + " does not exist");
        }
    };
};

// Serve a file
serveFile = function(filePath) {
    debug("Serving file:", filePath);
    _(fs.createReadStream(filePath))
        .pipe(this.res);
};

// Export our middleware
module.exports.middleware = takeapeek;

// Simple constructor
var constructor = function(options) {
    this.options = options;

    // Create the app
    var app = connect();

    //Use our middleware
    app.use(takeapeek(options));

    // Create the http server
    debug("Creating app");
    this.server = http.createServer(app);
};

constructor.prototype.listen = function() {
    debug("Listening on port", this.options.get("port"));
    this.server.listen(this.options.get("port"));
};

module.exports = constructor;

