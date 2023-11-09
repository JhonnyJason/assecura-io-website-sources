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
rightFrames = {}

############################################################
activeThreat = 1

############################################################
export initialize = ->
    log "initialize"
    offsetYet = header.offsetHeight

    for num in [1..6]
        navElements[num] = document.getElementById("nav-threat#{num}")
        contentElements[num] = document.getElementById("threat#{num}")
        rightFrames[num] = document.getElementById("right-threat#{num}")
        
        borders[num] =  offsetYet
        borders["nav-threat#{num}"] = borders[num]
        offsetYet += rightFrames[num].offsetHeight
        navElements[num].addEventListener("click", onNavClick)
        log "initialized threat: #{num}"
        log "offsetYet: #{offsetYet}"

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
    if window.innerHeight >= 1440 then top += 0.8 * window.innerHeight
    else top += 0.2 * window.innerHeight

    # if window.scrollY < borders[1] or window.scrollY > borders[5]
    #     behavior = "smooth"
    # else behavior = "instant"

    behavior = "smooth"
    options = { top, behavior }
    
    window.scroll(options)
    return


############################################################
export onScroll =  ->
    if window.scrollY < borders[2] then return setThreatActive(1)
    if window.scrollY < borders[3] then return setThreatActive(2)
    if window.scrollY < borders[4] then return setThreatActive(3)
    if window.scrollY < borders[5] then return setThreatActive(4)
    if window.scrollY < borders[6] then return setThreatActive(5)
    return setThreatActive(6)

