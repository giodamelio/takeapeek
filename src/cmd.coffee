fs = require "fs"
_ = require "lodash"

optimist = require "optimist"

options_hash = require("./options")
options = optimist.options(options_hash)

# Get the options from the cli
command_line_args = options.argv

# Get options from specified config file
if command_line_args.c
    try
        specified_config_args = optimist.parse(fs.readFileSync(command_line_args.c).toString().split(" "))
    catch error
        console.log "Config file cannot be read or does not exist"
        process.exit 0
else
    specified_config_args = {}

# Get options from local config file
try
    local_config_args = optimist.parse(fs.readFileSync(__dirname + "/.takeapeekrc").toString().split(" "))
catch
    local_config_args = {}

# Get options from global config file
try
    global_config_args = optimist.parse(fs.readFileSync(process.env.HOME + "/.takeapeekrc").toString().split(" "))
catch
    global_config_args = {}

# Prune the default from global, local and specified to keep from overwriting during the merge
for k, v of options_hash
    if global_config_args[k] == options_hash[k].default
        delete global_config_args[k]
        delete global_config_args[options_hash[k].alias]
    if local_config_args[k] == options_hash[k].default
        delete local_config_args[k]
        delete local_config_args[options_hash[k].alias]
    if specified_config_args[k] == options_hash[k].default
        delete specified_config_args[k]
        delete specified_config_args[options_hash[k].alias]

# Merge the arguments from all the sources
argv = _.extend(command_line_args, specified_config_args, local_config_args, global_config_args)

# Print the help
if argv.h == true
    console.log options.help()
    process.exit 0

# Print the version info
if argv.V == true
    {normalize} = require "path"
    console.log require(normalize(__dirname + "/../package.json")).version
    process.exit 0

# Create the server
takeapeek = require "./index"
server = new takeapeek argv
server.listen()
