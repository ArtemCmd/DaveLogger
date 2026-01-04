# DaveLogger
Logger for [VoxelCore](https://github.com/MihailRis/voxelcore).
# Usage
Quick example:
```lua
-- require("dave_logger:logger")(prefix)
-- require("dave_logger:logger")() -- Prefix is content pack title.
local logger = require("dave_logger:logger")("Lua")

-- logger:level(fmt, ...)
logger:info("Info!")
logger:warning("Warning%s", "!")
logger:error("Error!")
logger:debug("Debug!")

-- Save logs
logger:save()
```
