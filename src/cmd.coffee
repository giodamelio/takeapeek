nconf = require "nconf"
nconf
    .env()
    .argv(
        "h":
            alias: "help"
        "d":
            alias: "directory"
            default: "."
        "i":
            alias: "index"
            default: true
        "n":
            alias: "dotfiles"
            default: false
        "p":
            alias: "port"
            default: 3141
        "o":
            alias: "host"
            default: "127.0.0.1"
        "v":
            alias: "verbose"
            default: false
        "V":
            alias: "version"
            default: false
    )
    .file(process.env.HOME + "/.takeapeek.json")
    .defaults(
        default: "yep"
    )

# Print the help
if nconf.get("h") == true
    console.log """
    \t Usage: takeapeek [options]
    \t A simple static webserver with only one command
    
    \t -d, --directory \t The directory to serve. [.]
    \t -i, --index \t\t Show directory indexes. [true]
    \t -n, --dotfiles \t Show dotfiles. [false]
    \t -p, --port \t\t The port to serve on. [3141]
    \t -v, --verbose \t\t Verbose logging. [false]
    \t -V, --version \t\t Print the version info.
    \t -h, --help \t\t Prints this help.
    """
    process.exit 0

# Print the version info
if nconf.get("V") == true
    {normalize} = require "path"
    console.log require(normalize(__dirname + "/../package.json")).version
    process.exit 0

# Create the server
takeapeek = require "./index"
server = new takeapeek
    directory: nconf.get "directory"
    index: nconf.get "index"
    dotfiles: nconf.get "dotfiles"
    port: nconf.get "port"
    verbose: nconf.get "verbose"
server.listen()