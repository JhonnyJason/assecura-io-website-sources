############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion



############################################################
#region DOM-Cache
introSection = document.getElementById("intro-section")
introTextLeft = document.getElementById("intro-text-left")
introTextRight = document.getElementById("intro-text-right")

#endregion

############################################################
intersectionObserver = null

############################################################
export initialize = ->
    log "initialize"
    intersectionOptions = 
        root: null # browser viewport
        rootMargin: "0%" # margin around root which does not count
        threshold: 0

    intersectionObserver = new IntersectionObserver(onIntersectTrigger, intersectionOptions)
    
    intersectionObserver.observe(introTextLeft)    
    intersectionObserver.observe(introTextRight)
    return


############################################################
onIntersectTrigger = (entries) ->
    log "onIntersectTrigger"
    for entry in entries
        if entry.target == introTextLeft and entry.isIntersecting
            introTextLeft.classList.remove("hidden")
        if entry.target == introTextRight and entry.isIntersecting
            introTextRight.classList.remove("hidden")
            intersectionObserver.unobserve(introTextLeft)    
            intersectionObserver.unobserve(introTextRight)
    return

