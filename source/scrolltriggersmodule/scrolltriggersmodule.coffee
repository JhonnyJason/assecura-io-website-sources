############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("scrolltriggersmodule")
#endregion

############################################################
import * as headerModule from "./headermodule.js"

############################################################
smallHeaderBorder = 50

############################################################
scrollingDown = false
pivotOffset = 0
hysteresisDistance = 30
negativeHysteresisDistance = -50

############################################################
export initialize = ->
    log "initialize"
    document.addEventListener("scroll", scrolled)
    return

#### Scroll Triggers
# if scroll > 50 then make menu smaller
# if scroll > introsection and < footer then invert colors (orange background...)  
# if scroll has down-momentum then hide header
# if scroll has up-momentum then show header


scrolled = (evnt) ->
    offset = window.scrollY
    if offset < smallHeaderBorder then return headerModule.setNormal()
    
    invertedBeginBorder = window.innerHeight - header.offsetHeight * 0.5
    invertedEndBorder = document.body.offsetHeight - footer.offsetHeight - 80 - 0.5 * header.offsetHeight
    
    # if offset > invertedBeginBorder and offset < invertedEndBorder  then headerModule.invertColors()
    # else headerModule.setNormalColors()
    
    if offset > invertedBeginBorder then headerModule.invertColors()
    else headerModule.setNormalColors()

    if offset > invertedEndBorder
        pivotOffset = invertedEndBorder
        scrollingDown = true
        headerModule.setGone()
        return

    figureDirection(offset)
    if scrollingDown then headerModule.setGone()
    else headerModule.setSmaller()

    return

figureDirection = (offset) ->
    distance = offset - pivotOffset
    
    if distance > hysteresisDistance and !scrollingDown
        scrollingDown = true
    
    if distance > 0 and scrollingDown
        pivotOffset = offset
    
    if distance < negativeHysteresisDistance and scrollingDown
        scrollingDown = false
    
    if distance < 0 and !scrollingDown
        pivotOffset = offset
    return    


