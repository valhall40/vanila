local _, SAOM = ...;

-- Create the Button
SAOM.SaveProfile = CreateFrame("Button", nil, AddonList, "MagicButtonTemplate");
-- Set size and position
SAOM.SaveProfile:SetWidth(85);
SAOM.SaveProfile:SetPoint("LEFT", AddonListDisableAllButton, "RIGHT", 1, 0);
-- Set the text
SAOM.SaveProfile:SetText(SAOM.L["SAVE"]);

-- Set Scripts
function SAOM.SaveProfile_OnClick()
	-- Clear the SearchBox Focus
    SAOM.SearchBox:ClearFocus();
	StaticPopup_Show("SigmaAddOnManager_SaveProfile");
end
SAOM.SaveProfile:SetScript("OnClick", SAOM.SaveProfile_OnClick);