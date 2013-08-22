fs = require "fs"

request = require "request"

takeapeek = require ".."

before ->
    # Make some test files
    fs.mkdirSync "test/testfiles"
    fs.writeFileSync "test/testfiles/file.txt", "Hello World!"
    fs.writeFileSync "test/testfiles/file with space.html", "<strong>Hello There!!!</strong>"

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

    it "should 404 for non existent files", (done) ->
        request.get "http://localhost:3141/non_existent_file.txt", (err, res, body) ->
            res.should.have.status 404
            done()


    after ->
        server.close()

after ->
    # Delete the test files
    fs.unlinkSync "test/testfiles/file.txt"
    fs.unlinkSync "test/testfiles/file with space.html"
    fs.rmdirSync "test/testfiles"