import Modules from "./allmodules"
import domconnect from "./indexdomconnect"
domconnect.initialize()

global.allModules = Modules

############################################################
appStartup = ->
    ## which modules shall be kickstarted?
    # Modules.appcoremodule.startUp()
    document.addEventListener("scroll", scrolled)
    return

scrolled = (evnt) ->
    offset = window.scrollY
    # console.log(offset)
    heroHeight = header.offsetHeight + 0.5 *  window.innerHeight
    orangeEnd = document.body.offsetHeight - footer.offsetHeight - 0.5 * window.innerHeight

    console.log("orangeEnd: #{orangeEnd}")
    if offset > heroHeight and offset < orangeEnd then document.body.classList.add("orange")
    else document.body.classList.remove("orange")
    
############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()