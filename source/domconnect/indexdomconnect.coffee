indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.contactusSection = document.getElementById("contactus-section")
    global.contactusCalltoactionFrame = document.getElementById("contactus-calltoaction-frame")
    global.smartbrokerSection = document.getElementById("smartbroker-section")
    global.dangerSection = document.getElementById("danger-section")
    global.dangerImagesBlock = document.getElementById("danger-images-block")
    global.heroGrid = document.getElementById("hero-grid")
    global.header = document.getElementById("header")
    global.navigationBar = document.getElementById("navigation-bar")
    return
    
module.exports = indexdomconnect