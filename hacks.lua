local f = io.open('test.md', 'w')
    f:write(" ", "\n")
    f:write(" ", "\n")
    f:write('# Title', "\n")
    f:write(" ", "\n")
    f:write("* * *", "\n")
    f:write("* * *", "\n")
    f:write(" ", "\n")
    f:write("Score distribution", "\n")
    f:write(" ", "\n")
    f:write("![ST](/infos/ST.jpg)", "\n")
    f:close()
    os.execute( 'open test.md' )