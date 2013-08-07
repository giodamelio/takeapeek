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
                    res.setHeader "Content-Type", "text/html"

                    # Read the template
                    template = fs.readFileSync path.normalize(__dirname + "/../static/template.html")

                    # Replace the title
                    template = template.toString().split("###title###").join(req.url)

                    # Split the template
                    template = template.split "###content###"

                    # Write the first half of the template
                    res.write template[0]

                    # Write the directory list
                    res.write "<ul class='list-unstyled'>"

                    # Write a link to the parent dir unless you are in the root dir
                    if req.url != "/"
                        parentdir = path.resolve req.url, ".."
                        res.write "<li><a href='#{parentdir}'>..</a></li>"

                    # write a link to the files and dirs
                    for file in files
                        filepath = path.join req.url, file
                        res.write "<li><a href='#{filepath}'>#{file}</a></li>"
                    res.write "</ul>"

                    # Write the second half of the template
                    res.write template[1]

                    res.end()
            else
                next()

module.exports = class takeapeek
    constructor: (@options) ->
        # Fix the path if it is . or ..
        if not @options.directory.match(/^\//)
            @options.directory = path.normalize(process.cwd() + "/" + @options.directory)

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
            @server.use (req, res, next) ->
                if req.url.split("/")[1] != "takeapeekstatic-3141"
                    # Colorize status
                    if res.statusCode >= 400
                        status = res.statusCode.toString().red
                    else if res.statusCode < 400
                        status = res.statusCode.toString().green
                    
                    # Log it
                    console.log req.method.grey, req.originalUrl.grey, status
                next()

        # Serve the error pages
        @server.use "/takeapeekstatic-3141", connect.static(path.normalize(__dirname + "/../static"))

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
                    console.log error
                next()

        # Serve the files
        @server.use connect.static(@options.directory, { hidden: @options.dotfiles })
        

    listen: ->
        # Print a startup message unless we are in quite mode
        console.log "Serving static file from directory".green, "#{@options.directory}".cyan, "on port".green, "#{@options.port}".cyan
        @server.listen @options.port
        
