
function Discrete.Messages.SendMessageToPlayer(messageData, messageStyle, ply)
    net.Start("Discrete_SendMessageToClient")
        net.WriteString(messageStyle)
        net.WriteTable(messageData)
    net.Send(ply)
end
