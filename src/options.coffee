module.exports = 
    "d":
        alias: "directory"
        describe: "The directory to serve."
        default: "."
    "i":
        alias: "index"
        describe: "Show directory indexes."
        default: true
        boolean: true
    "n":
        alias: "dotfiles"
        describe: "Show dotfiles."
        default: false
        boolean: true
    "p":
        alias: "port"
        describe: "The port to serve on."
        default: 3141
    "c":
        alias: "config"
        describe: "Specify config file"
    "v":
        alias: "verbose"
        describe: "Verbose logging."
        default: false
        boolean: true
    "q":
        alias: "quite"
        describe: "Quite mode. No output"
        default: false
        boolean: true
    "V":
        alias: "version"
        describe: "Print the version info."
        default: false
        boolean: true
    "h":
        alias: "help"
        describe: "Prints this help."
