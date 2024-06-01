CharacterDatabase = CharacterDatabase or {}
local selectedCharacter = nil

-- Funktion zum Aktualisieren des Hauptfensters
local function updateMainFrame(frame, selectedCharacterIndex)
	local content = frame.content
	for _, child in ipairs({content:GetChildren()}) do
    	child:Hide()
	end

	local classColors = {
    	["Magier"] = "#65BDD2",
    	["Druide"] = "#F67C0E",
    	["Hexenmeister"] = "#9583C6",
    	["Jäger"] = "#A5CD6E",
    	["Priester"] = "#FFFFFF",
    	["Schamane"] = "#2668BD",
    	["Todesritter"] = "#CB1F3F",
    	["Paladin"] = "#E289A5",
    	["Krieger"] = "#B88E63",
    	["Schurke"] = "#F2E562",
	}

local yOffset = 0  -- Initialize yOffset variable

for index, char in ipairs(CharacterDatabase) do
    local entry = CreateFrame("Frame", nil, content)
    entry:SetSize(720, 30)
    entry:SetPoint("TOP", 0, yOffset)

    entry.indexText = entry:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    entry.indexText:SetPoint("LEFT", 0, 0)
    entry.indexText:SetText(index)

    entry.text = entry:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    entry.text:SetPoint("LEFT", entry.indexText, "RIGHT", 10, 0)
    local classColor = classColors[char.class] or "#FFFFFF"
    local enchanterText = char.enchanter and "Verzauberer" or ""
    local frozenText = char.frozen and "[E]" or ""
    local twinkText = char.twink and "Twink von " .. char.twink or ""
    entry.text:SetText(string.format("|cff%s%s|r - %s - %s %s %s", classColor:gsub("#", ""), char.name, char.spec, enchanterText, frozenText, twinkText))

    entry:EnableMouse(true)
    entry:SetScript("OnMouseDown", function()
        if selectedCharacter == entry then
            selectedCharacter:SetBackdropColor(0, 0, 0, 0)
            selectedCharacter:SetBackdrop(nil)
            selectedCharacter = nil
            frame.editButton:Disable()
            frame.deleteButton:Disable()
            frame.upButton:Disable()
            frame.downButton:Disable()
            frame.suicideButton:Disable()
            frame.kingButton:Disable()
            frame.freezeButton:Disable()
            frame.unfreezeButton:Disable()
        else
            if selectedCharacter then
                selectedCharacter:SetBackdropColor(0, 0, 0, 0)
                selectedCharacter:SetBackdrop(nil)
            end
            selectedCharacter = entry
            entry:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true, tileSize = 16, edgeSize = 16,
                insets = {left = 4, right = 4, top = 4, bottom = 4}
            })
            entry:SetBackdropColor(0.2, 0.6, 1, 0.5)
            frame.editButton:Enable()
            frame.deleteButton:Enable()
            frame.upButton:Enable()
            frame.downButton:Enable()
            frame.suicideButton:Enable()
            frame.kingButton:Enable()
            frame.freezeButton:Enable()
            if char.frozen then
                frame.unfreezeButton:Enable()
            else
                frame.unfreezeButton:Disable()
            end
        end
    end)

    yOffset = yOffset - 35  -- Reduce yOffset for the main character

    -- Add twinks under the main character
    if char.twinks then
        for _, twink in ipairs(char.twinks) do
            local twinkEntry = CreateFrame("Frame", nil, content)
            twinkEntry:SetSize(720, 30)
            twinkEntry:SetPoint("TOP", 0, yOffset)

            twinkEntry.indexText = twinkEntry:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            twinkEntry.indexText:SetPoint("LEFT", 20, 0)  -- Indent twinks
            twinkEntry.indexText:SetText("-")

            twinkEntry.text = twinkEntry:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            twinkEntry.text:SetPoint("LEFT", twinkEntry.indexText, "RIGHT", 10, 0)
            local twinkClassColor = classColors[twink.class] or "#FFFFFF"
            local twinkEnchanterText = twink.enchanter and "Verzauberer" or ""
            local twinkFrozenText = twink.frozen and "[E]" or ""
            twinkEntry.text:SetText(string.format("|cff%s%s|r - %s - %s %s", twinkClassColor:gsub("#", ""), twink.name, twink.spec, twinkEnchanterText, twinkFrozenText))

            twinkEntry:EnableMouse(true)
            twinkEntry:SetScript("OnMouseDown", function()
                if selectedCharacter == twinkEntry then
                    selectedCharacter:SetBackdropColor(0, 0, 0, 0)
                    selectedCharacter:SetBackdrop(nil)
                    selectedCharacter = nil
                    frame.editButton:Disable()
                    frame.deleteButton:Disable()
                    frame.upButton:Disable()
                    frame.downButton:Disable()
                    frame.suicideButton:Disable()
                    frame.kingButton:Disable()
                    frame.freezeButton:Disable()
                    frame.unfreezeButton:Disable()
                else
                    if selectedCharacter then
                        selectedCharacter:SetBackdropColor(0, 0, 0, 0)
                        selectedCharacter:SetBackdrop(nil)
                    end
                    selectedCharacter = twinkEntry
                    twinkEntry:SetBackdrop({
                        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                        tile = true, tileSize = 16, edgeSize = 16,
                        insets = {left = 4, right = 4, top = 4, bottom = 4}
                    })
                    twinkEntry:SetBackdropColor(0.2, 0.6, 1, 0.5)
                    frame.editButton:Enable()
                    frame.deleteButton:Enable()
                    frame.upButton:Enable()
                    frame.downButton:Enable()
                    frame.suicideButton:Enable()
                    frame.kingButton:Enable()
                    frame.freezeButton:Enable()
                    if twink.frozen then
                        frame.unfreezeButton:Enable()
                    else
                        frame.unfreezeButton:Disable()
                    end
                end
            end)

            yOffset = yOffset - 20  -- Reduce yOffset for each twink with appropriate space
        end
    end

    	if selectedCharacterIndex and selectedCharacterIndex == index then
        	selectedCharacter = entry
        	entry:SetBackdrop({
            	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            	tile = true, tileSize = 16, edgeSize = 16,
            	insets = {left = 4, right = 4, top = 4, bottom = 4}
        	})
        	entry:SetBackdropColor(0.2, 0.6, 1, 0.5)
    	end

    	yOffset = yOffset - 20
	end

	content:SetSize(720, -yOffset)
