--[[
Copyright 2021 Manticore Games, Inc. 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

--[[
    Allows us to limit where players are allowed to place objects
--]]


---@class APIPlacementAreas
local API = {}

-- Private Variables
local placementAreas = {}

function API.RegisterPlacementArea(id, functionTable)
    placementAreas[id] = functionTable
end

function API.UnregisterPlacementArea(id)
    placementAreas[id] = nil
end

function API.FindPlacementAreaByAncestors(coreObject)
    while Object.IsValid(coreObject) do
        local id = coreObject.id
        if placementAreas[id] then
            return id
        end
        coreObject = coreObject.parent
    end
end

---Gets information about the placement area
---@param id string
---@return PlacementAreaState
function API.GetPlacementAreaState(id)
    local placementArea = placementAreas[id]
    return placementArea.GetState()
end

return API