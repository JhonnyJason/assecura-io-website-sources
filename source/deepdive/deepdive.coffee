import Modules from "./allmodules"
import domconnect from "./cyberprotectdomconnect"
import * as commonthreats from "./commonthreats.js"
domconnect.initialize()
commonthreats.initialize()

global.allModules = Modules

############################################################
global.deepDiveFlag = true

############################################################
appStartup = ->
    containers = document.getElementsByClassName("activatable-container")
    connectContainer(c) for c in containers
    Modules.scrolltriggersmodule.addTriggerFunction(commonthreats.onScroll)
    return

connectContainer = (container) ->
    button = container.getElementsByTagName("button")[0]
    if button? 
        switchFunction = -> container.classList.toggle("active")
        button.addEventListener("click", switchFunction)
    else console.log("Warning! Container did not have a button!")
    return



############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()