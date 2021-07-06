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

SAOM.baseGetAddOnInfo = GetAddOnInfo;
GetAddOnInfo = SAOM.GetAddOnInfo;

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

SAOM.baseGetAddOnDependencies = GetAddOnDependencies;
GetAddOnDependencies = SAOM.GetAddOnDependencies;

function SAOM.AddonTooltip_Update(owner)
	if owner then
		return SAOM.baseAddonTooltip_Update(owner);
	end
end

SAOM.baseAddonTooltip_Update = AddonTooltip_Update;
AddonTooltip_Update = SAOM.AddonTooltip_Update;
