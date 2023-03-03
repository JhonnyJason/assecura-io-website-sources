indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.introTextLeft = document.getElementById("intro-text-left")
    global.introTextRight = document.getElementById("intro-text-right")
    global.header = document.getElementById("header")
    return
    
module.exports = indexdomconnect