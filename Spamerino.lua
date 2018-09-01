-- spamerino
-- David Whynot
-- v0.2


-- GLOBALS

local count = 0;
local debug = false;


-- MAIN

function spamerinoInit()

	debug = spamerinoDB.debug;

	function spamerinoDebug(s)
		if spamerinoDB.debug then
			print("spamerino debug: " .. s);
		end
	end

	-- T h e  W o r k h o r s e
	C_Timer.NewTicker(spamerinoDB.time, function() spamerinoCallback() end);

	function spamerinoCallback()

		spamerinoDebug("----------------------------------");
		spamerinoDebug("-- function spamerinoCallback() --");
		spamerinoDebug("callback... count: " .. count);

		if spamerinoDB.on then
			local index = GetChannelName(spamerinoDB.chnl);

			if (index ~= nil) then
				if(count > spamerinoDB.max) then

					spamerinoDebug('sending msg: ' .. spamerinoDB.msg);
					if spamerinoDB.test then
						print("spamerino test mode:");
						print("sending msg: " .. spamerinoDB.msg);
						print("... to channel " .. spamerinoDB.chnl);
					else
						-- spamerinoDebug('FORREAL sending msg: ' .. spamerinoDB.msg);
						SendChatMessage(spamerinoDB.msg, "CHANNEL", nil, index);
					end
					count = 0;
				end
			end
		end

		spamerinoDebug("----------------------------------");

	end

	-- OPTIONS

	spamerinoOptions = {};
	spamerinoOptions.panel = CreateFrame("Frame", "spamerinoOptionsPanel", UIParent);
	-- Register in the Interface Addon Options GUI
	-- Set the name for the Category for the Options Panel
	spamerinoOptions.panel.name = "spamerino";
	-- Add the panel to the Interface Options
	InterfaceOptions_AddCategory(spamerinoOptions.panel);

	-- -- Make a child panel
	-- spamerinoOptions.childpanel = CreateFrame("Frame", "spamerinoOptionsChild", spamerinoOptions.panel);
	-- spamerinoOptions.childpanel.name = "MyChild";
	-- -- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
	-- spamerinoOptions.childpanel.parent = spamerinoOptions.panel.name;
	-- -- Add the child to the Interface Options
	-- InterfaceOptions_AddCategory(spamerinoOptions.childpanel);


	-- add text
	local helloFS = spamerinoOptions.panel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	helloFS:SetPoint("TOPLEFT", 20, -10);
	helloFS:SetText("General");

	-- local b = spamerinoOptions.panel:CreateFrame("checkbutton");
	-- b:SetPoint("TOP");
	-- b:SetScript("OnClick", function(self, button, isDown) if ( self:GetChecked() ) then spamerinoDebug("then"); else spamerinoDebug("else"); end end);
	--
	--
	-- local e = spamerinoOptions.panel:CreateFrame("editbox");
	-- e:SetPoint("LEFT");
	-- e:SetScript("OnEditFocusLost", function(self) spamerinoDebug("editfocuslost"); end);
	local spamerinoEditBox = CreateFrame("EditBox", "spamerino_edit_box", spamerinoOptions.panel);
	spamerinoEditBox:SetPoint("TOPLEFT", 200, -25);
	spamerinoEditBox:SetAutoFocus();
	spamerinoEditBox:SetWidth(60);
	spamerinoEditBox:SetHeight(30);

	local uniquealyzer = 1;
	function createCheckbutton(parent, x_loc, y_loc, displayname)
		uniquealyzer = uniquealyzer + 1;

		local checkbutton = CreateFrame("CheckButton", "my_addon_checkbutton_0" .. uniquealyzer, parent, "ChatConfigCheckButtonTemplate");
		checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
		getglobal(checkbutton:GetName() .. 'Text'):SetText(displayname);

		return checkbutton;
	end

	spamerinoEnabledButton = createCheckbutton(spamerinoOptions.panel, 25, -25, " Enable Addon");
	spamerinoEnabledButton.tooltip = "If this is checked, the addon will run.";
	spamerinoEnabledButton:SetScript("OnClick",
		 function(self, button, isDown)
				if ( self:GetChecked() ) then
					spamerinoDebug("enabled checked");
					spamerinoDB.on = true;
				else
					spamerinoDebug("enabled unchecked");
					spamerinoDB.on = false;
				end
		 end
	);
	if ( spamerinoDB.on ) then
		spamerinoEnabledButton:SetChecked(true);
	end

	spamerinoDebugButton = createCheckbutton(spamerinoOptions.panel, 25, -50, " Debug Mode");
	spamerinoDebugButton.tooltip = "If this is checked, debug messages will be output to chat.";
	spamerinoDebugButton:SetScript("OnClick",
		 function(self, button, isDown)
				if( self:GetChecked() ) then
					spamerinoDebug("debug checked");
					spamerinoDB.debug = true;
				else
					spamerinoDebug("debug unchecked");
					spamerinoDB.debug = false;
				end
		 end
	);
	if ( spamerinoDB.debug ) then
		spamerinoDebugButton:SetChecked(true);
	end

	spamerinoTestButton = createCheckbutton(spamerinoOptions.panel, 25, -75, " Test Mode");
	spamerinoTestButton.tooltip = "If this is checked, the addon will simulate sending messages to chat.";
	spamerinoTestButton:SetScript("OnClick",
		 function(self, button, isDown)
				if( self:GetChecked() ) then
					spamerinoDebug("test checked");
					spamerinoDB.test = true;
				else
					spamerinoDebug("test unchecked");
					spamerinoDB.test = false;
				end
		 end
	);
	if ( spamerinoDB.test ) then
		spamerinoTestButton:SetChecked(true);
	end

	local spamerinoResetButton = CreateFrame('Button', "spamerino_resetBtn", spamerinoOptions.panel, "UIPanelButtonTemplate");
	spamerinoResetButton:SetID(1);
	spamerinoResetButton:SetText('Reset');
	spamerinoResetButton:SetWidth(60);
	spamerinoResetButton:SetHeight(30);
	spamerinoResetButton:SetPoint("TOPLEFT", 25, -100);
	spamerinoResetButton:SetScript("OnClick",
		function()
			spamerinoDB.init = false;
		end
	);

	local spamerinoEditButton = CreateFrame('Button', "spamerino_resetBtn", spamerinoOptions.panel, "UIPanelButtonTemplate");
	spamerinoEditButton:SetID(1);
	spamerinoEditButton:SetText('Edit Msg');
	spamerinoEditButton:SetWidth(60);
	spamerinoEditButton:SetHeight(30);
	spamerinoEditButton:SetPoint("TOPLEFT", 100, -100);
	spamerinoEditButton:SetScript("OnClick",
		function()
			spamerinoEditBox:SetFocus();
		end
	);


