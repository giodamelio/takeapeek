child_process = require "child_process"
fs = require "fs"

path = 
    coffeescript: "node_modules/.bin/coffee"

spawn = (cmd, options) ->
    
    p = child_process.spawn cmd, options.split " "
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()

task "coffee:compile", "Compile the coffeescript", ->
    spawn path.coffeescript, "--compile --output lib/ src/"

task "coffee:watch", "Compile and watch the coffeescript", ->
    spawn path.coffeescript, "--watch --compile --output lib/ src/"
    
task "publish", "Compiles and publishes to npm", ->
    # Compile the coffeescript
    p = child_process.spawn path.coffeescript, "--compile --output lib/ src/".split " "
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()

    p.on "exit", ->
        # Add a hashbang to the cmd.js
        cmdjs = fs.readFileSync "lib/cmd.js"
        cmdjs = "#!/usr/bin/env node\n" + cmdjs
        fs.writeFileSync "lib/cmd.js", cmdjs

        # Publish to npm
        spawn "npm", "publish"