end

local function resetCharacterFrame(frame)
	frame.nameInput:SetText("")
	UIDropDownMenu_SetSelectedValue(frame.classDropdown, nil)
	UIDropDownMenu_SetText(frame.classDropdown, "")
	UIDropDownMenu_SetSelectedValue(frame.specDropdown, nil)
	UIDropDownMenu_SetText(frame.specDropdown, "")
	frame.enchanterCheckbox:SetChecked(false)
	UIDropDownMenu_SetSelectedValue(frame.twinkDropdown, " ")
	UIDropDownMenu_SetText(frame.twinkDropdown, " ")
end

local function setEditCharacterFrame(frame, char)
	frame.nameInput:SetText(char.name)
	UIDropDownMenu_SetSelectedValue(frame.classDropdown, char.class)
	UIDropDownMenu_SetText(frame.classDropdown, char.class)
	UIDropDownMenu_SetSelectedValue(frame.specDropdown, char.spec)
	UIDropDownMenu_SetText(frame.specDropdown, char.spec)
	frame.enchanterCheckbox:SetChecked(char.enchanter)
	if char.twink then
    	UIDropDownMenu_SetSelectedValue(frame.twinkDropdown, char.twink)
    	UIDropDownMenu_SetText(frame.twinkDropdown, char.twink)
	else
    	UIDropDownMenu_SetSelectedValue(frame.twinkDropdown, " ")
    	UIDropDownMenu_SetText(frame.twinkDropdown, " ")
	end
end

local function characterNameExists(name)
	for _, char in ipairs(CharacterDatabase) do
    	if char.name == name then
        	return true
    	end
	end
	return false
end

local function getNonTwinkCharacters()
	local nonTwinks = {" "}
	for _, char in ipairs(CharacterDatabase) do
    	if not char.twink then
        	table.insert(nonTwinks, char.name)
    	end
	end
	return nonTwinks
