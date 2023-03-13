############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import * as anim from "./smoothanimationmodule.js"

############################################################
#region DOM-Cache
heroSection = document.getElementById("hero-section")
heroGrid = document.getElementById("hero-grid")
firewallsContainer = document.getElementById("cyberprotect-firewalls-container
")

smartbrokerSection = document.getElementById("smartbroker-section")
dangerSection = document.getElementById("danger-section")
dataprotectSection = document.getElementById("dataprotect-section")
electronicsprotectSection = document.getElementById("electronicsprotect-section")
outroSection = document.getElementById("outro-section")

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
    
    initializeHeroSection()
    initializeSmartbrokerSection()
    initializeDangerSection()
    initializeCyberprotectSection()
    initializeDataprotectSection()
    initializeElectronicsprotectSection()
    initializeOutroSection()
    return

############################################################
onIntersectTrigger = (entries) ->
    log "onIntersectTrigger"
    for entry in entries
        if entry.isIntersecting
            targetToEnterFunction.get(entry.target)()
        else targetToLeaveFunction.get(entry.target)()
    return

############################################################
#region section specific

############################################################
#region hero section

initializeHeroSection = ->
    log "initializeHeroSection"
    targetToEnterFunction.set(heroSection, heroSectionEnteredScreen)
    targetToLeaveFunction.set(heroSection, heroSectionLeftScreen)
    intersectionObserver.observe(heroSection)

    return

############################################################
heroSectionEnteredScreen = ->
    log "heroSectionEnteredScreen"
    anim.addAnimationTask(heroGridAnimation)
    return

heroSectionLeftScreen = ->
    log "heroSectionLeftScreen"
    anim.removeAnimationTask(heroGridAnimation)
    return

############################################################
heroGridAnimation = ->
    log "heroGridAnimation"
    if window.scrollY > window.innerHeight then return 

    upperBorder = 0.15
    lowerBorder = 0.7

    ratio = (1.0 * window.scrollY) / window.innerHeight
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

#endregion

############################################################
#region smartbroker section

smartbrokerStart = 0.0
smartbrokerHeight = 0.0
deltaMax = 50.0
smartbrokerCards = []
############################################################
initializeSmartbrokerSection = ->
    log "initializeSmartbrokerSection"
    targetToEnterFunction.set(smartbrokerSection, smartbrokerSectionEnteredScreen)
    targetToLeaveFunction.set(smartbrokerSection, smartbrokerSectionLeftScreen)
    intersectionObserver.observe(smartbrokerSection)

    smartbrokerCards = [...smartbrokerSection.getElementsByClassName("smartbroker-card")]
    return

############################################################
smartbrokerSectionEnteredScreen = ->
    log "smartbrokerSectionEnteredScreen"
    anim.addAnimationTask(smartbrokerAnimation)
    smartbrokerStart = smartbrokerSection.getBoundingClientRect().top + window.scrollY
    smartbrokerHeight = 1.0 * smartbrokerSection.offsetHeight
    return

smartbrokerSectionLeftScreen = ->
    log "smartbrokerSectionLeftScreen"
    anim.removeAnimationTask(smartbrokerAnimation)
    return

############################################################
smartbrokerAnimation = ->
    log "smartbrokerAnimation"
    progress = 1.0 * (window.scrollY - smartbrokerStart) / smartbrokerHeight
    if progress > 1.0 or progress < 0.0 then return
    if progress > 0.5 then return
    delta0 = Math.round(deltaMax * Math.sin(progress * 2 * Math.PI + 2.5 * Math.PI)) 
    delta2 = Math.round(deltaMax * Math.sin(progress * 2 * Math.PI + 1.5 * Math.PI)) 
    smartbrokerCards[0].style.transform = "translateY(#{delta0}px)"
    smartbrokerCards[2].style.transform = "translateY(#{delta2}px)"

    return

#endregion

############################################################
#region danger section
initializeDangerSection = ->
    log "initializeDangerSection"
    return

#endregion

############################################################
#region cyberprotect section
initializeCyberprotectSection = ->
    log "initializeCyberprotectSection"

    ## cyberprotect activation buttons
    buttons = [...firewallsContainer.getElementsByTagName("button")]
    for button in buttons
        heading = button.parentElement
        activatableContainer = heading.parentElement
        connectActivation(button, activatableContainer)

    return

############################################################
connectActivation = (button, container) ->
    switchFunction = -> container.classList.toggle("active")
    button.addEventListener("click", switchFunction)
    return

#endregion

############################################################
#region dataprotect section
initializeDataprotectSection = ->
    log "initializeDataprotectSection"
    return

#endregion

############################################################
#region smartbroker section
initializeElectronicsprotectSection = ->
    log "initializeElectronicsprotectSection"
    return

#endregion

############################################################
#region outro section
initializeOutroSection = ->
    log "initializeOutroSection"
    return

#endregion

#endregion