############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import * as anim from "./smoothanimationmodule.js"

############################################################
#region DOM-Cache
heroGrid = document.getElementById("hero-grid")
#endregion

############################################################
intersectionObserver = null

############################################################
targetToLeaveFunction = new Map()
targetToEnterFunction = new Map()

############################################################
export initialize = ->
    log "initialize"
    intersectionOptions = 
        root: null # browser viewport
        rootMargin: "0%" # margin around root which does not count
        threshold: 0

    intersectionObserver = new IntersectionObserver(onIntersectTrigger, intersectionOptions)
    
    targetToEnterFunction.set(heroGrid, heroGridEnteredScreen)
    targetToLeaveFunction.set(heroGrid, heroGridLeftScreen)
    intersectionObserver.observe(heroGrid)

    return


############################################################
onIntersectTrigger = (entries) ->
    log "onIntersectTrigger"
    for entry in entries
        if entry.isIntersecting
            targetToEnterFunction.get(entry.target)()
        if entry.target == heroGrid 
            if entry.isIntersecting then heroGridEnteredScreen()
            else heroGridLeftScreen()

    return


############################################################
heroGridEnteredScreen = ->
    log "heroGridEnteredScreen"
    anim.addAnimationTask(heroGridAnimation)
    return

############################################################
heroGridLeftScreen = ->
    log "heroGridLeftScreen"
    anim.removeAnimationTask(heroGridAnimation)
    return

heroGridAnimation = ->
    offset = window.scrollY
    if offset > window.innerHeight then return

    upperBorder = 0.15
    lowerBorder = 0.7

    ratio = (1.0 * offset) / window.innerHeight
    if ratio > lowerBorder 
        heroGrid.style.opacity = "0"
        return
    if ratio < upperBorder 
        heroGrid.style.opacity = "1"
        return

    usedTrail = lowerBorder - upperBorder
    ratio = ratio - upperBorder
    ratio = 1.0 - ratio / usedTrail

    heroGrid.style.opacity = ratio.toFixed(2)
    return