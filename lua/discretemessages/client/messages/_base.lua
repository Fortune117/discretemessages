local MESSAGE = {}
MESSAGE._messageText = "empty! someone set me!"
MESSAGE._primaryColor = Color(250, 250, 250)
MESSAGE._secondaryColor = Color(100, 100, 100)
MESSAGE._fadeInTime = 0.5
MESSAGE._duration = 1
MESSAGE._fadeOutTime = 0.5

DiscreteUI:CreateFont("Discrete.Message.DefaultTitle", 140)
//Should be the fist function called for a new panel.
function MESSAGE:PreInitialize()
    self._drawPanel = vgui.Create("DPanel")
    function self._drawPanel.Paint(pnl, w, h)
    end

    function self._drawPanel.Think(pnl)
    end
end

function MESSAGE:GetDrawPanel()
    return self._drawPanel
end

function MESSAGE:Initialize(data)
    local w, h = ScrW(), ScrH()

    table.Merge(self, data)

    self:SetSize(w, h)
    self:Center()
    self:Begin()
end

//For override
function MESSAGE:PostInitialize()
end

function MESSAGE:Begin()
    local startTime = CurTime()
    local fadeInTime = self:GetFadeInTime()
    local duration = self:GetDuration()
    local fadeOutTime = self:GetFadeOutTime()
    local endTime = startTime + fadeInTime + duration + fadeOutTime
    function self._drawPanel.Paint(pnl, w, h)
        local alphaFrac
        if CurTime() < startTime + fadeInTime then
            alphaFrac = (CurTime() - startTime)/fadeInTime
        elseif CurTime() > startTime + duration + fadeInTime then
            alphaFrac = 1 - (CurTime() - startTime - fadeInTime - duration)/fadeOutTime
        else
            alphaFrac = 1
        end
        surface.SetAlphaMultiplier(alphaFrac)
            self:Draw(pnl, w, h)
        surface.SetAlphaMultiplier(1)
    end

    function self._drawPanel.Think(pnl)
        self:Think(pnl)
        if CurTime() > endTime then
            self:Remove()
        end
    end
end

function MESSAGE:SetSize(w, h)
    local pnl = self:GetDrawPanel()
    pnl:SetSize(w, h)
end

function MESSAGE:SetPos(x, y)
    local pnl = self:GetDrawPanel()
    pnl:SetPos(x, y)
end

function MESSAGE:Center()
    local pnl = self:GetDrawPanel()
    pnl:Center()
end

function MESSAGE:Think(drawPanel)
end

function MESSAGE:SetText(text)
    self._messageText = text
end

function MESSAGE:GetText()
    return self._messageText
end

function MESSAGE:SetPrimaryColor(clr)
    self._primaryColor = clr
end

function MESSAGE:GetPrimaryColor()
    return self._primaryColor
end

function MESSAGE:SetScondaryColor(clr)
    self._secondaryColor = clr
end

function MESSAGE:GetSecondaryColor()
    return self._secondaryColor
end

function MESSAGE:GetFadeInTime()
    return self._fadeInTime
end

function MESSAGE:SetFadeInTime(n)
    self._fadeInTime = n
end

function MESSAGE:GetFadeOutTime()
    return self._fadeOutTime
end

function MESSAGE:SetFadeOutTime(n)
    self._fadeOutTime = n
end

function MESSAGE:GetDuration()
    return self._duration
end

function MESSAGE:SetDuration(n)
    self._duration = n
end

function MESSAGE:Draw(drawPanel, w, h)
    draw.SimpleText(self:GetText(), "Discrete.Message.DefaultTitle", w/2, h/2, self:GetPrimaryColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function MESSAGE:Remove()
    self:OnRemove()
    table.RemoveByValue(Discrete.Messages.ActiveMessages, self)
end

function MESSAGE:OnRemove()
    local pnl = self:GetDrawPanel()
    if IsValid(pnl) then
        pnl:Remove()
    end
end

Discrete.Messages.RegisterMessage(MESSAGE, "message_base")
