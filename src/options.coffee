module.exports = 
    "d":
        alias: "directory"
        describe: "The directory to serve."
        default: "."
    "i":
        alias: "index"
        describe: "Show directory indexes."
        default: true
    "n":
        alias: "dotfiles"
        describe: "Show dotfiles."
        default: false
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
    "q":
        alias: "quite"
        describe: "Quite mode. No output"
        default: false
    "V":
        alias: "version"
        describe: "Print the version info."
        default: false
    "h":
        alias: "help"
        describe: "Prints this help."
        default: false
