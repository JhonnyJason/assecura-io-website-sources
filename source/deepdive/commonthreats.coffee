############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("commonthreats")
#endregion

############################################################
import *  as v from "./vanillautilmodule.js"

############################################################
borders = {}
navElements = {}
contentElements = {}

############################################################
activeThreat = 1

############################################################
export initialize = ->
    log "initialize"

    for num in [1..5]
        navElements[num] = document.getElementById("nav-threat#{num}")
        contentElements[num] = document.getElementById("threat#{num}")
        borders[num] = header.offsetHeight + (num - 1) * window.innerHeight
        borders["nav-threat#{num}"] = borders[num]
        navElements[num].addEventListener("click", onNavClick)
        log "initialized threat: #{num}"

    return
############################################################
setThreatActive = (num) ->
    return unless activeThreat != num
    #set old active to inactive
    navElements[activeThreat].classList.remove("active")
    contentElements[activeThreat].classList.remove("active")

    #set new active to active
    activeThreat = num
    navElements[activeThreat].classList.add("active")
    contentElements[activeThreat].classList.add("active")
    return

onNavClick = (evnt) ->
    log "onNavClick"
    log evnt.target.id
    top = borders[evnt.target.id]
    
    if window.scrollY < borders[1] or window.scrollY > borders[5]
        behavior = "smooth"
    else behavior = "instant"
    
    options = { top, behavior }
    window.scroll(options)
    return


############################################################
export onScroll =  ->
    if window.scrollY < borders[2] then return setThreatActive(1)
    if window.scrollY < borders[3] then return setThreatActive(2)
    if window.scrollY < borders[4] then return setThreatActive(3)
    if window.scrollY < borders[5] then return setThreatActive(4)
    return setThreatActive(5)

