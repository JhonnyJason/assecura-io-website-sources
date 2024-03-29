############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import * as anim from "./smoothanimationmodule.js"

############################################################
#region DOM-Cache
navigationBar = document.getElementById("navigation-bar")

heroSection = document.getElementById("hero-section")
heroGrid = document.getElementById("hero-grid")
firewallsContainer = document.getElementById("cyberprotect-firewalls-container
")
contactusCalltoactionFrame = document.getElementById("contactus-calltoaction-frame")
electronicsprotectImagesBlock = document.getElementById("electronicsprotect-images-block")
dataprotectDecoration = document.getElementById("dataprotect-decoration")
cyberprotectImagesBlock = document.getElementById("cyberprotect-images-block")
dangerImagesBlock = document.getElementById("danger-images-block")

smartbrokerSection = document.getElementById("smartbroker-section")
dangerSection = document.getElementById("danger-section")
cyberprotectSection = document.getElementById("cyberprotect-section")
dataprotectSection = document.getElementById("dataprotect-section")
electronicsprotectSection = document.getElementById("electronicsprotect-section")
contactusSection = document.getElementById("contactus-section")

firewall1Frame = document.getElementById("firewall1-frame")
firewall1ImagesBlock = document.getElementById("firewall1-images-block")
firewall2Frame = document.getElementById("firewall2-frame")
firewall2Decoration = document.getElementById("firewall2-decoration")
firewall3Frame = document.getElementById("firewall3-frame")
firewall3ImagesBlock = document.getElementById("firewall3-images-block")


#endregion

############################################################
intersectionObserver = null

############################################################
targetToLeaveFunction = new Map()
targetToEnterFunction = new Map()

############################################################
navbarClasses = new Set()

############################################################
export initialize = ->
    ## prod log "initialize"
    intersectionOptions = 
        root: null # browser viewport
        rootMargin: "0%" # margin around root which does not count
        threshold: 0

    intersectionObserver = new IntersectionObserver(onIntersectTrigger, intersectionOptions)
    
    if heroSection? then initializeHeroSection()
    if smartBrokerSection?  then initializeSmartbrokerSection()
    if dangerSection? then initializeDangerSection()
    if cyberprotectSection? then initializeCyberprotectSection()
    if dataprotectSection? then initializeDataprotectSection()
    if electronicsprotectSection? then initializeElectronicsprotectSection()
    if contactusSection? then initializeContactusSection()

    if firewall1Frame? then initializeFirewall1Frame()
    if firewall2Frame? then initializeFirewall2Frame()
    if firewall3Frame? then initializeFirewall3Frame()
    
    return

############################################################
onIntersectTrigger = (entries) ->
    ## prod log "onIntersectTrigger"
    for entry in entries
        if entry.isIntersecting
            targetToEnterFunction.get(entry.target)()
        else targetToLeaveFunction.get(entry.target)()
    return

############################################################
applyNavbarClasses = ->
    ## prod log "applyNavbarClasses"
    log navbarClasses.size
    if navbarClasses.size == 0
        navigationBar.className = ""
    if navbarClasses.size == 1
        values = [...navbarClasses]
        navigationBar.className = values[0]
    return

############################################################
#region section specific

############################################################
#region hero section

initializeHeroSection = ->
    ## prod log "initializeHeroSection"
    targetToEnterFunction.set(heroSection, heroSectionEnteredScreen)
    targetToLeaveFunction.set(heroSection, heroSectionLeftScreen)
    intersectionObserver.observe(heroSection)

    return

############################################################
heroSectionEnteredScreen = ->
    ## prod log "heroSectionEnteredScreen"
    anim.addAnimationTask(heroGridAnimation)
    return

heroSectionLeftScreen = ->
    ## prod log "heroSectionLeftScreen"
    anim.removeAnimationTask(heroGridAnimation)
    return

############################################################
heroGridAnimation = ->
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
smartbrokerCards = []
############################################################
initializeSmartbrokerSection = ->
    ## prod log "initializeSmartbrokerSection"
    # targetToEnterFunction.set(smartbrokerSection, smartbrokerSectionEnteredScreen)
    # targetToLeaveFunction.set(smartbrokerSection, smartbrokerSectionLeftScreen)
    # intersectionObserver.observe(smartbrokerSection)

    smartbrokerCards = smartbrokerSection.getElementsByClassName("smartbroker-card")
    return

############################################################
smartbrokerSectionEnteredScreen = ->
    ## prod log "smartbrokerSectionEnteredScreen"
    anim.addAnimationTask(smartbrokerAnimation)
    smartbrokerStart = smartbrokerSection.getBoundingClientRect().top + window.scrollY
    smartbrokerHeight = 1.0 * smartbrokerSection.offsetHeight
    return

smartbrokerSectionLeftScreen = ->
    ## prod log "smartbrokerSectionLeftScreen"
    anim.removeAnimationTask(smartbrokerAnimation)
    return

############################################################
smartbrokerAnimation = ->
    progress = 1.0 * (window.scrollY - smartbrokerStart) / smartbrokerHeight
    if progress > 1.0 or progress < 0.0 then return
    if progress > 0.5 then return
    max = 50.0

    delta0 = Math.round(max * Math.sin(progress * 2 * Math.PI + 2.5 * Math.PI)) 
    delta2 = Math.round(max * Math.sin(progress * 2 * Math.PI + 1.5 * Math.PI)) 
    smartbrokerCards[0].style.transform = "translateY(#{delta0}px)"
    smartbrokerCards[2].style.transform = "translateY(#{delta2}px)"

    return

#endregion

############################################################
#region danger section

dangerStart = 0.0
dangerHeight = 0.0
dangerElements = []

############################################################
initializeDangerSection = ->
    ## prod log "initializeDangerSection"
    targetToEnterFunction.set(dangerSection, dangerSectionEnteredScreen)
    targetToLeaveFunction.set(dangerSection, dangerSectionLeftScreen)
    intersectionObserver.observe(dangerSection)
    
    dangerElements = dangerImagesBlock.getElementsByTagName("img")
    return


############################################################
dangerSectionEnteredScreen = ->
    ## prod log "dangerSectionEnteredScreen"
    dangerStart = dangerSection.getBoundingClientRect().top + window.scrollY
    dangerHeight = 1.0 * dangerSection.offsetHeight
    anim.addAnimationTask(dangerAnimation)
    return

dangerSectionLeftScreen = ->
    ## prod log "dangerSectionLeftScreen"
    anim.addAnimationTask(dangerAnimation)
    return


############################################################
dangerAnimation = ->
    progress = 1.0 * (window.scrollY - dangerStart) / dangerHeight
    
    progress = progress - 0.3
    max = 30.0

    mult0 = -4.0
    mult1 = -2.0
    mult2 = 1.0

    # experiment 1
    # mult0 = -1.6
    # mult1 = 3.2
    # mult2 = 1.6

    delta0 = mult0 * max * progress
    delta1 = mult1 * max * progress
    delta2 = mult2 * max * progress

    dangerElements[0].style.transform = "translateY(#{delta0}px)"
    dangerElements[1].style.transform = "translateY(#{delta1}px)"
    dangerElements[2].style.transform = "translateY(#{delta2}px)"

    # experiment 1
    # dangerElements[0].style.transform = "translateX(#{delta0}px)"
    # dangerElements[1].style.transform = "translateY(#{delta1}px)"
    # dangerElements[2].style.transform = "translateX(#{delta2}px)"

    return

#endregion

############################################################
#region cyberprotect section

cyberprotectStart = 0.0
cyberprotectHeight = 0.0
cyberprotectElements = []

############################################################
initializeCyberprotectSection = ->
    ## prod log "initializeCyberprotectSection"
    targetToEnterFunction.set(cyberprotectSection, cyberprotectSectionEnteredScreen)
    targetToLeaveFunction.set(cyberprotectSection, cyberprotectSectionLeftScreen)
    intersectionObserver.observe(cyberprotectSection)

    ## cyberprotect activation buttons
    buttons = firewallsContainer.getElementsByTagName("button")
    # buttons = [...firewallsContainer.getElementsByTagName("button")]
    for button in buttons
        heading = button.parentElement
        activatableContainer = heading.parentElement
        connectActivation(button, activatableContainer)

    cyberprotectElements = cyberprotectImagesBlock.getElementsByTagName("img")
    return

############################################################
connectActivation = (button, container) ->
    switchFunction = -> container.classList.toggle("active")
    button.addEventListener("click", switchFunction)
    return

############################################################
cyberprotectSectionEnteredScreen = ->
    ## prod log "cyberprotectSectionEnteredScreen"
    cyberprotectStart = cyberprotectSection.getBoundingClientRect().top + window.scrollY
    cyberprotectHeight = 1.0 * cyberprotectSection.offsetHeight
    
    navbarClasses.add("on-cyberprotect")
    applyNavbarClasses()
    
    anim.addAnimationTask(cyberprotectAnimation)
    return

cyberprotectSectionLeftScreen = ->
    ## prod log "cyberprotectSectionLeftScreen"
    navbarClasses.delete("on-cyberprotect")
    applyNavbarClasses()

    anim.addAnimationTask(cyberprotectAnimation)
    return


############################################################
cyberprotectAnimation = ->
    progress = 1.0 * (window.scrollY - cyberprotectStart) / cyberprotectHeight
    
    progress = progress - 0.3
    max = 40.0

    mult0 = 1.0
    mult1 = 3.0

    delta0 = mult0 * max * progress
    delta1 = mult1 * max * progress

    cyberprotectElements[0].style.transform = "translateY(#{delta0}px)"
    cyberprotectElements[1].style.transform = "translateY(#{delta1}px)"
    
#endregion

############################################################
#region dataprotect section

dataprotectStart = 0.0
dataprotectHeight = 0.0
dataprotectElements = []

############################################################
initializeDataprotectSection = ->
    ## prod log "initializeDataprotectSection"
    targetToEnterFunction.set(dataprotectSection, dataprotectSectionEnteredScreen)
    targetToLeaveFunction.set(dataprotectSection, dataprotectSectionLeftScreen)
    intersectionObserver.observe(dataprotectSection)

    dataprotectElements = [...dataprotectDecoration.children]
    return

############################################################
dataprotectSectionEnteredScreen = ->
    ## prod log "dataprotectSectionEnteredScreen"
    dataprotectStart = dataprotectSection.getBoundingClientRect().top + window.scrollY
    dataprotectHeight = 1.0 * dataprotectSection.offsetHeight

    navbarClasses.add("on-dataprotect")
    applyNavbarClasses()

    anim.addAnimationTask(dataprotectAnimation)
    return

dataprotectSectionLeftScreen = ->
    ## prod log "dataprotectSectionLeftScreen"
    navbarClasses.delete("on-dataprotect")
    applyNavbarClasses()

    anim.removeAnimationTask(dataprotectAnimation)
    return

############################################################
dataprotectAnimation = ->
    progress = 1.0 * (window.scrollY - dataprotectStart) / dataprotectHeight
    
    progress = progress - 0.3
    max = 40.0

    mult0 = 1.0
    mult1 = 2.0
    mult2 = 3.0

    delta0 = mult0 * max * progress
    delta1 = mult1 * max * progress
    delta2 = mult2 * max * progress

    dataprotectElements[0].style.transform = "translateY(#{delta0}px)"
    dataprotectElements[1].style.transform = "translateY(#{delta1}px)"
    dataprotectElements[2].style.transform = "translateY(#{delta2}px)"

    return
    
#endregion

############################################################
#region electonicsprotect section

electronicsprotectStart = 0.0
electronicsprotectHeight = 0.0
electronicsprotectImages = []

############################################################
initializeElectronicsprotectSection = ->
    ## prod log "initializeElectronicsprotectSection"
    targetToEnterFunction.set(electronicsprotectSection, electronicsprotectSectionEnteredScreen)
    targetToLeaveFunction.set(electronicsprotectSection, electronicsprotectSectionLeftScreen)
    intersectionObserver.observe(electronicsprotectSection)

    electronicsprotectImages = electronicsprotectImagesBlock.getElementsByTagName("img")
    return

############################################################
electronicsprotectSectionEnteredScreen = ->
    ## prod log "electronicsprotectSectionEnteredScreen"
    electronicsprotectStart = electronicsprotectSection.getBoundingClientRect().top + window.scrollY
    electronicsprotectHeight = 1.0 * electronicsprotectSection.offsetHeight

    navbarClasses.add("on-electronicsprotect")
    applyNavbarClasses()

    anim.addAnimationTask(electronicsprotectAnimation)
    return

electronicsprotectSectionLeftScreen = ->
    ## prod log "electronicsprotectSectionLeftScreen"
    navbarClasses.delete("on-electronicsprotect")
    applyNavbarClasses()

    anim.removeAnimationTask(electronicsprotectAnimation)
    return

############################################################
electronicsprotectAnimation = ->
    progress = 1.0 * (window.scrollY - electronicsprotectStart) / electronicsprotectHeight

    progress = progress - 0.3
    max = 50.0

    # progress = (progress - 0.25) * 2.0

    deltaP = Math.round(max * Math.sin(progress * Math.PI)) 
    deltaN = -1 * deltaP

    electronicsprotectImages[0].style.transform = "translateY(#{deltaP}px)"
    electronicsprotectImages[1].style.transform = "translateY(#{deltaN}px)"
    electronicsprotectImages[2].style.transform = "translateY(#{deltaP}px)"
    electronicsprotectImages[3].style.transform = "translateY(#{deltaN}px)"

    return

#endregion


############################################################
#region firewall1 section

firewall1Start = 0.0
firewall1Height = 0.0
firewall1Elements = []

############################################################
initializeFirewall1Frame = ->
    ## prod log "initializeFirewall1Frame"
    targetToEnterFunction.set(firewall1Frame, firewall1FrameEnteredScreen)
    targetToLeaveFunction.set(firewall1Frame, firewall1FrameLeftScreen)
    intersectionObserver.observe(firewall1Frame)

    firewall1Elements = firewall1ImagesBlock.getElementsByTagName("img")
    return

############################################################
firewall1FrameEnteredScreen = ->
    ## prod log "firewall1FrameEnteredScreen"
    firewall1Start = firewall1Frame.getBoundingClientRect().top + window.scrollY
    firewall1Height = 1.0 * firewall1Frame.offsetHeight
        
    anim.addAnimationTask(firewall1Animation)
    return

firewall1FrameLeftScreen = ->
    ## prod log "firewall1FrameLeftScreen"
    anim.addAnimationTask(firewall1Animation)
    return


############################################################
firewall1Animation = ->
    progress = 1.0 * (window.scrollY - firewall1Start) / firewall1Height
    
    progress = progress - 0.3
    max = 40.0

    mult0 = 1.0
    mult1 = 3.0

    delta0 = mult0 * max * progress
    delta1 = mult1 * max * progress

    firewall1Elements[0].style.transform = "translateY(#{delta0}px)"
    firewall1Elements[1].style.transform = "translateY(#{delta1}px)"
    return

#endregion

############################################################
#region firewall2 section

firewall2Start = 0.0
firewall2Height = 0.0
firewall2Elements = []

############################################################
initializeFirewall2Frame = ->
    ## prod log "initializeFirewall2Frame"
    targetToEnterFunction.set(firewall2Frame, firewall2EnteredScreen)
    targetToLeaveFunction.set(firewall2Frame, firewall2SectionLeftScreen)
    intersectionObserver.observe(firewall2Frame)

    firewall2Elements = [...firewall2Decoration.children]
    return

############################################################
firewall2EnteredScreen = ->
    ## prod log "firewall2EnteredScreen"
    firewall2Start = firewall2Frame.getBoundingClientRect().top + window.scrollY
    firewall2Height = 1.0 * firewall2Frame.offsetHeight

    anim.addAnimationTask(firewall2Animation)
    return

firewall2SectionLeftScreen = ->
    ## prod log "firewall2SectionLeftScreen"
    anim.removeAnimationTask(firewall2Animation)
    return

############################################################
firewall2Animation = ->
    progress = 1.0 * (window.scrollY - firewall2Start) / firewall2Height
    
    progress = progress - 0.3
    max = 40.0

    mult0 = 1.0
    mult1 = 2.0
    mult2 = 3.0
    mult3 = 4.0

    delta0 = mult0 * max * progress
    delta1 = mult1 * max * progress
    delta2 = mult2 * max * progress
    delta3 = mult3 * max * progress

    firewall2Elements[0].style.transform = "translateY(#{delta0}px)"
    firewall2Elements[1].style.transform = "translateY(#{delta1}px)"
    firewall2Elements[2].style.transform = "translateY(#{delta2}px)"
    firewall2Elements[3].style.transform = "translateY(#{delta3}px)"

    return
    
#endregion

############################################################
#region firewall3 section

firewall3Start = 0.0
firewall3Height = 0.0
firewall3Images = []

############################################################
initializeFirewall3Frame = ->
    ## prod log "initializeFirewall3Frame"
    targetToEnterFunction.set(firewall3Frame, firewall3EnteredScreen)
    targetToLeaveFunction.set(firewall3Frame, firewall3SectionLeftScreen)
    intersectionObserver.observe(firewall3Frame)

    firewall3Images = firewall3ImagesBlock.getElementsByTagName("img")
    return

############################################################
firewall3EnteredScreen = ->
    ## prod log "firewall3EnteredScreen"
    firewall3Start = firewall3Frame.getBoundingClientRect().top + window.scrollY
    firewall3Height = 1.0 * firewall3Frame.offsetHeight

    anim.addAnimationTask(firewall3Animation)
    return

firewall3SectionLeftScreen = ->
    ## prod log "firewall3SectionLeftScreen"
    anim.removeAnimationTask(firewall3Animation)
    return

############################################################
firewall3Animation = ->
    progress = 1.0 * (window.scrollY - firewall3Start) / firewall3Height

    progress = progress - 0.3
    max = 50.0

    # progress = (progress - 0.25) * 2.0

    deltaP = Math.round(max * Math.sin(progress * Math.PI)) 
    deltaN = -1 * deltaP

    firewall3Images[0].style.transform = "translateY(#{deltaP}px)"
    firewall3Images[1].style.transform = "translateY(#{deltaN}px)"
    firewall3Images[2].style.transform = "translateY(#{deltaP}px)"
    firewall3Images[3].style.transform = "translateY(#{deltaN}px)"

    return

#endregion



############################################################
#region outro section

contactusStart = 0.0
contactusHeight = 0.0

############################################################
initializeContactusSection = ->
    ## prod log "initializeContactusSection"
    targetToEnterFunction.set(contactusSection, contactusSectionEnteredScreen)
    targetToLeaveFunction.set(contactusSection, contactusSectionLeftScreen)
    intersectionObserver.observe(contactusSection)

    return


############################################################
contactusSectionEnteredScreen = ->
    ## prod log "contactusSectionEnteredScreen"
    contactusStart = contactusSection.getBoundingClientRect().top + window.scrollY
    contactusHeight = 1.0 * contactusSection.offsetHeight
    anim.addAnimationTask(contactusAnimation)
    return

contactusSectionLeftScreen = ->
    ## prod log "contactusSectionLeftScreen"
    anim.removeAnimationTask(contactusAnimation)
    contactusCalltoactionFrame.style.removeProperty("transform")
    return

############################################################
contactusAnimation = ->
    progress = 1.0 * (window.scrollY - contactusStart) / contactusHeight
    if progress > 1.0 or progress < 0.0 
        contactusCalltoactionFrame.style.removeProperty("transform")
        return

    if progress > 0.0 and progress < 0.8
        contactusCalltoactionFrame.style.transform = "translateX(0)"
    else 
        contactusCalltoactionFrame.style.removeProperty("transform")
    return

#endregion

#endregion