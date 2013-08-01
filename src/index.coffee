path = require "path"

connect = require "connect"
colors = require "colors"

module.exports = class takeapeek
    constructor: (@options) ->
        # Fix the path if it is . or ..
        if not @options.directory.match(/^\//)
            @options.directory = path.normalize(__dirname + "/" + @options.directory)

        # Overwrite console if we are in quite mode
        if @options.quite and not @options.verbose
            console["log"] = ->

        # Create the server
        @server = connect()

        # Setup the logger if we are in verbose mode
        if @options.verbose and not @options.quite
            @server.use connect.logger "dev"

        # Serve directory listings
        if @options.index
            @server.use connect.directory(@options.directory, { hidden: @options.dotfiles })

        # Serve the files
        @server.use connect.static(@options.directory, { hidden: @options.dotfiles })

        # Serve the error pages
        @server.use "/takeapeekstatic-3141", connect.static(path.normalize(__dirname + "/../static"))

    listen: ->
        # Print a startup message unless we are in quite mode
        console.log "Serving static file from directory".green, "#{@options.directory}".cyan, "on port".green, "#{@options.port}".cyan
        @server.listen @options.port
        
