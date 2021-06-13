if ElvUI then
	local _, SAOM = ...;
	local E = unpack(ElvUI);
	local S = E:GetModule('Skins');

	SAOM.DeleteProfile:SetWidth(18);
	SAOM.DeleteProfile:ClearAllPoints();
	SAOM.DeleteProfile:SetPoint("LEFT", SigmaAddOnManager_ProfilesListButton, "RIGHT", 7, 0);
	S:HandleButton(SAOM.DeleteProfile, true);
	S:HandleButton(SAOM.SaveProfile, true);
	S:HandleDropDownBox(SAOM.ProfilesList, 165);
	S:HandleEditBox(SAOM.SearchBox);
end
