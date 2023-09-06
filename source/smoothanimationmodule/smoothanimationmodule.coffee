############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("smoothanimationmodule")
#endregion

############################################################
allTasks = new Set()
allTasksArray = []


############################################################
export initialize = ->
    ## prod log "initialize"
    requestAnimationFrame(heartbeat)
    return

############################################################
heartbeat = ->
    ## prod log "heartbeat"
    task() for task in allTasksArray
    requestAnimationFrame(heartbeat)
    return

############################################################
export addAnimationTask = (task) ->
    ## prod log "addAnimationTask"
    allTasks.add(task)
    allTasksArray = [...allTasks]
    ## prod log "number of Tasks now: #{allTasksArray.length}"
    return

############################################################
export removeAnimationTask = (task) ->
    ## prod log "addAnimationTask"
    allTasks.delete(task)
    allTasksArray = [...allTasks]
    ## prod log "number of Tasks now: #{allTasksArray.length}"
    return
