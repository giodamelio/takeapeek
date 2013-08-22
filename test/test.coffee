fs = require "fs"

request = require "request"

takeapeek = require ".."

before ->
    # Delete the files if they exist
    if fs.existsSync("test/testfiles")
        fs.unlinkSync "test/testfiles/file.txt"
        fs.unlinkSync "test/testfiles/file with space.html"
        fs.unlinkSync "test/testfiles/.hiddenfile"
        fs.rmdirSync "test/testfiles"

    # Make some test files
    fs.mkdirSync "test/testfiles"
    fs.writeFileSync "test/testfiles/file.txt", "Hello World!"
    fs.writeFileSync "test/testfiles/file with space.html", "<strong>Hello There!!!</strong>"
    fs.writeFileSync "test/testfiles/.hiddenfile", "I am a stealthy ninja"

describe "basic", ->
    server = new takeapeek
        directory: "./test/testfiles"
        port: 3141
        quiet: true

    before ->
        # Start a server
        server.listen()

    it "should serve text file", (done) ->
        request.get "http://localhost:3141/file.txt", (err, res, body) ->
            body.should.equal "Hello World!"
            res.should.have.status 200
            done()

     it "should serve file with spaces in the name", (done) ->
        request.get "http://localhost:3141/file with space.html", (err, res, body) ->
            body.should.equal "<strong>Hello There!!!</strong>"
            res.should.have.status 200
            done()

    it "should not serve hidden files", (done) ->
        request.get "http://localhost:3141/.hiddenfile", (err, res, body) ->
            res.should.have.status 404
            done()

    it "should 404 for non existent files", (done) ->
        request.get "http://localhost:3141/non_existent_file.txt", (err, res, body) ->
            res.should.have.status 404
            done()

    after ->
        server.close()

describe "options", ->
    describe "directory", ->
        server = new takeapeek
            directory: "./test"
            port: 3141
            quiet: true

        before ->
            # Start a server
            server.listen()

        it "should serve the correct directory", (done) ->
            request.get "http://localhost:3141/mocha.opts", (err, res, body) ->
                body.should.equal fs.readFileSync("./test/mocha.opts").toString()
                res.should.have.status 200
                done()

        after ->
            server.close()

    describe "index", ->
        server = new takeapeek
            directory: "./test/testfiles"
            port: 3141
            quiet: true
            index: true

        before ->
            # Start a server
            server.listen()

        it "should serve directory indexes", (done) ->
            request.get "http://localhost:3141/", (err, res, body) ->
                res.should.have.header "content-type", "text/html"
                res.should.have.status 200
                done()

        it "should 404 for non existent folders", (done) ->
            request.get "http://localhost:3141/non_existent_folder", (err, res, body) ->
                res.should.have.status 404
                done()

        after ->
            server.close()

    describe "dotfiles", ->
        server = new takeapeek
            directory: "./test/testfiles"
            port: 3141
            quiet: true
            dotfiles: true

        before ->
            # Start a server
            server.listen()

        it "should serve hidden files", (done) ->
            request.get "http://localhost:3141/.hiddenfile", (err, res, body) ->
                body.should.equal "I am a stealthy ninja"
                res.should.have.status 200
                done()

        after ->
            server.close()

    describe "port", ->
        server = new takeapeek
            directory: "./test/testfiles"
            port: 10023
            quiet: true

        before ->
            # Start a server
            server.listen()

        it "should serve on a different port", (done) ->
            request.get "http://localhost:10023/file.txt", (err, res, body) ->
                body.should.equal "Hello World!"
                res.should.have.status 200
                done()

        after ->
            server.close()

    describe "content-text", ->
        options = 
            directory: "./test/testfiles"
            port: 3141
            quiet: true
        options["content-text"] = true
        server = new takeapeek options

        before ->
            # Start a server
            server.listen()

        it "should serve files as 'content-type: text/plain'", (done) ->
            request.get "http://localhost:3141/file with space.html", (err, res, body) ->
                res.should.have.header "content-type", "text/plain"
                res.should.have.status 200
                done()

        after ->
            server.close()

after ->
    # Delete the test files
    fs.unlinkSync "test/testfiles/file.txt"
    fs.unlinkSync "test/testfiles/file with space.html"
    fs.unlinkSync "test/testfiles/.hiddenfile"
    fs.rmdirSync "test/testfiles"