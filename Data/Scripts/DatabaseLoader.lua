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
    Loads a hierarchy into APIDatabase as data. Data will be represented in the database in the same form it is in the
    hierarchy. In order to maintain identical data on the client and the server this script should be run in both
    contexts.
--]]

-- Internal Properties
local DATA_OBJECTS = script:GetCustomProperty("Database"):WaitForObject()

if not DATA_OBJECTS then
    error(string.format("The \"Database\" Custom Property on %s must point to the parent of all of the data objects.", script.name))
end

-- Required APIs
---@type APIDatabase
local DATABASE = require(script:GetCustomProperty("APIDatabase"))

DATABASE.ParseCoreObject(DATA_OBJECTS, false, true)