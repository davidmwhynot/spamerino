local options = {
	name = "CustomerGen",
	handler = customerGen,
	type
}
local defaults = {
	char = {
		-- char vars
		name = "xd"
	}
	realm = {
		-- realm vars
	}
	global = {
		-- global vars
	}
}
customerGen = LibStub("AceAddon-3.0"):NewAddon("customerGen", "AceConsole-3.0", "AceDB-3.0")

function customerGen:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("customerGenDB")
	customerGen:Print("test")
	customerGen:RegisterChatCommand("customerGenXD", "hehexd")
end

function customerGen:OnEnable()
	customerGen:Print("test")
end

function customerGen:OnDisable()
end

function customerGen:hehexd(kappa)
	customerGen:Print(kappa .. "hehexd")
end