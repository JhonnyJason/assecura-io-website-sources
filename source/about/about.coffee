import Modules from "./allmodules"
import domconnect from "./cyberprotectdomconnect"
domconnect.initialize()

global.allModules = Modules

############################################################
global.aboutFlag = true

############################################################
appStartup = ->
    ## TODO implement
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