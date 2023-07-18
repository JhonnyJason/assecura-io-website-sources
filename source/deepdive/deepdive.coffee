import Modules from "./allmodules"
import domconnect from "./cyberprotectdomconnect"
domconnect.initialize()

global.allModules = Modules

############################################################
global.deepDiveFlag = true

############################################################
appStartup = ->
    heading = cyberprotectButton.parentElement
    activatableContainer = heading.parentElement
    connectActivation(cyberprotectButton, activatableContainer)
    return

connectActivation = (button, container) ->
    switchFunction = -> container.classList.toggle("active")
    button.addEventListener("click", switchFunction)
    return



############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()