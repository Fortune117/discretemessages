Discrete = Discrete or {}

Discrete.Messages = Discrete.Messages or {}

local AutorunTable = {}
AutorunTable[1] = {
	Location = "discretemessages/",
	Type = "Shared",
	Enabled = true
}
AutorunTable[2] = {
	Location = "discretemessages/server/",
	Type = "Server",
	Enabled = true
}
AutorunTable[3] = {
	Location = "discretemessages/client/",
	Type = "Client",
	Enabled = true
}
AutorunTable[4] = {
	Location = "discretemessages/client/vgui/",
	Type = "Client",
	Enabled = true
}
AutorunTable[5] = {
	Location = "discretemessages/client/messages/",
	Type = "Client",
	Enabled = true
}

local function Load()
	for key, val in pairs( AutorunTable ) do
		if( val.Type == "Shared" and val.Enabled == true ) then
			for k, v in pairs( file.Find( val.Location .. "*.lua", "LUA" ) ) do
				AddCSLuaFile( val.Location .. v )
				include( val.Location .. v )
			end
		end
	end
	if( SERVER ) then
		for key, val in pairs( AutorunTable ) do
			if( val.Type == "Client" and val.Enabled == true ) then
				for k, v in pairs( file.Find( val.Location .. "*.lua", "LUA" ) ) do
					AddCSLuaFile( val.Location .. v )
				end
			elseif( val.Type == "Server" and val.Enabled == true ) then
				for k, v in pairs( file.Find( val.Location .. "*.lua", "LUA" ) ) do
					include( val.Location .. v )
				end
			end
		end
	elseif( CLIENT ) then
		for key, val in pairs( AutorunTable ) do
			if( val.Type == "Client" and val.Enabled == true ) then
				for k, v in pairs( file.Find( val.Location .. "*.lua", "LUA" ) ) do
					include( val.Location .. v )
				end
			end
		end
	end
	hook.Run("Discrete.Messages.PostLoad")
end

if DiscreteUI then
	Load()
else
	hook.Add("DiscreteUI.PostLoaded", "Discrete.Messages.Load", Load)
end
