local MESSAGE = {}
MESSAGE._messageText = "empty! someone set me!"
MESSAGE._primaryColor = Color(250, 250, 250)
MESSAGE._secondaryColor = Color(100, 100, 100)
MESSAGE._fadeInTime = 0.5
MESSAGE._duration = 1
MESSAGE._fadeOutTime = 0.5

DiscreteUI:CreateFont("Discrete.Message.WelcomeFont", 600)
DiscreteUI:CreateFont("Discrete.Message.WelcomeText", 200)
//Should be the fist function called for a new panel.

function MESSAGE:PostInitialize()
    chat.AddText( self:GetPrimaryColor(), self:GetText() )
end


function MESSAGE:Draw(drawPanel, w, h)
end

Discrete.Messages.RegisterMessage(MESSAGE, "message_chatprint", "message_base")
