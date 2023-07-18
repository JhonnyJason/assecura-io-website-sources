cyberprotectdomconnect = {name: "cyberprotectdomconnect"}

############################################################
cyberprotectdomconnect.initialize = () ->
    global.footer = document.getElementById("footer")
    global.cyberprotectButton = document.getElementById("cyberprotect-button")
    global.header = document.getElementById("header")
    global.navigationBar = document.getElementById("navigation-bar")
    return
    
module.exports = cyberprotectdomconnect