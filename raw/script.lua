-- ModuleScript: UILibrary
local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create the main UI
function UILibrary.CreateUI(title, version)
    local G2L = {}

    -- ScreenGui
    G2L["ScreenGui"] = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    G2L["ScreenGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- TopBar
    G2L["TopBar"] = Instance.new("Frame", G2L["ScreenGui"])
    G2L["TopBar"].BorderSizePixel = 0
    G2L["TopBar"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    G2L["TopBar"].Size = UDim2.new(0, 464, 0, 37)
    G2L["TopBar"].Position = UDim2.new(0.34347, 0, 0.23441, 0)
    G2L["TopBar"].Name = "TopBar"
    Instance.new("UICorner", G2L["TopBar"]).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", G2L["TopBar"]).ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    G2L["TopBar"]:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(127, 62, 255)

    -- Title
    G2L["Title"] = Instance.new("TextLabel", G2L["TopBar"])
    G2L["Title"].TextWrapped = true
    G2L["Title"].BorderSizePixel = 0
    G2L["Title"].TextSize = 14
    G2L["Title"].TextScaled = true
    G2L["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Title"].FontFace = Font.new("rbxasset://fonts/families/Nunito.json")
    G2L["Title"].TextColor3 = Color3.fromRGB(127, 62, 255)
    G2L["Title"].BackgroundTransparency = 1
    G2L["Title"].Size = UDim2.new(0, 134, 0, 37)
    G2L["Title"].Text = title or "Title"
    G2L["Title"].Name = "Title"
    G2L["Title"].Position = UDim2.new(0.35345, 0, 0, 0)

    -- Version
    G2L["Version"] = Instance.new("TextLabel", G2L["TopBar"])
    G2L["Version"].TextWrapped = true
    G2L["Version"].BorderSizePixel = 0
    G2L["Version"].TextSize = 14
    G2L["Version"].TextScaled = true
    G2L["Version"].BackgroundColor3 = Color3.fromRGB(87, 87, 87)
    G2L["Version"].FontFace = Font.new("rbxasset://fonts/families/Nunito.json")
    G2L["Version"].TextColor3 = Color3.fromRGB(72, 72, 72)
    G2L["Version"].BackgroundTransparency = 1
    G2L["Version"].Size = UDim2.new(0, 45, 0, 18)
    G2L["Version"].Text = version or "V1.0.0"
    G2L["Version"].Name = "Version"
    G2L["Version"].Position = UDim2.new(0.56466, 0, 0.51285, 0)

    -- CloseButton (Placeholder image since original has an error)
    G2L["CloseButton"] = Instance.new("ImageButton", G2L["TopBar"])
    G2L["CloseButton"].BorderSizePixel = 0
    G2L["CloseButton"].BackgroundTransparency = 1
    G2L["CloseButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["CloseButton"].Image = "rbxassetid://10747384394" -- Replace with a valid asset
    G2L["CloseButton"].Size = UDim2.new(0, 35, 0, 36)
    G2L["CloseButton"].Name = "CloseButton"
    G2L["CloseButton"].Position = UDim2.new(0.92457, 0, 0, 0)
    Instance.new("UICorner", G2L["CloseButton"])

    -- MinimizeButton (Placeholder image)
    G2L["MinimizeButton"] = Instance.new("ImageButton", G2L["TopBar"])
    G2L["MinimizeButton"].BorderSizePixel = 0
    G2L["MinimizeButton"].BackgroundTransparency = 1
    G2L["MinimizeButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["MinimizeButton"].Image = "rbxassetid://10734896206" -- Replace with a valid asset
    G2L["MinimizeButton"].Size = UDim2.new(0, 38, 0, 36)
    G2L["MinimizeButton"].Name = "MinimizeButton"
    G2L["MinimizeButton"].Position = UDim2.new(0.84267, 0, 0, 0)
    Instance.new("UICorner", G2L["MinimizeButton"])

    -- TabFrame
    G2L["TabFrame"] = Instance.new("Frame", G2L["TopBar"])
    G2L["TabFrame"].BorderSizePixel = 0
    G2L["TabFrame"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    G2L["TabFrame"].Size = UDim2.new(0, 548, 0, 371)
    G2L["TabFrame"].Position = UDim2.new(-0.09106, 0, 1.23532, 0)
    G2L["TabFrame"].Name = "TabFrame"
    Instance.new("UICorner", G2L["TabFrame"]).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", G2L["TabFrame"])
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(127, 62, 255)

    -- ScrollingFrame
    G2L["ScrollingFrame"] = Instance.new("ScrollingFrame", G2L["TabFrame"])
    G2L["ScrollingFrame"].Active = true
    G2L["ScrollingFrame"].BorderSizePixel = 0
    G2L["ScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["ScrollingFrame"].Size = UDim2.new(0, 548, 0, 371)
    G2L["ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(148, 242, 255)
    G2L["ScrollingFrame"].ScrollBarThickness = 3
    G2L["ScrollingFrame"].BackgroundTransparency = 1
    local listLayout = Instance.new("UIListLayout", G2L["ScrollingFrame"])
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Padding = UDim.new(0, 10)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", G2L["ScrollingFrame"]).PaddingTop = UDim.new(0, 10)

    -- Dragify Script
    local function dragify(Frame)
        local dragToggle, dragSpeed, dragInput, dragStart, startPos
        dragSpeed = 0.25
        local function updateInput(input)
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            TweenService:Create(Frame, TweenInfo.new(0.20, Enum.EasingStyle.Back), {Position = Position}):Play()
        end
        Frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragToggle then
                updateInput(input)
            end
        end)
    end
    dragify(G2L["TopBar"])

    -- Profile Picture
    G2L["pfp"] = Instance.new("ImageLabel", G2L["TabFrame"])
    G2L["pfp"].BorderSizePixel = 0
    G2L["pfp"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["pfp"].Size = UDim2.new(0, 35, 0, 35)
    G2L["pfp"].BackgroundTransparency = 1
    G2L["pfp"].Name = "pfp"
    G2L["pfp"].Position = UDim2.new(0.01299, 0, 0.88554, 0)
    Instance.new("UICorner", G2L["pfp"]).CornerRadius = UDim.new(1, 0)
    local pfpStroke = Instance.new("UIStroke", G2L["pfp"])
    pfpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    pfpStroke.Thickness = 0.7
    pfpStroke.Color = Color3.fromRGB(127, 62, 255)

    local function setProfilePicture()
        local success, thumbUrl = pcall(function()
            return Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        G2L["pfp"].Image = success and thumbUrl or "rbxasset://textures/ui/avatar.png"
    end
    setProfilePicture()
    Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setProfilePicture()
    end)

    -- Display Name
    G2L["DisplayName"] = Instance.new("TextLabel", G2L["TabFrame"])
    G2L["DisplayName"].BorderSizePixel = 0
    G2L["DisplayName"].TextSize = 20
    G2L["DisplayName"].TextXAlignment = Enum.TextXAlignment.Left
    G2L["DisplayName"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["DisplayName"].FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold)
    G2L["DisplayName"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["DisplayName"].BackgroundTransparency = 1
    G2L["DisplayName"].Size = UDim2.new(0, 130, 0, 20)
    G2L["DisplayName"].Text = Players.LocalPlayer.DisplayName
    G2L["DisplayName"].Name = "DisplayName"
    G2L["DisplayName"].Position = UDim2.new(0.08922, 0, 0.8917, 0)
    local dnStroke = Instance.new("UIStroke", G2L["DisplayName"])
    dnStroke.Thickness = 0.3
    dnStroke.Color = Color3.fromRGB(127, 62, 255)

    -- Username
    G2L["Username"] = Instance.new("TextLabel", G2L["TabFrame"])
    G2L["Username"].BorderSizePixel = 0
    G2L["Username"].TextSize = 16
    G2L["Username"].TextXAlignment = Enum.TextXAlignment.Left
    G2L["Username"].TextTransparency = 0.52
    G2L["Username"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Username"].FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold)
    G2L["Username"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Username"].BackgroundTransparency = 1
    G2L["Username"].Size = UDim2.new(0, 130, 0, 20)
    G2L["Username"].Text = "@" .. Players.LocalPlayer.Name
    G2L["Username"].Name = "Username"
    G2L["Username"].Position = UDim2.new(0.08922, 0, 0.94406, 0)
    local unStroke = Instance.new("UIStroke", G2L["Username"])
    unStroke.Thickness = 0.3
    unStroke.Color = Color3.fromRGB(127, 62, 255)

    -- TabsFrame
    G2L["TabsFrame"] = Instance.new("Frame", G2L["TopBar"])
    G2L["TabsFrame"].BorderSizePixel = 0
    G2L["TabsFrame"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    G2L["TabsFrame"].Size = UDim2.new(0, 38, 0, 331)
    G2L["TabsFrame"].Position = UDim2.new(-0.18823, 0, 1.77146, 0)
    G2L["TabsFrame"].Name = "TabsFrame"
    Instance.new("UICorner", G2L["TabsFrame"]).CornerRadius = UDim.new(0, 4)
    local tabsStroke = Instance.new("UIStroke", G2L["TabsFrame"])
    tabsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tabsStroke.Color = Color3.fromRGB(127, 62, 255)

    G2L["TabsScrollingFrame"] = Instance.new("ScrollingFrame", G2L["TabsFrame"])
    G2L["TabsScrollingFrame"].Active = true
    G2L["TabsScrollingFrame"].BorderSizePixel = 0
    G2L["TabsScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["TabsScrollingFrame"].Size = UDim2.new(0, 38, 0, 331)
    G2L["TabsScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(148, 242, 255)
    G2L["TabsScrollingFrame"].ScrollBarThickness = 0
    G2L["TabsScrollingFrame"].BackgroundTransparency = 1
    local tabsListLayout = Instance.new("UIListLayout", G2L["TabsScrollingFrame"])
    tabsListLayout.Padding = UDim.new(0, 10)
    tabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", G2L["TabsScrollingFrame"]).PaddingTop = UDim.new(0, 5)
    Instance.new("UIPadding", G2L["TabsScrollingFrame"]).PaddingLeft = UDim.new(0, 4)

    -- Add a sample tab button
    local tabButton = Instance.new("ImageButton", G2L["TabsScrollingFrame"])
    tabButton.BorderSizePixel = 0
    tabButton.BackgroundTransparency = 1
    tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Image = "rbxassetid://10723407389" -- Replace with a valid asset
    tabButton.Size = UDim2.new(0, 31, 0, 29)
    Instance.new("UICorner", tabButton)

    return G2L
end

-- Add a toggle
function UILibrary.AddToggle(parent, name, callback)
    local toggle = Instance.new("TextButton", parent.ScrollingFrame)
    toggle.BorderSizePixel = 0
    toggle.TextXAlignment = Enum.TextXAlignment.Left
    toggle.TextSize = 24
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggle.FontFace = Font.new("rbxasset://fonts/families/DenkOne.json")
    toggle.BackgroundTransparency = 0.85
    toggle.Size = UDim2.new(0, 528, 0, 35)
    toggle.Text = "  " .. name .. ":"
    toggle.Name = name
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", toggle)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(127, 62, 255)

    local toggleFrame = Instance.new("Frame", toggle)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleFrame.Size = UDim2.new(0, 536, 0, 36)
    toggleFrame.Position = UDim2.new(-0.00423, 0, -0.00904, 0)
    toggleFrame.BackgroundTransparency = 1

    local interact = Instance.new("TextButton", toggleFrame)
    interact.BorderSizePixel = 0
    interact.TextSize = 14
    interact.TextColor3 = Color3.fromRGB(0, 0, 0)
    interact.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    interact.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    interact.Size = UDim2.new(0, 49, 0, 26)
    interact.Position = UDim2.new(0.88627, 0, 0.12078, 0)
    interact.Text = ""
    interact.Name = "interact"
    Instance.new("UICorner", interact).CornerRadius = UDim.new(0, 17)

    local greenFrame = Instance.new("Frame", toggleFrame)
    greenFrame.BorderSizePixel = 0
    greenFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    greenFrame.Size = UDim2.new(0, 49, 0, 26)
    greenFrame.Position = UDim2.new(0.88627, 0, 0.12078, 0)
    greenFrame.Name = "GreenFrame"
    Instance.new("UICorner", greenFrame).CornerRadius = UDim.new(0, 17)

    local movingPart = Instance.new("Frame", toggleFrame)
    movingPart.BorderSizePixel = 0
    movingPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    movingPart.Size = UDim2.new(0.03388, 0, 0.54101, 0)
    movingPart.Position = UDim2.new(0.89427, 0, 0.20378, 0)
    movingPart.Name = "MovingPart"
    Instance.new("UICorner", movingPart).CornerRadius = UDim.new(0, 17)

    local offPos = Instance.new("Frame", toggleFrame)
    offPos.BorderSizePixel = 0
    offPos.BackgroundColor3 = Color3.fromRGB(67, 67, 67)
    offPos.Size = UDim2.new(0.03388, 0, 0.54101, 0)
    offPos.Position = UDim2.new(0.89427, 0, 0.20378, 0)
    offPos.Name = "OffPos"
    offPos.BackgroundTransparency = 1
    Instance.new("UICorner", offPos).CornerRadius = UDim.new(0, 17)

    local onPos = Instance.new("Frame", toggleFrame)
    onPos.BorderSizePixel = 0
    onPos.BackgroundColor3 = Color3.fromRGB(67, 67, 67)
    onPos.Size = UDim2.new(0.03388, 0, 0.54101, 0)
    onPos.Position = UDim2.new(0.93527, 0, 0.20378, 0)
    onPos.Name = "OnPos"
    onPos.BackgroundTransparency = 1
    Instance.new("UICorner", onPos).CornerRadius = UDim.new(0, 17)

    toggleFrame:SetAttribute("isOn", false)

    local hoverSound = Instance.new("Sound", toggle)
    hoverSound.SoundId = "rbxassetid://10066931761"
    hoverSound.Volume = 1

    local clickSound = Instance.new("Sound", toggle)
    clickSound.SoundId = "rbxassetid://876939830"
    clickSound.Volume = 1

    local function updateVisuals(isOn)
        if isOn then
            movingPart:TweenPosition(onPos.Position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            greenFrame.BackgroundColor3 = Color3.fromRGB(126, 61, 255)
        else
            movingPart:TweenPosition(offPos.Position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            greenFrame.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
        end
        if callback then
            callback(isOn)
        end
    end

    toggle.MouseButton1Click:Connect(function()
        clickSound:Play()
        local current = toggleFrame:GetAttribute("isOn")
        toggleFrame:SetAttribute("isOn", not current)
    end)

    interact.MouseButton1Click:Connect(function()
        clickSound:Play()
        local current = toggleFrame:GetAttribute("isOn")
        toggleFrame:SetAttribute("isOn", not current)
    end)

    toggle.MouseEnter:Connect(function()
        hoverSound:Play()
    end)

    toggleFrame:GetAttributeChangedSignal("isOn"):Connect(function()
        updateVisuals(toggleFrame:GetAttribute("isOn"))
    end)

    updateVisuals(toggleFrame:GetAttribute("isOn"))
end

-- Add a slider
function UILibrary.AddSlider(parent, name, minValue, maxValue, callback)
    local slider = Instance.new("TextButton", parent.ScrollingFrame)
    slider.BorderSizePixel = 0
    slider.TextXAlignment = Enum.TextXAlignment.Left
    slider.TextSize = 24
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    slider.FontFace = Font.new("rbxasset://fonts/families/DenkOne.json")
    slider.BackgroundTransparency = 0.85
    slider.Size = UDim2.new(0, 531, 0, 35)
    slider.Text = "  " .. name .. ":"
    slider.Name = name
    Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", slider)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(127, 62, 255)

    local sliderFrame = Instance.new("Frame", slider)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sliderFrame.Size = UDim2.new(0, 531, 0, 35)
    sliderFrame.Position = UDim2.new(-0.00423, 0, 0, 0)
    sliderFrame.BackgroundTransparency = 1

    local sliderTrack = Instance.new("Frame", sliderFrame)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderTrack.Size = UDim2.new(0, 107, 0, 10)
    sliderTrack.Position = UDim2.new(0.78647, 0, 0.33333, 0)
    sliderTrack.Name = "SliderFrame"
    Instance.new("UICorner", sliderTrack)

    local fillFrame = Instance.new("Frame", sliderTrack)
    fillFrame.BorderSizePixel = 0
    fillFrame.BackgroundColor3 = Color3.fromRGB(127, 62, 255)
    fillFrame.Size = UDim2.new(0, 0, 0, 10)
    fillFrame.Position = UDim2.new(-0.00523, 0, 0.03333, 0)
    fillFrame.Name = "FillFrame"
    Instance.new("UICorner", fillFrame)

    local knob = Instance.new("TextButton", sliderTrack)
    knob.BorderSizePixel = 0
    knob.TextSize = 14
    knob.TextColor3 = Color3.fromRGB(0, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    knob.BackgroundTransparency = 1
    knob.Size = UDim2.new(0, 122, 0, 10)
    knob.Position = UDim2.new(-0.08411, 0, 0.03333, 0)
    knob.Text = ""
    Instance.new("UICorner", knob)

    local textBox = Instance.new("TextBox", sliderTrack)
    textBox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
    textBox.BorderSizePixel = 0
    textBox.TextSize = 14
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(127, 62, 255)
    textBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    textBox.PlaceholderText = "0.0"
    textBox.Size = UDim2.new(0, 37, 0, 22)
    textBox.Position = UDim2.new(-0.42991, 0, -0.6, 0)
    textBox.Text = ""
    Instance.new("UICorner", textBox)

    local smoothness = 0.15
    local sliderWidth = sliderTrack.AbsoluteSize.X
    local isDragging = false

    local function getNormalizedValue(xPos)
        local relativeX = xPos - sliderTrack.AbsolutePosition.X
        local clampedX = math.clamp(relativeX, 0, sliderWidth)
        return clampedX / sliderWidth
    end

    local function getMappedValue(normalized)
        return minValue + (maxValue - minValue) * normalized
    end

    local function getNormalizedFromValue(value)
        return (value - minValue) / (maxValue - minValue)
    end

    local function updateVisual(normalized)
        local clamped = math.clamp(normalized, 0, 1)
        local knobX = clamped * sliderWidth - (knob.AbsoluteSize.X / 2)
        local value = getMappedValue(clamped)
        TweenService:Create(fillFrame, TweenInfo.new(smoothness, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(clamped, 0, 1, 0)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(smoothness, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, knobX, 0, 0)
        }):Play()
        textBox.Text = string.format("%.1f", value)
        if callback then
            callback(value)
        end
    end

    local function updateFromInput(inputPosition)
        local normalized = getNormalizedValue(inputPosition.X)
        updateVisual(normalized)
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateFromInput(input.Position)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromInput(input.Position)
        end
    end)

    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local normalized = getNormalizedValue(input.Position.X)
            updateVisual(normalized)
        end
    end)

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local value = tonumber(textBox.Text)
            if value then
                value = math.clamp(value, minValue, maxValue)
                local normalized = getNormalizedFromValue(value)
                updateVisual(normalized)
            else
                local currentValue = getMappedValue(fillFrame.Size.X.Scale)
                textBox.Text = string.format("%.1f", currentValue)
            end
        end
    end)

    updateVisual(getNormalizedFromValue((minValue + maxValue) / 2))
end

-- Add a textbox
function UILibrary.AddTextBox(parent, name, callback)
    local textBoxButton = Instance.new("TextButton", parent.ScrollingFrame)
    textBoxButton.BorderSizePixel = 0
    textBoxButton.TextXAlignment = Enum.TextXAlignment.Left
    textBoxButton.TextSize = 24
    textBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBoxButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textBoxButton.FontFace = Font.new("rbxasset://fonts/families/DenkOne.json")
    textBoxButton.BackgroundTransparency = 0.85
    textBoxButton.Size = UDim2.new(0, 531, 0, 38)
    textBoxButton.Text = "  " .. name .. ":"
    textBoxButton.Name = name
    Instance.new("UICorner", textBoxButton).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", textBoxButton)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(127, 62, 255)

    local frame = Instance.new("Frame", textBoxButton)
    frame.BorderSizePixel = 0
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.Size = UDim2.new(0, 536, 0, 36)
    frame.Position = UDim2.new(-0.00423, 0, -0.00904, 0)
    frame.BackgroundTransparency = 1

    local textBox = Instance.new("TextBox", frame)
    textBox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
    textBox.BorderSizePixel = 0
    textBox.TextWrapped = true
    textBox.TextSize = 14
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    textBox.TextScaled = true
    textBox.BackgroundColor3 = Color3.fromRGB(127, 62, 255)
    textBox.FontFace = Font.new("rbxasset://fonts/families/Nunito.json")
    textBox.PlaceholderText = "Enter text"
    textBox.Size = UDim2.new(0, 86, 0, 26)
    textBox.Position = UDim2.new(0.81903, 0, 0.17546, 0)
    textBox.Text = ""
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 4)

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(textBox.Text)
        end
    end)
end

-- Add a dropdown
function UILibrary.AddDropDown(parent, name, options, callback)
    local button = Instance.new("TextButton", parent.ScrollingFrame)
    button.BorderSizePixel = 0
    button.TextSize = 24
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.FontFace = Font.new("rbxasset://fonts/families/DenkOne.json")
    button.BackgroundTransparency = 0.85
    button.Size = UDim2.new(0, 532, 0, 35)
    button.Text = name .. " (Nothing)"
    button.Name = name
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", button)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(127, 62, 255)

    local dropdownFrame = Instance.new("Frame", button)
    dropdownFrame.Visible = false
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
    dropdownFrame.Size = UDim2.new(0, 531, 0, 102)
    dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
    dropdownFrame.BackgroundTransparency = 0.5
    dropdownFrame.Name = "DropDownFrame"
    dropdownFrame.ClipsDescendants = true
    Instance.new("UICorner", dropdownFrame).CornerRadius = UDim.new(0, 4)
    local ddStroke = Instance.new("UIStroke", dropdownFrame)
    ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ddStroke.Color = Color3.fromRGB(127, 62, 255)
    ddStroke.Transparency = 1

    local scrollingFrame = Instance.new("ScrollingFrame", dropdownFrame)
    scrollingFrame.Active = true
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(87, 87, 87)
    scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.XY
    scrollingFrame.Size = UDim2.new(0, 532, 0, 181)
    scrollingFrame.Position = UDim2.new(0, 0, 0.05263, 0)
    scrollingFrame.ScrollBarThickness = 0
    scrollingFrame.BackgroundTransparency = 1
    local uiList = Instance.new("UIListLayout", scrollingFrame)
    uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiList.Padding = UDim.new(0, 2)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", scrollingFrame).PaddingTop = UDim.new(0, 5)
    Instance.new("UIPadding", scrollingFrame).PaddingBottom = UDim.new(0, 5)

    local tweenTime = 0.3
    local smoothEasing = Enum.EasingStyle.Quad
    local maxDropdownHeight = 220
    local closedSize = UDim2.new(1, 0, 0, 0)
    local isOpen = false
    local selectedOption = nil
    local templateBg = Color3.fromRGB(0, 0, 0)

    local function tweenProperty(obj, info, goal)
        TweenService:Create(obj, info, goal):Play()
    end

    local function tweenDropdown(open)
        local contentHeight = uiList.AbsoluteContentSize.Y
        local visibleHeight = math.min(contentHeight, maxDropdownHeight)
        local targetSize = open and UDim2.new(1, 0, 0, visibleHeight) or closedSize
        tweenProperty(ddStroke, TweenInfo.new(0.2), {Transparency = open and 0 or 1})
        tweenProperty(dropdownFrame, TweenInfo.new(tweenTime, smoothEasing, Enum.EasingDirection.Out), {Size = targetSize})
        for _, child in ipairs(scrollingFrame:GetChildren()) do
            if child:IsA("TextButton") then
                if open then
                    child.Visible = true
                    child.BackgroundTransparency = 1
                    child.TextTransparency = 1
                    child.Position = UDim2.new(0, 0, 0, child.Position.Y.Offset + 6)
                    tweenProperty(child, TweenInfo.new(0.25, smoothEasing), {
                        BackgroundTransparency = 0,
                        TextTransparency = 0,
                        Position = UDim2.new(0, 0, 0, child.Position.Y.Offset)
                    })
                else
                    tweenProperty(child, TweenInfo.new(0.2, smoothEasing), {
                        BackgroundTransparency = 1,
                        TextTransparency = 1
                    })
                    task.delay(0.25, function()
                        if not isOpen then
                            child.Visible = false
                        end
                    end)
                end
            end
        end
    end

    local function applyHoverEffect(btn)
        btn.MouseEnter:Connect(function()
            tweenProperty(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(230, 230, 230)})
        end)
        btn.MouseLeave:Connect(function()
            local targetColor = (btn == selectedOption) and Color3.fromRGB(255, 255, 255) or templateBg
            tweenProperty(btn, TweenInfo.new(0.15), {BackgroundColor3 = targetColor})
        end)
    end

    local function updateSelection(chosen)
        selectedOption = chosen
        for _, child in ipairs(scrollingFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = (child == chosen) and Color3.fromRGB(255, 255, 255) or templateBg
                child.TextColor3 = (child == chosen) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
            end
        end
        button.Text = chosen.Text
        isOpen = false
        tweenDropdown(false)
        if callback then
            callback(chosen.Text)
        end
    end

    local function addOption(optName)
        local clone = Instance.new("TextButton", scrollingFrame)
        clone.BorderSizePixel = 0
        clone.TextSize = 24
        clone.TextColor3 = Color3.fromRGB(255, 255, 255)
        clone.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        clone.FontFace = Font.new("rbxasset://fonts/families/DenkOne.json")
        clone.BackgroundTransparency = 0.85
        clone.Size = UDim2.new(0, 524, 0, 36)
        clone.Text = optName
        clone.Name = optName
        clone.Visible = false
        clone.AutoButtonColor = false
        Instance.new("UICorner", clone).CornerRadius = UDim.new(0, 4)
        local optStroke = Instance.new("UIStroke", clone)
        optStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        optStroke.Color = Color3.fromRGB(127, 62, 255)

        applyHoverEffect(clone)
        clone.MouseButton1Click:Connect(function()
            updateSelection(clone)
        end)
    end

    for _, opt in ipairs(options) do
        addOption(opt)
    end

    uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize.Y)
        if isOpen then
            tweenDropdown(true)
        end
    end)

    button.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        tweenDropdown(isOpen)
    end)

    local hoverSound = Instance.new("Sound", button)
    hoverSound.SoundId = "rbxassetid://10066931761"
    hoverSound.Volume = 1

    local clickSound = Instance.new("Sound", button)
    clickSound.SoundId = "rbxassetid://876939830"
    clickSound.Volume = 1

    button.MouseEnter:Connect(function()
        hoverSound:Play()
    end)

    button.MouseButton1Click:Connect(function()
        clickSound:Play()
    end)
end

return UILibrary
