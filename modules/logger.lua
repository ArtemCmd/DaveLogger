local logger = {}
logger.__index = logger

local loggers = {}
local launch_date = os.date("%y-%m-%d_%H-%M-%S")
local packs
local stream

setmetatable(logger, {
    __call = function(self, name)
        return self.new(name)
    end
})

local function get_name()
    local pack_id, _ = parse_path(debug.getinfo(3).source)

    if not packs then
        packs = pack.get_info(pack.get_installed())
    end

    return packs[pack_id].title
end

function logger:log(level, msg, ...)
    local date = os.date("%Y/%m/%d %H:%M:%S.000%z")
    local str = string.format("[%s] %s [%20s] %s", level:sub(1, 1), date, self.name, string.format(msg, ...))

    if stream then
        stream:write(utf8.tobytes(str .. "\n"))
    end

    print(str)
end

function logger:info(msg, ...)
	self:log("I", msg, ...)
end

function logger:debug(msg, ...)
	self:log("D", msg, ...)
end

function logger:warning(msg, ...)
	self:log("W", msg, ...)
end

function logger:error(msg, ...)
	self:log("E", msg, ...)
end

function logger:save()
    if stream then
        stream:flush()
    end
end

function logger.new(name)
    local object = loggers[name]

    if not object then
        object = {
            name = name or get_name()
        }
        setmetatable(object, logger)

        loggers[object.name] = object
    end

    return object
end

events.on("dave_logger:on_world_open", function()
    stream = file.open(pack.data_file("dave_logger", string.format("%s.log", launch_date)), "w")
    stream:set_binary_mode(true)
end)

events.on("dave_logger:on_world_close", function()
    if stream then
        stream:flush()
        stream:close()
        stream = nil
    end
end)

return logger
