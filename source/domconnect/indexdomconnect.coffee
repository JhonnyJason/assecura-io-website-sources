indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.smartbrokerSection = document.getElementById("smartbroker-section")
    global.heroGrid = document.getElementById("hero-grid")
    global.header = document.getElementById("header")
    return
    
module.exports = indexdomconnect