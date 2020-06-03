Discrete.Messages.Classes = Discrete.Messages.Classes or {}
Discrete.Messages.DefaultMessageClass = "message_base"

Discrete.Messages.ActiveMessages = {}

function Discrete.Messages.RegisterMessage(messageTable, messageName, messageBase)
    if (messageBase) then
        local baseTable = Discrete.Messages.Classes[messageBase]
        if (!baseTable) then
            ErrorNoHalt( "[Discrete] Attempted to register message "..messageName.." with invalid base: "..zoneBase.."\n" )
        else
            setmetatable(messageTable, baseTable)
        end
    end
    list.Add("Discrete_messageTypes", messageName)
    if CLIENT then
        language.Add(messageName, messageTable._displayName)
    end
    messageTable._class = messageName
    messageTable._baseClass = baseTable
    Discrete.Messages.Classes[messageName] = messageTable
end

function Discrete.Messages.CreateMessage(messageName)
    if (!Discrete.Messages.Classes[messageName]) then
        Error( "[Discrete] Attempted to create a message with invalid class: "..messageName.."\n" )
        return NULL
    end
    local message = table.Copy(Discrete.Messages.Classes[messageName])
    local metaTable = table.Copy(debug.getmetatable(message))
    if metaTable then
        metaTable.__index = metaTable
    end
    setmetatable(message, metaTable)
    table.insert(Discrete.Messages.ActiveMessages, message)
    return message
end
