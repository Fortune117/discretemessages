
net.Receive("Discrete_SendMessageToClient", function(len, ply)
    local msgType = net.ReadString()
    local msgData = net.ReadTable()

    local msg = Discrete.Messages.CreateMessage(msgType)
    if msg then
        msg:PreInitialize()
        msg:Initialize(msgData)
        msg:PostInitialize()
    end
end)
