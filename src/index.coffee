path = require "path"
fs = require "fs"

connect = require "connect"
colors = require "colors"

directoryIndex = (directory, options) ->
    return (req, res, next) ->
        fs.stat path.join(directory, req.url), (err, stats) ->
            if err then throw err
            if stats.isDirectory()
                fs.readdir path.join(directory, req.url), (err, files) ->
                    for file in files
                        res.write file + "\n"
                    res.end()
            else
                next()

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

        # Git rid of annoying favicon requests unless /favicon.ico exists
        @server.use (req, res, next) ->
            if req.url == "/favicon.ico"
                fs.exists "favicon.ico", (exists) ->
                    if exists
                        next()
                    else
                        res.end()
            else
                next()

        # Setup the logger if we are in verbose mode
        if @options.verbose and not @options.quite
            @server.use connect.logger "dev"

        # Serve directory listings
        if @options.index
            #@server.use connect.directory(@options.directory, { hidden: @options.dotfiles })
            @server.use directoryIndex(@options.directory, { hidden: @options.dotfiles })

        # Serve all files as text/plain if content-text
        if @options["content-text"]
            @server.use (req, res, next) ->
                try
                    res.setHeader "Content-Type", "text/plain"
                catch error
                    #console.log error
                next()

        # Serve the files
        @server.use connect.static(@options.directory, { hidden: @options.dotfiles })

        # Serve the error pages
        @server.use "/takeapeekstatic-3141", connect.static(path.normalize(__dirname + "/../static"))
        

    listen: ->
        # Print a startup message unless we are in quite mode
        console.log "Serving static file from directory".green, "#{@options.directory}".cyan, "on port".green, "#{@options.port}".cyan
        @server.listen @options.port
        
