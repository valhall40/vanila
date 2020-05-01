-- Switch to the Character specific AddOns
AddonCharacterDropDown.selectedValue = UnitName("player");
AddonCharacterDropDownText:SetText(UnitName("player"));
-- Move the Blizzard DropDown
AddonCharacterDropDown:ClearAllPoints();
AddonCharacterDropDown:SetPoint("TOPLEFT", AddonList, "TOPLEFT", -10, -30);
