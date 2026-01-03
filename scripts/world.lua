require("dave_logger:logger")

function on_world_open()
    events.emit("dave_logger:on_world_open")
end

function on_world_save()
    events.emit("dave_logger:on_world_close")
end
