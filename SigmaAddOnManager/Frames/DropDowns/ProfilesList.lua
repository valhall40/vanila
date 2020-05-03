local _, SAOM = ...;

-- Create the DropDown menu
SAOM.ProfilesList = CreateFrame("Frame", "SigmaAddOnManager_ProfilesList", AddonList, "UIDropDownMenuTemplate");

function SAOM.ProfilesList:OnLoad()
	-- Set the position
	SAOM.ProfilesList:SetPoint("LEFT", AddonCharacterDropDownButton, "RIGHT", -14, -3);
	-- Set Scripts
	SAOM.ProfilesList:SetScript("OnShow", SAOM.ProfilesList.OnShow);
end

function SAOM.ProfilesList:OnShow()
	-- Reset visibility
	SAOM.ProfilesList:Show();
	SAOM.DeleteProfile:Hide();
	-- If there is no saved data create an empty table
	if not SigmaAddOnManager then 
		SigmaAddOnManager = {};
	end
	-- If there are profiles initialize the DropDown menu
	if #SigmaAddOnManager > 0 then
		UIDropDownMenu_Initialize(SAOM.ProfilesList, SAOM.ProfilesList.Initialize);
		UIDropDownMenu_SetSelectedID(SAOM.ProfilesList, 1);
	else
		-- Otherwise hide it
		SAOM.ProfilesList:Hide();
	end
end

function SAOM.ProfilesList:Initialize()
	-- The first button is not a profile
	local info = {};
	info.text = SAOM.L["SELECT"];
	info.func = SAOM.ProfilesList.OnClick;
	info.checked = false;
	UIDropDownMenu_AddButton(info);
	-- Add one extra button for every saved profile
	for i,profile in ipairs(SigmaAddOnManager) do
		info = {};
		info.text = profile.name;
		info.func = SAOM.ProfilesList.OnClick;
		info.checked = false;
		UIDropDownMenu_AddButton(info);
	end
end

function SAOM.ProfilesList:OnClick()
	-- Check which profile is selected
	local selected = self:GetID();
	UIDropDownMenu_SetSelectedID(SAOM.ProfilesList, selected);
	-- If a valid profile is selected
	if selected > 1 then
		-- Show the DeleteProfile button
		SAOM.DeleteProfile:Show();
		-- Load the profile
		SAOM:LoadAddOnProfile(SigmaAddOnManager[selected - 1].addons);
	else
		-- Otherwise hide the DeleteProfile button
		SAOM.DeleteProfile:Hide();
	end
end

SAOM.ProfilesList:OnLoad()
