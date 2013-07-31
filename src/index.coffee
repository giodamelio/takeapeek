path = require "path"

connect = require "connect"
colors = require "colors"

module.exports = class takeapeek
    constructor: (@options) ->
        # Fix the path if it is . or ..
        if not @options.directory.match(/^\//)
            @options.directory = path.normalize(__dirname + "/" + @options.directory)

        @server = connect()

        # Serve directory listings
        @server.use connect.directory(@options.directory, { hidden: @options.dotfiles })

        # Serve the files
        @server.use connect.static(@options.directory, { hidden: @options.dotfiles })

        # Serve the error pages
        @server.use "/takeapeekstatic-3141", connect.static(path.normalize(__dirname + "/../static"))

    listen: ->
        console.log "Serving static file from directory".green, "#{@options.directory}".cyan, "on port".green, "#{@options.port}".cyan
        @server.listen @options.port
        
