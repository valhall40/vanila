local _, SAOM = ...;

-- Fix Blizz AddonList Errors

function SAOM.GetAddOnInfo(index)
	local number = tonumber(index);
	if number then
		if number < 1 or number > GetNumAddOns() then
			return;
		else
			return SAOM.baseGetAddOnInfo(number);
		end
	else
		return SAOM.baseGetAddOnInfo(index);
	end
end

function SAOM.GetAddOnDependencies(index)
	local number = tonumber(index);
	if number then
		if number < 1 or number > GetNumAddOns() then
			return;
			else
			return SAOM.baseGetAddOnDependencies(number);
		end
	else
		return SAOM.baseGetAddOnDependencies(index);
	end
end

function SAOM.AddonTooltip_Update(owner)
	if owner then
		return SAOM.baseAddonTooltip_Update(owner);
	end
end

SAOM.Frame = CreateFrame("Frame");

function SAOM.Frame:OnEvent(event, arg1, ...)
	if event == "ADDON_LOADED" and arg1 == "SigmaAddOnManager" then
		if SigmaAddOnManager.ReplaceBlizzFunctions ~= false then
			SAOM.baseGetAddOnInfo = GetAddOnInfo;
			GetAddOnInfo = SAOM.GetAddOnInfo;

			SAOM.baseGetAddOnDependencies = GetAddOnDependencies;
			GetAddOnDependencies = SAOM.GetAddOnDependencies;

			SAOM.baseAddonTooltip_Update = AddonTooltip_Update;
			AddonTooltip_Update = SAOM.AddonTooltip_Update;
		end
	end
end
 
SAOM.Frame:RegisterEvent("ADDON_LOADED");
SAOM.Frame:SetScript("OnEvent", SAOM.Frame.OnEvent);
