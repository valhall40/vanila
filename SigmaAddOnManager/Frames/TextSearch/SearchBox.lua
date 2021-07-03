local _, SAOM = ...;

-- Create the Search Box
SAOM.SearchBox = CreateFrame("EditBox", nil, AddonList, "SearchBoxTemplate");
MAX_ADDONS_DISPLAYED = MAX_ADDONS_DISPLAYED - 1;

function SAOM.SearchBox.OnLoad()
	SAOM.SearchBox:SetWidth(AddonListInset:GetWidth()-38);
	SAOM.SearchBox:SetHeight(27);
	SAOM.SearchBox:SetPoint("TOPLEFT", AddonListInset, "TOPLEFT", 10, 0);
	SAOM.SearchBox:SetFrameLevel(4);
	AddonListEntry1:SetPoint("TOPLEFT", "AddonList", "TOPLEFT", 10, -90)
	
	SAOM.SearchBox:SetScript("OnShow", SAOM.SearchBox.OnShow);
	
	SAOM.SearchBox:SetScript("OnEscapePressed", SAOM.SearchBox.OnEscapePressed);
	SAOM.SearchBox:HookScript("OnTextChanged", SAOM.SearchBox.OnTextChanged);
	AddonList:HookScript("OnHide", SAOM.SearchBox.Clear);
end

function SAOM.SearchBox.Clear()
	SAOM.SearchBox:SetText("");
end

function SAOM.SearchBox:OnShow()
	SAOM.SearchBox:Show();
	SAOM.SearchBox:SetFocus();
end

function SAOM.SearchBox.OnEscapePressed()
    SAOM.SearchBox:SetText("");
    SAOM.SearchBox:ClearFocus();
end

function SAOM.SearchBox.OnTextChanged()
	AddonList.offset = 0;
	if AddonListScrollFrame then
		AddonListScrollFrame_OnVerticalScroll(AddonListScrollFrame, 0);
	end
	SAOM.AddonList_Update();
end

SAOM.SearchBox.OnLoad();

function SAOM.GetAddonIndex(entryIndex)
	
	local searchFilter = SAOM.trim(SAOM.SearchBox:GetText():lower());
	local index = 0;
	
	if GetNumAddOns() and GetNumAddOns() > 0 then
		for i=1, GetNumAddOns() do
			
			local name, title, notes, loadable, reason, security, newVersion = GetAddOnInfo(i);
			
			if strmatch(SAOM.trim(name:lower()), searchFilter) ~= nil then
				index = index + 1;
				
				if index == entryIndex then
					return i;
				end
			end
		end
	end
	
	return 0;
end

function SAOM.AddonList_Update()
	local numAddOns = GetNumAddOns();
	local numEntrys = SAOM:GetNumAddOns();
	local name, title, notes, enabled, loadable, reason, security;
	local addonIndex, entryIndex;
	local entry, checkbox, string, status, urlButton, securityIcon, versionButton;

	for i=1, MAX_ADDONS_DISPLAYED + 1 do
		entryIndex = AddonList.offset + i;
		entry = _G["AddonListEntry"..i];
		entry:Hide();
		if entryIndex <= numAddOns and i <= MAX_ADDONS_DISPLAYED then
			addonIndex = SAOM.GetAddonIndex(entryIndex);
			
			if addonIndex > 0 then
				name, title, notes, loadable, reason, security = GetAddOnInfo(addonIndex);

				-- Get the character from the current list (nil is all characters)
				local character = UIDropDownMenu_GetSelectedValue(AddonCharacterDropDown);
				if ( character == true ) then
					character = nil;
				end

				checkbox = _G["AddonListEntry"..i.."Enabled"];
				local checkboxState = GetAddOnEnableState(character, addonIndex);
				if ( not InGlue() ) then
					enabled = (GetAddOnEnableState(UnitName("player"), addonIndex) > 0);
				else
					enabled = (checkboxState > 0);
				end

				TriStateCheckbox_SetState(checkboxState, checkbox);
				if (checkboxState == 1 ) then
					checkbox.AddonTooltip = ENABLED_FOR_SOME;
				else
					checkbox.AddonTooltip = nil;
				end

				string = _G["AddonListEntry"..i.."Title"];
				if ( loadable or ( enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED") ) ) then
					string:SetTextColor(1.0, 0.78, 0.0);
				elseif ( enabled and reason ~= "DEP_DISABLED" ) then
					string:SetTextColor(1.0, 0.1, 0.1);
				else
					string:SetTextColor(0.5, 0.5, 0.5);
				end
				if ( title ) then
					string:SetText(title);
				else
					string:SetText(name);
				end
				securityIcon = _G["AddonListEntry"..i.."SecurityIcon"];
				if ( security == "SECURE" ) then
					AddonList_SetSecurityIcon(securityIcon, 1);
				elseif ( security == "INSECURE" ) then
					AddonList_SetSecurityIcon(securityIcon, 2);
				elseif ( security == "BANNED" ) then
					AddonList_SetSecurityIcon(securityIcon, 3);
				end
				_G["AddonListEntry"..i.."Security"].tooltip = _G["ADDON_"..security];
				string = _G["AddonListEntry"..i.."Status"];
				if ( not loadable and reason ) then
					string:SetText(_G["ADDON_"..reason]);
				else
					string:SetText("");
				end

				if ( not InGlue() ) then
					if ( enabled ~= AddonList.startStatus[addonIndex] and reason ~= "DEP_DISABLED" or 
						(reason ~= "INTERFACE_VERSION" and tContains(AddonList.outOfDateIndexes, addonIndex)) or 
						(reason == "INTERFACE_VERSION" and not tContains(AddonList.outOfDateIndexes, addonIndex))) then
						if ( enabled ) then
							-- special case for loadable on demand addons
							if ( AddonList_IsAddOnLoadOnDemand(addonIndex) ) then
								AddonList_SetStatus(entry, true, false, false)
							else
								AddonList_SetStatus(entry, false, false, true)
							end
						else
							AddonList_SetStatus(entry, false, false, true)
						end
					else
						AddonList_SetStatus(entry, false, true, false)
					end
				else
					AddonList_SetStatus(entry, false, true, false)
				end
				
				entry:SetID(addonIndex);
				entry:Show();
			end
		end
	end
	
	-- ScrollFrame stuff
	FauxScrollFrame_Update(AddonListScrollFrame, numEntrys, MAX_ADDONS_DISPLAYED, ADDON_BUTTON_HEIGHT);
end

function SAOM.AddonList_FirstUpdate()
	if not SAOM.HOOKED then
		SAOM.HOOKED = true;
		hooksecurefunc("AddonList_Update", SAOM.AddonList_Update);
		AddonList_Update();
	end
end

hooksecurefunc("AddonList_Update", SAOM.AddonList_FirstUpdate);
