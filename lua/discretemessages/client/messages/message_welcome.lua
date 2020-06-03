local MESSAGE = {}
MESSAGE._messageText = "empty! someone set me!"
MESSAGE._primaryColor = Color(250, 250, 250)
MESSAGE._secondaryColor = Color(100, 100, 100)
MESSAGE._fadeInTime = 0.5
MESSAGE._duration = 1
MESSAGE._fadeOutTime = 0.5

DiscreteUI:CreateFont("Discrete.Message.WelcomeFont", 500)
DiscreteUI:CreateFont("Discrete.Message.WelcomeText", 170)
//Should be the fist function called for a new panel.

function MESSAGE:Initialize(data)
    local w, h = ScrW(), ScrH()

    table.Merge(self, data)

    self:SetSize(w, h)
    self:Center()
    self:Begin()
end


function MESSAGE:Draw(drawPanel, w, h)
    draw.SimpleText("Welcome To", "Discrete.Message.WelcomeFont", w/2, h/4, self:GetPrimaryColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(self:GetText(), "Discrete.Message.WelcomeText", w/2, h/2.5, self:GetSecondaryColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

Discrete.Messages.RegisterMessage(MESSAGE, "message_welcome", "message_base") 