end

local function createCharacterFrame(parent, mode)
	local frame = CreateFrame("Frame", mode == "add" and "AddCharacterFrame" or "EditCharacterFrame", parent, "UIPanelDialogTemplate")
	frame:SetSize(600, 286)  -- Vergrößert um den Faktor 1,3
	frame:SetPoint("CENTER", parent)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	frame.title = frame:CreateFontString(nil, "OVERLAY")
	frame.title:SetFontObject("GameFontHighlight")
	frame.title:SetPoint("TOP", frame, "TOP", 0, -10)
	frame.title:SetText(mode == "add" and "Charakter hinzufügen" or "Charakter bearbeiten")

	local nameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	nameLabel:SetPoint("TOPLEFT", 10, -40)
	nameLabel:SetText("Charaktername:")

	local nameInput = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
	nameInput:SetSize(450, 20)
	nameInput:SetPoint("LEFT", nameLabel, "RIGHT", 10, 0)
	nameInput:SetAutoFocus(false)
	nameInput:SetMaxLetters(50)
	frame.nameInput = nameInput

	local classLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	classLabel:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -20)
	classLabel:SetText("Klasse:")

	local classDropdown = CreateFrame("Frame", mode == "add" and "ClassDropdownAdd" or "ClassDropdownEdit", frame, "UIDropDownMenuTemplate")
	classDropdown:SetPoint("LEFT", classLabel, "RIGHT", 10, 0)
	frame.classDropdown = classDropdown

	local classes = {"Magier", "Hexenmeister", "Schamane", "Todesritter", "Priester", "Schurke", "Paladin", "Jäger", "Druide", "Krieger"}
	UIDropDownMenu_SetWidth(classDropdown, 180)
	UIDropDownMenu_Initialize(classDropdown, function(self, level, menuList)
    	local info = UIDropDownMenu_CreateInfo()
    	for _, class in ipairs(classes) do
        	info.text = class
        	info.func = function(self)
            	UIDropDownMenu_SetSelectedValue(classDropdown, class)
            	UIDropDownMenu_SetText(classDropdown, class)
        	end
        	UIDropDownMenu_AddButton(info)
    	end
	end)

	local specLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	specLabel:SetPoint("TOPLEFT", classLabel, "BOTTOMLEFT", 0, -20)
	specLabel:SetText("Positionen:")

	local specDropdown = CreateFrame("Frame", mode == "add" and "SpecDropdownAdd" or "SpecDropdownEdit", frame, "UIDropDownMenuTemplate")
	specDropdown:SetPoint("LEFT", specLabel, "RIGHT", 10, 0)
	frame.specDropdown = specDropdown

	local specs = {"Heiler", "Tank", "Range DD", "Melee DD"}
	UIDropDownMenu_SetWidth(specDropdown, 180)
	UIDropDownMenu_Initialize(specDropdown, function(self, level, menuList)
    	local info = UIDropDownMenu_CreateInfo()
    	for _, spec in ipairs(specs) do
        	info.text = spec
        	info.func = function(self)
            	UIDropDownMenu_SetSelectedValue(specDropdown, spec)
            	UIDropDownMenu_SetText(specDropdown, spec)
        	end
        	UIDropDownMenu_AddButton(info)
    	end
	end)

	local twinkLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	twinkLabel:SetPoint("TOPLEFT", specLabel, "BOTTOMLEFT", 0, -20)
	twinkLabel:SetText("Twink von:")

	local twinkDropdown = CreateFrame("Frame", mode == "add" and "TwinkDropdownAdd" or "TwinkDropdownEdit", frame, "UIDropDownMenuTemplate")
	twinkDropdown:SetPoint("LEFT", twinkLabel, "RIGHT", 10, 0)
	frame.twinkDropdown = twinkDropdown

	UIDropDownMenu_SetWidth(twinkDropdown, 180)
	UIDropDownMenu_Initialize(twinkDropdown, function(self, level, menuList)
    	local info = UIDropDownMenu_CreateInfo()
    	local nonTwinks = getNonTwinkCharacters()
    	for _, name in ipairs(nonTwinks) do
        	info.text = name
        	info.func = function(self)
            	UIDropDownMenu_SetSelectedValue(twinkDropdown, name)
            	UIDropDownMenu_SetText(twinkDropdown, name)
        	end
        	UIDropDownMenu_AddButton(info)
    	end
	end)

	local enchanterCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
	enchanterCheckbox:SetPoint("TOPLEFT", twinkLabel, "BOTTOMLEFT", 0, -20)
	enchanterCheckbox.text = enchanterCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	enchanterCheckbox.text:SetPoint("LEFT", enchanterCheckbox, "RIGHT", 2, 0)
	enchanterCheckbox.text:SetText("Verzauberer")
	frame.enchanterCheckbox = enchanterCheckbox


local okButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
okButton:SetSize(80, 25)
okButton:SetPoint("BOTTOMLEFT", 10, 10)
okButton:SetText("OK")
okButton:SetScript("OnClick", function()
    local name = nameInput:GetText()
    local class = UIDropDownMenu_GetSelectedValue(classDropdown)
    local spec = UIDropDownMenu_GetSelectedValue(specDropdown)
    local enchanter = enchanterCheckbox:GetChecked() and true or false
    local twink = UIDropDownMenu_GetSelectedValue(twinkDropdown)
    if twink == " " then
        twink = nil
    end

    if name and class and spec then
        if mode == "add" then
            -- Check if we are adding a twink
            if twink then
               for _, char in ipairs(CharacterDatabase) do
                    if char.name == twink then
                        if not char.twinks then
                            char.twinks = {}
                        end
                        table.insert(char.twinks, {
                            name = name,
                            class = class,
                            spec = spec,
                            enchanter = enchanter,
                            frozen = false
                        })
                        break
                    end
                 end
            else
                -- Add new character without a twink association
                table.insert(CharacterDatabase, {
                    name = name,
                    class = class,
                    spec = spec,
                    enchanter = enchanter,
                    frozen = false
                })
            end
        else
            local index = selectedCharacter.indexText:GetText()
            local char = CharacterDatabase[tonumber(index)]
            char.name = name
            char.class = class
            char.spec = spec
            char.enchanter = enchanter
            char.twink = twink
        end
        updateMainFrame(parent)
        frame:Hide()
    else
        print("Bitte alle Felder ausfüllen.")
    end
end)

	local cancelButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	cancelButton:SetSize(80, 25)
	cancelButton:SetPoint("BOTTOMRIGHT", -10, 10)
	cancelButton:SetText("Abbrechen")
	cancelButton:SetScript("OnClick", function()
    	frame:Hide()
	end)

	frame:SetScript("OnShow", function()
    	if mode == "add" then
        	resetCharacterFrame(frame)
    	else
        	local index = selectedCharacter.indexText:GetText()
        	local char = CharacterDatabase[tonumber(index)]
        	setEditCharacterFrame(frame, char)
    	end
	end)

	frame:SetFrameStrata("DIALOG")

	return frame
end

local function createDeleteConfirmationFrame(parent)
	local frame = CreateFrame("Frame", "DeleteCharacterFrame", parent, "UIPanelDialogTemplate")
	frame:SetSize(400, 195)  -- Vergrößert um den Faktor 1,3
	frame:SetPoint("CENTER", parent)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	frame.title = frame:CreateFontString(nil, "OVERLAY")
	frame.title:SetFontObject("GameFontHighlight")
	frame.title:SetPoint("TOP", frame, "TOP", 0, -10)
	frame.title:SetText("Charakter löschen")

	local warningText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	warningText:SetPoint("CENTER", frame, "CENTER", 0, 0)
	warningText:SetText("Achtung, du möchtest diesen Charakter löschen. Charakter löschen?")

	local yesButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	yesButton:SetSize(80, 25)
	yesButton:SetPoint("BOTTOMLEFT", 10, 10)
	yesButton:SetText("Ja")
	yesButton:SetScript("OnClick", function()
    	local index = selectedCharacter.indexText:GetText()
    	table.remove(CharacterDatabase, tonumber(index))
    	selectedCharacter = nil
    	updateMainFrame(parent)
    	parent.editButton:Disable()
    	parent.deleteButton:Disable()
    	parent.upButton:Disable()
    	parent.downButton:Disable()
    	parent.suicideButton:Disable()
    	parent.kingButton:Disable()
    	parent.freezeButton:Disable()
    	parent.unfreezeButton:Disable()
    	frame:Hide()
	end)

	local cancelButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	cancelButton:SetSize(80, 25)
	cancelButton:SetPoint("BOTTOMRIGHT", -10, 10)
	cancelButton:SetText("Abbrechen")
	cancelButton:SetScript("OnClick", function()
    	frame:Hide()
	end)

	frame:SetFrameStrata("DIALOG")

	return frame
