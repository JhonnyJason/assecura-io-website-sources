indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.heroGrid = document.getElementById("hero-grid")
    global.header = document.getElementById("header")
    global.navigationBar = document.getElementById("navigation-bar")
    return
    
module.exports = indexdomconnect