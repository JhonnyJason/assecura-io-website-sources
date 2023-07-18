############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("headermodule")
#endregion

############################################################
headerTagElement = document.getElementsByTagName("header")[0]

############################################################
export setSmaller = ->
    headerTagElement.classList.remove("gone")
    headerTagElement.classList.add("smaller")
    return

export setGone = ->
    headerTagElement.classList.remove("smaller")
    headerTagElement.classList.add("gone")
    return

export setNormal = ->
    # headerTagElement.removeAttribute("class")
    headerTagElement.classList.remove("smaller")
    headerTagElement.classList.remove("gone")
    return

export invertColors = ->
    headerTagElement.classList.add("inverted")
    return

export setNormalColors = ->
    headerTagElement.classList.remove("inverted")
    return