end


-- create hook
local spamerino = CreateFrame("FRAME", "spamerinoFrame");

-- REGISTER EVENTS
spamerino:RegisterEvent("CHAT_MSG_CHANNEL");
spamerino:RegisterEvent("VARIABLES_LOADED");

-- EVENT HANDLER
local function spamerinoEventHandler(self, event, ...)

	outterSpamerinoDebug("--------------------------------------");
	outterSpamerinoDebug("-- function spamerinoEventHandler() --");
	outterSpamerinoDebug("event: " .. event);

	if ( event == "VARIABLES_LOADED" ) then

		outterSpamerinoDebug("event == VARIABLES_LOADED");

		if not spamerinoDB then
			spamerinoDB = {};
		end

		if not spamerinoDB.init then
			spamerinoDB.on = true;
			spamerinoDB.debug = true;
			spamerinoDB.max = 2;
			-- spamerinoDB.msg = "<Almost Awesome> 5/11M and top US leadership. Open recruitment for ALL CLASSES/SPECS. Raid times are Tue/Thu/Mon 8-11 Eastern. PST if interested.";
			spamerinoDB.msg = "WTS Mythic 0 runs. PST for more info.";
			spamerinoDB.chnl = "Trade - City";
			spamerinoDB.time = 15;
			spamerinoDB.test = true;
			spamerinoDB.init = true;
		end

		spamerinoInit();
	end
	if ( event == "CHAT_MSG_CHANNEL" ) then

		outterSpamerinoDebug("event == CHAT_MSG_CHANNEL");

		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12 = ...;
		if (arg9 == spamerinoDB.chnl) then

			outterSpamerinoDebug("message detected");

			count = count + 1;
		end

		outterSpamerinoDebug("count: " .. count);

	end
	outterSpamerinoDebug("----------------------------------");
end

-- SET SCRIPT
spamerino:SetScript("OnEvent", spamerinoEventHandler);





function outterSpamerinoDebug(s)
	if debug then
		print("oDEBUG: " .. s);
	end
end