end

local function createMainFrame()
	local frame = CreateFrame("Frame", "CharacterDatabaseMainFrame", UIParent, "UIPanelDialogTemplate")
	frame:SetSize(720, 520)  -- Vergrößert um den Faktor 1,3
	frame:SetPoint("CENTER")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	frame.title = frame:CreateFontString(nil, "OVERLAY")
	frame.title:SetFontObject("GameFontHighlight")
	frame.title:SetPoint("TOP", frame, "TOP", 0, -10)
	frame.title:SetText("SKS Liste CIVITAS")

	local scrollFrame = CreateFrame("ScrollFrame", "CharacterDatabaseScrollFrame", frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 10, -30)
	scrollFrame:SetPoint("BOTTOMRIGHT", -150, 50)

	local content = CreateFrame("Frame", "CharacterDatabaseContentFrame", scrollFrame)
	content:SetSize(700, 1300)  -- Vergrößert um den Faktor 1,3
	scrollFrame:SetScrollChild(content)

	frame.content = content
	frame.scrollFrame = scrollFrame

	local addButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	addButton:SetSize(140, 40)
	addButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
	addButton:SetText("Charakter hinzufügen")
	addButton:SetScript("OnClick", function()
    	local addCharacterFrame = _G["AddCharacterFrame"]
    	if not addCharacterFrame then
        	addCharacterFrame = createCharacterFrame(frame, "add")
    	end
    	addCharacterFrame:Show()
	end)

	local editButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	editButton:SetSize(140, 40)
	editButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
	editButton:SetText("Charakter bearbeiten")
	editButton:Disable()
	editButton:SetScript("OnClick", function()
    	local editCharacterFrame = _G["EditCharacterFrame"]
    	if not editCharacterFrame then
        	editCharacterFrame = createCharacterFrame(frame, "edit")
    	end
    	local index = selectedCharacter.indexText:GetText()
    	local char = CharacterDatabase[tonumber(index)]
    	setEditCharacterFrame(editCharacterFrame, char)
    	editCharacterFrame:Show()
	end)

	local deleteButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	deleteButton:SetSize(120, 40)
	deleteButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
	deleteButton:SetText("Charakter löschen")
	deleteButton:Disable()
	deleteButton:SetScript("OnClick", function()
    	local deleteCharacterFrame = _G["DeleteCharacterFrame"]
    	if not deleteCharacterFrame then
        	deleteCharacterFrame = createDeleteConfirmationFrame(frame)
    	end
    	deleteCharacterFrame:Show()
	end)

	local kingButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	kingButton:SetSize(120, 40)
	kingButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -60)
	kingButton:SetText("King")
	kingButton:Disable()
	kingButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	if index > 1 then
        	local char = table.remove(CharacterDatabase, index)
        	table.insert(CharacterDatabase, 1, char)
        	updateMainFrame(scrollFrame, 1)
        	local newSelectedCharacter = frame.content:GetChildren()[1]
        	if newSelectedCharacter then
            	newSelectedCharacter:SetBackdrop({
                	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                	tile = true, tileSize = 16, edgeSize = 16,
                	insets = {left = 4, right = 4, top = 4, bottom = 4}
            	})
            	newSelectedCharacter:SetBackdropColor(0.2, 0.6, 1, 0.5)
            	selectedCharacter = newSelectedCharacter
            	frame.editButton:Enable()
            	frame.deleteButton:Enable()
            	frame.upButton:Enable()
            	frame.downButton:Enable()
            	frame.suicideButton:Enable()
            	frame.kingButton:Enable()
            	frame.freezeButton:Enable()
            	frame.unfreezeButton:Enable()
        	end
    	end
	end)

	local upButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	upButton:SetSize(120, 40)
	upButton:SetPoint("TOPRIGHT", kingButton, "BOTTOMRIGHT", 0, -10)
	upButton:SetText("Nach oben")
	upButton:Disable()
	upButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	if index > 1 then
        	local targetIndex = index - 1
        	while targetIndex > 1 and CharacterDatabase[targetIndex].frozen do
            	targetIndex = targetIndex - 1
        	end
        	if not CharacterDatabase[targetIndex].frozen then
            	local temp = CharacterDatabase[index]
            	CharacterDatabase[index] = CharacterDatabase[targetIndex]
            	CharacterDatabase[targetIndex] = temp
            	updateMainFrame(scrollFrame, targetIndex)
            	local newSelectedCharacter = frame.content:GetChildren()[targetIndex]
            	if newSelectedCharacter then
                	newSelectedCharacter:SetBackdrop({
                    	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                    	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                    	tile = true, tileSize = 16, edgeSize = 16,
                    	insets = {left = 4, right = 4, top = 4, bottom = 4}
                	})
                	newSelectedCharacter:SetBackdropColor(0.2, 0.6, 1, 0.5)
                	selectedCharacter = newSelectedCharacter
                	frame.editButton:Enable()
                	frame.deleteButton:Enable()
                	frame.upButton:Enable()
                	frame.downButton:Enable()
                	frame.suicideButton:Enable()
                	frame.kingButton:Enable()
                	frame.freezeButton:Enable()
                	frame.unfreezeButton:SetEnabled(selectedCharacter and CharacterDatabase[tonumber(selectedCharacter.indexText:GetText())].frozen == true)
            	end
        	end
    	end
	end)

	local downButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	downButton:SetSize(120, 40)
	downButton:SetPoint("TOPRIGHT", upButton, "BOTTOMRIGHT", 0, -10)
	downButton:SetText("Nach unten")
	downButton:Disable()
	downButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	if index < #CharacterDatabase then
        	local targetIndex = index + 1
        	while targetIndex < #CharacterDatabase and CharacterDatabase[targetIndex].frozen do
            	targetIndex = targetIndex + 1
        	end
        	if not CharacterDatabase[targetIndex].frozen then
            	local temp = CharacterDatabase[index]
            	CharacterDatabase[index] = CharacterDatabase[targetIndex]
            	CharacterDatabase[targetIndex] = temp
            	updateMainFrame(scrollFrame, targetIndex)
            	local newSelectedCharacter = frame.content:GetChildren()[targetIndex]
            	if newSelectedCharacter then
                	newSelectedCharacter:SetBackdrop({
                    	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                    	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                    	tile = true, tileSize = 16, edgeSize = 16,
                    	insets = {left = 4, right = 4, top = 4, bottom = 4}
                	})
                	newSelectedCharacter:SetBackdropColor(0.2, 0.6, 1, 0.5)
                	selectedCharacter = newSelectedCharacter
                	frame.editButton:Enable()
                	frame.deleteButton:Enable()
                	frame.upButton:Enable()
                	frame.downButton:Enable()
                	frame.suicideButton:Enable()
                	frame.kingButton:Enable()
                	frame.freezeButton:Enable()
                	frame.unfreezeButton:SetEnabled(selectedCharacter and CharacterDatabase[tonumber(selectedCharacter.indexText:GetText())].frozen == true)
            	end
        	end
    	end
	end)

	local suicideButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	suicideButton:SetSize(120, 40)
	suicideButton:SetPoint("TOPRIGHT", downButton, "BOTTOMRIGHT", 0, -10)
	suicideButton:SetText("Suicide")
	suicideButton:Disable()
	suicideButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	local iteration = 0  -- Schleifen-Zähler
    	local maxIterations = #CharacterDatabase
    	if CharacterDatabase[index].frozen then return end
    	while iteration < maxIterations do
        	if index < #CharacterDatabase then
            	local targetIndex = index + 1
            	while targetIndex < #CharacterDatabase and CharacterDatabase[targetIndex].frozen do
                	targetIndex = targetIndex + 1
            	end
            	if not CharacterDatabase[targetIndex].frozen then
                	local temp = CharacterDatabase[index]
                	CharacterDatabase[index] = CharacterDatabase[targetIndex]
                	CharacterDatabase[targetIndex] = temp
                	updateMainFrame(scrollFrame, targetIndex)
                	local newSelectedCharacter = frame.content:GetChildren()[targetIndex]
                	if newSelectedCharacter then
                    	newSelectedCharacter:SetBackdrop({
                        	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                        	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                        	tile = true, tileSize = 16, edgeSize = 16,
                        	insets = {left = 4, right = 4, top = 4, bottom = 4}
                    	})
                    	newSelectedCharacter:SetBackdropColor(0.2, 0.6, 1, 0.5)
                    	selectedCharacter = newSelectedCharacter
                    	frame.editButton:Enable()
                    	frame.deleteButton:Enable()
                    	frame.upButton:Enable()
                    	frame.downButton:Enable()
                    	frame.suicideButton:Enable()
                    	frame.kingButton:Enable()
                    	frame.freezeButton:Enable()
                    	frame.unfreezeButton:SetEnabled(selectedCharacter and CharacterDatabase[tonumber(selectedCharacter.indexText:GetText())].frozen == true)
                	end
                	index = targetIndex  -- Aktualisiere den Index für den nächsten Schleifendurchlauf
            	end
        	end
        	iteration = iteration + 1  -- Erhöhe den Schleifen-Zähler
    	end
	end)

	local freezeButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	freezeButton:SetSize(120, 40)
	freezeButton:SetPoint("TOPRIGHT", suicideButton, "BOTTOMRIGHT", 0, -10)
	freezeButton:SetText("Einfrieren")
	freezeButton:Disable()
	freezeButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	local char = CharacterDatabase[index]
    	char.frozen = true
    	print(char.name .. " ist jetzt eingefroren.")
    	updateMainFrame(scrollFrame, index)
    	frame.unfreezeButton:Enable()
	end)

	local unfreezeButton = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
	unfreezeButton:SetSize(120, 40)
	unfreezeButton:SetPoint("TOPRIGHT", freezeButton, "BOTTOMRIGHT", 0, -10)
	unfreezeButton:SetText("Auftauen")
	unfreezeButton:Disable()
	unfreezeButton:SetScript("OnClick", function()
    	if not selectedCharacter then return end
    	local index = tonumber(selectedCharacter.indexText:GetText())
    	local char = CharacterDatabase[index]
    	char.frozen = false
    	print(char.name .. " ist nicht mehr eingefroren.")
    	updateMainFrame(scrollFrame, index)
    	frame.unfreezeButton:Disable()
	end)

	frame.editButton = editButton
	frame.deleteButton = deleteButton
	frame.upButton = upButton
	frame.downButton = downButton
	frame.suicideButton = suicideButton
	frame.kingButton = kingButton
	frame.freezeButton = freezeButton
	frame.unfreezeButton = unfreezeButton

	frame:SetFrameStrata("HIGH")

	return frame
end

local CLASS_TRANSLATION = {
	["Magier"] = "MAGE",
	["Druide"] = "DRUID",
	["Hexenmeister"] = "WARLOCK",
	["Jäger"] = "HUNTER",
	["Priester"] = "PRIEST",
	["Schamane"] = "SHAMAN",
	["Todesritter"] = "DEATHKNIGHT",
	["Paladin"] = "PALADIN",
	["Krieger"] = "WARRIOR",
	["Schurke"] = "ROGUE",
}

local mainFrame = createMainFrame()
mainFrame:Hide()

SLASH_CHARACTERDATABASE1 = "/chardb"
SlashCmdList["CHARACTERDATABASE"] = function()
	if mainFrame:IsShown() then
    	mainFrame:Hide()
	else
    	updateMainFrame(mainFrame)
    	mainFrame:Show()
	end
end
