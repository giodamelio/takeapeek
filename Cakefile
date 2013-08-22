child_process = require "child_process"
fs = require "fs"

path = 
    coffeescript: "node_modules/.bin/coffee"
    supervisor: "node_modules/.bin/supervisor"

spawn = (cmd, options, callback) ->
    p = child_process.spawn cmd, options.split " "
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()
    p.on "exit", ->
        callback?()

task "watch", "watch the coffeescript and server", ->
    invoke "coffee:watch"
    invoke "supervisor:watch"

task "coffee:compile", "Compile the coffeescript", ->
    spawn path.coffeescript, "--compile --output lib/ src/"

task "coffee:watch", "Compile and watch the coffeescript", ->
    spawn path.coffeescript, "--watch --compile --output lib/ src/"

task "supervisor:watch", "use supervisor to auto reload the server", ->
    spawn path.supervisor, "-- lib/cmd.js -d .. -v"

task "publish", "Compiles and publishes to npm", ->
    # Compile the coffeescript
    spawn path.coffeescript, "--compile --output lib/ src/", ->
        # Add a hashbang to the cmd.js
        cmdjs = fs.readFileSync "lib/cmd.js"
        cmdjs = "#!/usr/bin/env node\n" + cmdjs
        fs.writeFileSync "lib/cmd.js", cmdjs

        # Publish to npm
        spawn "npm", "publish"
