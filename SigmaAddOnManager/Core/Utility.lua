local _, SAOM = ...;

-- Save the current AddOn Profile
function SAOM:SaveAddOnProfile(addons)
	
	-- If there is no table create one
	if not addons then
		addons = {};
	end
	
	-- Check the Character DropDown selection
	local character = AddonCharacterDropDown.selectedValue;
	if character == true then
		character = nil;
	end
	
	-- Save the state of every AddOn
	for i=1,GetNumAddOns() do
		local name = GetAddOnInfo(i);
		local enabled = (GetAddOnEnableState(character, i) > 0);
		if enabled then
			addons[name] = "On";
		else
			addons[name] = "Off";
		end
	end
	
	-- Return the table
	return addons;
end

function SAOM:LoadAddOnProfile(addons)
	
	-- Clear the SearchBox
    SAOM.SearchBox:SetText("");
    SAOM.SearchBox:ClearFocus();
	
	-- If there is no table stop here
	if not addons then
		return;
	end
	
	-- Load only the state of saved AddOns
	for i=1,GetNumAddOns() do
		local name = GetAddOnInfo(i);
		if addons[name] == "On" then
			AddonList_Enable(i, true);
		elseif addons[name] == "Off" then
			AddonList_Enable(i, false);
		end
	end
end

-- Fix Blizz AddonList Errors

function SAOM.GetAddOnInfo(index)
	if index and type(index) == "number" then
		if index < 1 or index > GetNumAddOns() then
			return;
		end
	end
	return SAOM.baseGetAddOnInfo(index);
end

SAOM.baseGetAddOnInfo = GetAddOnInfo;
GetAddOnInfo = SAOM.GetAddOnInfo;

function SAOM.GetAddOnDependencies(index)
	if index and type(index) == "number" then
		if index < 1 or index > GetNumAddOns() then
			return;
		end
	end
	return SAOM.baseGetAddOnDependencies(index);
end

SAOM.baseGetAddOnDependencies = GetAddOnDependencies;
GetAddOnDependencies = SAOM.GetAddOnDependencies;

function SAOM.trim(str)
	return (str:gsub("^%s*(.-)%s*$", "%1"));
end

function SAOM.GetNumAddOns()
	
	if not SAOM.NumAddOns then
		
		local totAddOns = GetNumAddOns();
		local numAddOns = 0;
		
		if totAddOns and totAddOns > 0 then
			local searchFilter = SAOM.trim(SAOM.SearchBox:GetText():lower());
			for i=1, totAddOns do
				local name = GetAddOnInfo(i);
				
				if strmatch(SAOM.trim(name:lower()), searchFilter) ~= nil then
					numAddOns = numAddOns + 1;
				end
			end
		end
		
		if numAddOns > 0 then
			SAOM.NumAddOns = numAddOns;
		end
		
	end
	
	return SAOM.NumAddOns or 0;
end
