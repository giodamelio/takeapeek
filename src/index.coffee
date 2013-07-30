{normalize} = require "path"

connect = require "connect"
colors = require "colors"

module.exports = class takeapeek
    constructor: (@options) ->
        @server = connect()
        @server.use connect.directory(normalize(__dirname + "/" + @options.directory), { hidden: @options.dotfiles })
        @server.use connect.static(normalize(__dirname + "/" + @options.directory), { hidden: @options.dotfiles })

    listen: ->
        console.log "Serving static file from directory #{@options.directory} on port #{@options.port}"
        @server.listen @options.port
        
