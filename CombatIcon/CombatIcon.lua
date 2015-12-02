local targetFrame = XPerl_Target or TargetFrame
local focusFrame = XPerl_Focus or FocusFrame
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
frame:RegisterUnitEvent("UNIT_FLAGS", "target", "focus")

frame.target = CreateFrame("Frame")
frame.target:SetPoint("BottomRight", targetFrame, "TopRight", -18, 2)
frame.target:SetSize(25, 25)
frame.target:SetParent(targetFrame)
frame.target.icon = frame.target:CreateTexture(nil, "Border")
frame.target.icon:SetTexture("Interface\\Icons\\ABILITY_DUALWIELD")
frame.target.icon:SetAllPoints(frame.target)
frame.target:Hide()

frame.focus = CreateFrame("Frame")
frame.focus:SetPoint("BottomRight", focusFrame, "TopRight", -18, 2)
frame.focus:SetSize(25, 25)
frame.focus:SetParent(focusFrame)
frame.focus.icon = frame.focus:CreateTexture(nil, "Border")
frame.focus.icon:SetTexture("Interface\\Icons\\ABILITY_DUALWIELD")
frame.focus.icon:SetAllPoints(frame.focus)
frame.focus:Hide()

local function UpdateTargetFrame()
	targetFrame = XPerl_Target or TargetFrame
	frame.target:SetPoint("BottomRight", targetFrame, "TopRight", -18, 2)
	frame.target:SetParent(targetFrame)
end

local function UpdateFocusFrame()
	focusFrame = XPerl_Focus or FocusFrame
	frame.focus:SetPoint("BottomRight", focusFrame, "TopRight", -18, 2)
	frame.focus:SetParent(focusFrame)
end

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local addon = ...
		if addon == "ZPerl_Target" then
			UpdateTargetFrame()
		elseif "ZPerl_TargetTarget" then
			UpdateFocusFrame()
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		if UnitAffectingCombat("target") then
			self.target:Show()
		else
			self.target:Hide()
		end
	elseif event == "PLAYER_FOCUS_CHANGED" then
		if UnitAffectingCombat("focus") then
			self.focus:Show()
		else
			self.focus:Hide()
		end
	else
		if UnitAffectingCombat("target") then
			self.target:Show()
		else
			self.target:Hide()
		end
		if UnitAffectingCombat("focus") then
			self.focus:Show()
		else
			self.focus:Hide()
		end
	end
end)