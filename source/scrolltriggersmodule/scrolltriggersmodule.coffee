############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scrolltriggersmodule")
#endregion

############################################################
import * as headerModule from "./headermodule.js"
import * as contentModule from "./contentmodule.js"

############################################################
smallHeaderBorder = 50

############################################################
scrollingDown = false
pivotOffset = 0
hysteresisDistance = 30
negativeHysteresisDistance = -50

alwaysInvert = false

############################################################
export initialize = ->
    log "initialize"
    if cyberProtectFlag? then alwaysInvert = true
    if deepDiveFlag? then alwaysInvert = true
    
    document.addEventListener("scroll", scrolled)
    scrolled()
    return

#### Scroll Triggers
# if scroll > 50 then make menu smaller
# if scroll > introsection and < footer then invert colors (orange background...)  
# if scroll has down-momentum then hide header
# if scroll has up-momentum then show header
# if scroll > window.innerHeight then switch off heroGrid animation

############################################################
scrolled = (evnt) ->
    if window.scrollY < smallHeaderBorder then return headerModule.setNormal()
    
    invertedBeginBorder = window.innerHeight - header.offsetHeight * 0.5
    invertedEndBorder = document.body.offsetHeight - footer.offsetHeight - 80 - 0.5 * header.offsetHeight
    
    # if window.scrollY > invertedBeginBorder and window.scrollY < invertedEndBorder  then headerModule.invertColors()
    # else headerModule.setNormalColors()
    
    if window.scrollY > invertedBeginBorder or alwaysInvert then headerModule.invertColors()
    else headerModule.setNormalColors()

    if window.scrollY > invertedEndBorder
        pivotOffset = invertedEndBorder
        scrollingDown = true
        headerModule.setGone()
        return

    figureDirection()
    if scrollingDown then headerModule.setGone()
    else headerModule.setSmaller()

    return

############################################################
figureDirection = ->
    distance = window.scrollY - pivotOffset
    
    if distance > hysteresisDistance and !scrollingDown
        scrollingDown = true
    
    if distance > 0 and scrollingDown
        pivotOffset = window.scrollY
    
    if distance < negativeHysteresisDistance and scrollingDown
        scrollingDown = false
    
    if distance < 0 and !scrollingDown
        pivotOffset = window.scrollY
    return    
