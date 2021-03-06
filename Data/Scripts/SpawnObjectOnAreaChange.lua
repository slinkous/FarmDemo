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
    This component will spawn an object when a Player moves from one Area to another.
--]]

-- Required APIs
---@type APIReactiveComponent
local REACTIVE_COMPONENT = require(script:GetCustomProperty("APIReactiveComponent"))

-- User Exposed Properties
local AREA = script:GetCustomProperty("Area"):WaitForObject()
local AREA_GROUP_KEY = script:GetCustomProperty("AreaGroupKey")
local LOCAL_PLAYER_ONLY = script:GetCustomProperty("LocalPlayerOnly")
local ASSET = script:GetCustomProperty("Asset")
local LOCAL_SPACE = script:GetCustomProperty("LocalSpace")
local OFFSET = script:GetCustomProperty("Offset")
local ROTATION = script:GetCustomProperty("Rotation")
local SCALE = script:GetCustomProperty("Scale")
local DELAY_SECONDS = script:GetCustomProperty("DelaySeconds")
local DESTROY_WHEN_INACTIVE = script:GetCustomProperty("DestroyWhenInactive")
local CHANGE_ON_ENTER_AREA = script:GetCustomProperty("ChangeOnEnterArea")
local CHANGE_ON_EXIT_AREA = script:GetCustomProperty("ChangeOnExitArea")

local component = REACTIVE_COMPONENT.NewAreaComponent(script, script, AREA, AREA_GROUP_KEY, CHANGE_ON_ENTER_AREA, CHANGE_ON_EXIT_AREA, LOCAL_PLAYER_ONLY, REACTIVE_COMPONENT.BehaviorType.SpawnObject, {
    Asset = ASSET,
    LocalSpace = LOCAL_SPACE,
    Offset = OFFSET,
    Rotation = ROTATION,
    Scale = SCALE,
    DelaySeconds = DELAY_SECONDS,
    DestroyWhenInactive = DESTROY_WHEN_INACTIVE
}, false)