deepdivedomconnect = {name: "deepdivedomconnect"}

############################################################
deepdivedomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.firewall3Frame = document.getElementById("firewall3-frame")
    global.firewall3ImagesBlock = document.getElementById("firewall3-images-block")
    global.firewall2Frame = document.getElementById("firewall2-frame")
    global.firewall2Decoration = document.getElementById("firewall2-decoration")
    global.firewall1Frame = document.getElementById("firewall1-frame")
    global.firewall1ImagesBlock = document.getElementById("firewall1-images-block")
    global.header = document.getElementById("header")
    global.navigationBar = document.getElementById("navigation-bar")
    return
    
module.exports = deepdivedomconnect