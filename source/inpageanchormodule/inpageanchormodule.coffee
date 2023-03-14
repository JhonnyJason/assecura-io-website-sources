############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("inpageanchormodule")
#endregion

############################################################
import *  as v from "./vanillautilmodule.js"

############################################################
export initialize = ->
    log "initialize"

    allLinks = document.getElementsByTagName("a")
    for link,i in allLinks
        ref = link.getAttribute("href")
        anchorname = getAnchorName(ref)
        if anchorname then addScrollEffect(link, anchorname)

    return

############################################################
#region internal functions
getAnchorName = (ref) ->
    # log ref
    # olog { ref }
    return unless ref?
    if ref[0] == '#' then return ref.slice(1)
    return

addScrollEffect = (link, anchorname) ->
    # log "addScrollEffect"
    # olog { link,anchorname }
    el = document.getElementById(anchorname)
    return unless el?
    targetOffset = el.getBoundingClientRect().top + window.scrollY + 120
    scrollFunction = -> v.scrollTo(targetOffset)
    link.addEventListener("click", scrollFunction)
    return



#endregion