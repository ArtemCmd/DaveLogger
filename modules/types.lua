---@meta dave_logger.logger

---
---The logger library.
---
---@class dave_logger.loggerlib
local logger = {}

---
---Create a logger with the specified prefix.
---
---If the prefix is ​​null, the content-pack name is used.
---
---@param prefix? string
function logger.new(prefix) end

---
---Flush logs to a file.
---
function logger.save() end

---
---Log the message with the specified level.
---
---@param level string
---@param msg string
---@param ... any
function logger:log(level, msg, ...) end

---
---Log the message.
---
---Info level.
---
---@param msg string
---@param ... any
function logger:info(msg, ...) end

---
---Log the message.
---
---Debug level.
---
---@param msg string
---@param ... any
function logger:debug(msg, ...) end

---
---Log the message.
---
---Warning level.
---
---@param msg string
---@param ... any
function logger:warning(msg, ...) end

---
---Log the message.
---
---Error level.
---
---@param msg string
---@param ... any
function logger:error(msg, ...) end

return logger
