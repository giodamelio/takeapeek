path = 
    coffeescript: "node_modules/.bin/coffee"

spawn = (cmd, options) ->
    child_process = require "child_process"
    p = child_process.spawn cmd, options.split " "
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()

task "coffee:compile", "Compile the coffeescript", ->
    spawn path.coffeescript, "--compile --output lib/ src/"

task "coffee:watch", "Compile and watch the coffeescript", ->
    spawn path.coffeescript, "--watch --compile --output lib/ src/"
    