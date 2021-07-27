local _, SAOM = ...;

-- Fix Blizz AddonList Errors

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
		local number = owner:GetID();
		if number < 1 or number > GetNumAddOns() then
			return;
		else
			return SAOM.baseAddonTooltip_Update(owner);
		end
	end
end

SAOM.baseAddonTooltip_Update = AddonTooltip_Update;
AddonTooltip_Update = SAOM.AddonTooltip_Update;
