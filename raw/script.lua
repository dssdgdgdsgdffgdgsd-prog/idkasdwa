-- UI Library
local UILib = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Main UI Creation Function
function UILib:CreateWindow(options)
    options = options or {}
    local window = {
        Name = options.Name or "UI Library",
        Version = options.Version or "V1.0.0",
        ThemeColor = options.ThemeColor or Color3.fromRGB(127, 62, 255)
    }
    
    -- Create main GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UILib"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainContainer"
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.Parent = screenGui
    
    -- Add UI corners and strokes
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = window.ThemeColor
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame
    
    -- Top bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.Parent = mainFrame
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 4)
    topBarCorner.Parent = topBar
    
    local topBarStroke = Instance.new("UIStroke")
    topBarStroke.Color = window.ThemeColor
    topBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    topBarStroke.Parent = topBar
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = window.Name
    title.TextColor3 = window.ThemeColor
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Font = Enum.Font.Nunito
    title.TextSize = 14
    title.Parent = topBar
    
    -- Version
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Text = window.Version
    version.TextColor3 = Color3.fromRGB(72, 72, 72)
    version.BackgroundTransparency = 1
    version.Size = UDim2.new(0, 50, 1, 0)
    version.Position = UDim2.new(1, -60, 0, 0)
    version.Font = Enum.Font.Nunito
    version.TextSize = 12
    version.Parent = topBar
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Parent = topBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeBtn
    
    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 4)
    contentCorner.Parent = contentFrame
    
    -- Tab container
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Name = "TabsContainer"
    tabsContainer.BackgroundTransparency = 1
    tabsContainer.Size = UDim2.new(1, 0, 1, 0)
    tabsContainer.Parent = contentFrame
    
    -- Drag functionality
    local function dragify(frame)
        local dragToggle = nil
        local dragSpeed = 0.25
        local dragInput = nil
        local dragStart = nil
        local startPos = nil
        
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
            TweenService:Create(frame, TweenInfo.new(0.20), {Position = position}):Play()
        end
        
        frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragToggle = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        
        frame.InputChanged:Connect(function(input)
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
    
    dragify(mainFrame)
    
    -- Close button functionality
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Window methods
    function window:CreateTab(name)
        local tab = {
            Name = name,
            Elements = {}
        }
        
        -- Create tab button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Text = name
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Size = UDim2.new(0, 80, 0, 25)
        tabButton.Position = UDim2.new(0, (#window.Tabs or 0) * 85, 0, 5)
        tabButton.Parent = topBar
        
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 4)
        tabButtonCorner.Parent = tabButton
        
        -- Create tab content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name .. "Content"
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 3
        tabContent.ScrollBarImageColor3 = window.ThemeColor
        tabContent.Visible = false
        tabContent.Parent = tabsContainer
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabContent
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        padding.Parent = tabContent
        
        -- Tab selection logic
        tabButton.MouseButton1Click:Connect(function()
            for _, otherTab in pairs(tabsContainer:GetChildren()) do
                if otherTab:IsA("ScrollingFrame") then
                    otherTab.Visible = false
                end
            end
            tabContent.Visible = true
        end)
        
        -- Show first tab by default
        if not window.Tabs or #window.Tabs == 0 then
            tabContent.Visible = true
        end
        
        -- Tab methods
        function tab:CreateButton(options)
            options = options or {}
            local button = {
                Name = options.Name or "Button",
                Callback = options.Callback or function() end
            }
            
            local buttonFrame = Instance.new("TextButton")
            buttonFrame.Name = options.Name or "Button"
            buttonFrame.Text = "  " .. (options.Name or "Button")
            buttonFrame.TextXAlignment = Enum.TextXAlignment.Left
            buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            buttonFrame.BackgroundTransparency = 0.85
            buttonFrame.Size = UDim2.new(1, -20, 0, 35)
            buttonFrame.Parent = tabContent
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = buttonFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = window.ThemeColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = buttonFrame
            
            buttonFrame.MouseButton1Click:Connect(function()
                button.Callback()
            end)
            
            table.insert(tab.Elements, button)
            return button
        end
        
        function tab:CreateToggle(options)
            options = options or {}
            local toggle = {
                Name = options.Name or "Toggle",
                Default = options.Default or false,
                Callback = options.Callback or function() end,
                Value = options.Default or false
            }
            
            local toggleFrame = Instance.new("TextButton")
            toggleFrame.Name = options.Name or "Toggle"
            toggleFrame.Text = "  " .. (options.Name or "Toggle") .. ":"
            toggleFrame.TextXAlignment = Enum.TextXAlignment.Left
            toggleFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            toggleFrame.BackgroundTransparency = 0.85
            toggleFrame.Size = UDim2.new(1, -20, 0, 35)
            toggleFrame.Parent = tabContent
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = toggleFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = window.ThemeColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = toggleFrame
            
            -- Toggle switch
            local switchFrame = Instance.new("Frame")
            switchFrame.BackgroundTransparency = 1
            switchFrame.Size = UDim2.new(1, 0, 1, 0)
            switchFrame.Parent = toggleFrame
            
            local interactBtn = Instance.new("TextButton")
            interactBtn.Name = "interact"
            interactBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            interactBtn.Size = UDim2.new(0, 49, 0, 26)
            interactBtn.Position = UDim2.new(1, -59, 0.5, -13)
            interactBtn.Text = ""
            interactBtn.Parent = switchFrame
            
            local interactCorner = Instance.new("UICorner")
            interactCorner.CornerRadius = UDim.new(0, 17)
            interactCorner.Parent = interactBtn
            
            local movingPart = Instance.new("Frame")
            movingPart.Name = "MovingPart"
            movingPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            movingPart.Size = UDim2.new(0.2, 0, 0.6, 0)
            movingPart.Position = UDim2.new(0.1, 0, 0.2, 0)
            movingPart.Parent = interactBtn
            
            local movingCorner = Instance.new("UICorner")
            movingCorner.CornerRadius = UDim.new(0, 17)
            movingCorner.Parent = movingPart
            
            local function updateToggle()
                if toggle.Value then
                    movingPart:TweenPosition(UDim2.new(0.7, 0, 0.2, 0), "Out", "Quad", 0.2, true)
                    interactBtn.BackgroundColor3 = window.ThemeColor
                else
                    movingPart:TweenPosition(UDim2.new(0.1, 0, 0.2, 0), "Out", "Quad", 0.2, true)
                    interactBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                end
                toggle.Callback(toggle.Value)
            end
            
            interactBtn.MouseButton1Click:Connect(function()
                toggle.Value = not toggle.Value
                updateToggle()
            end)
            
            -- Initialize
            updateToggle()
            
            table.insert(tab.Elements, toggle)
            return toggle
        end
        
        function tab:CreateSlider(options)
            options = options or {}
            local slider = {
                Name = options.Name or "Slider",
                Min = options.Min or 0,
                Max = options.Max or 100,
                Default = options.Default or 50,
                Callback = options.Callback or function() end,
                Value = options.Default or 50
            }
            
            local sliderFrame = Instance.new("TextButton")
            sliderFrame.Name = options.Name or "Slider"
            sliderFrame.Text = "  " .. (options.Name or "Slider") .. ":"
            sliderFrame.TextXAlignment = Enum.TextXAlignment.Left
            sliderFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            sliderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            sliderFrame.BackgroundTransparency = 0.85
            sliderFrame.Size = UDim2.new(1, -20, 0, 50)
            sliderFrame.Parent = tabContent
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = sliderFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = window.ThemeColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = sliderFrame
            
            -- Slider components
            local trackFrame = Instance.new("Frame")
            trackFrame.Name = "SliderTrack"
            trackFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            trackFrame.Size = UDim2.new(0, 150, 0, 10)
            trackFrame.Position = UDim2.new(1, -170, 0.5, -5)
            trackFrame.Parent = sliderFrame
            
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(1, 0)
            trackCorner.Parent = trackFrame
            
            local fillFrame = Instance.new("Frame")
            fillFrame.Name = "Fill"
            fillFrame.BackgroundColor3 = window.ThemeColor
            fillFrame.Size = UDim2.new(0, 0, 1, 0)
            fillFrame.Parent = trackFrame
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(1, 0)
            fillCorner.Parent = fillFrame
            
            local valueBox = Instance.new("TextBox")
            valueBox.BackgroundColor3 = window.ThemeColor
            valueBox.TextColor3 = Color3.fromRGB(0, 0, 0)
            valueBox.Size = UDim2.new(0, 40, 0, 20)
            valueBox.Position = UDim2.new(1, -220, 0.5, -10)
            valueBox.Text = tostring(slider.Value)
            valueBox.Parent = sliderFrame
            
            local valueCorner = Instance.new("UICorner")
            valueCorner.CornerRadius = UDim.new(0, 4)
            valueCorner.Parent = valueBox
            
            local function updateSlider(value)
                value = math.clamp(value, slider.Min, slider.Max)
                slider.Value = value
                local percentage = (value - slider.Min) / (slider.Max - slider.Min)
                fillFrame.Size = UDim2.new(percentage, 0, 1, 0)
                valueBox.Text = string.format("%.1f", value)
                slider.Callback(value)
            end
            
            -- Mouse interaction
            local isDragging = false
            
            local function updateFromMouse()
                if not isDragging then return end
                
                local mouse = UserInputService:GetMouseLocation()
                local trackAbsolutePos = trackFrame.AbsolutePosition
                local trackAbsoluteSize = trackFrame.AbsoluteSize
                
                local relativeX = (mouse.X - trackAbsolutePos.X) / trackAbsoluteSize.X
                relativeX = math.clamp(relativeX, 0, 1)
                
                local value = slider.Min + (relativeX * (slider.Max - slider.Min))
                updateSlider(value)
            end
            
            trackFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    updateFromMouse()
                end
            end)
            
            trackFrame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateFromMouse()
                end
            end)
            
            valueBox.FocusLost:Connect(function()
                local num = tonumber(valueBox.Text)
                if num then
                    updateSlider(num)
                else
                    valueBox.Text = string.format("%.1f", slider.Value)
                end
            end)
            
            -- Initialize
            updateSlider(slider.Default)
            
            table.insert(tab.Elements, slider)
            return slider
        end
        
        function tab:CreateLabel(options)
            options = options or {}
            local label = {
                Name = options.Name or "Label",
                Text = options.Text or "Label"
            }
            
            local labelFrame = Instance.new("TextButton")
            labelFrame.Name = options.Name or "Label"
            labelFrame.Text = "  " .. (options.Text or "Label")
            labelFrame.TextXAlignment = Enum.TextXAlignment.Left
            labelFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            labelFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            labelFrame.BackgroundTransparency = 0.85
            labelFrame.Size = UDim2.new(1, -20, 0, 35)
            labelFrame.Parent = tabContent
            labelFrame.AutoButtonColor = false
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = labelFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = window.ThemeColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = labelFrame
            
            function label:SetText(newText)
                labelFrame.Text = "  " .. newText
                label.Text = newText
            end
            
            table.insert(tab.Elements, label)
            return label
        end
        
        function tab:CreateTextBox(options)
            options = options or {}
            local textbox = {
                Name = options.Name or "TextBox",
                Placeholder = options.Placeholder or "Enter text...",
                Callback = options.Callback or function() end,
                Text = ""
            }
            
            local textboxFrame = Instance.new("TextButton")
            textboxFrame.Name = options.Name or "TextBox"
            textboxFrame.Text = "  " .. (options.Name or "TextBox") .. ":"
            textboxFrame.TextXAlignment = Enum.TextXAlignment.Left
            textboxFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
            textboxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            textboxFrame.BackgroundTransparency = 0.85
            textboxFrame.Size = UDim2.new(1, -20, 0, 35)
            textboxFrame.Parent = tabContent
            textboxFrame.AutoButtonColor = false
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = textboxFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = window.ThemeColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = textboxFrame
            
            local inputBox = Instance.new("TextBox")
            inputBox.BackgroundColor3 = window.ThemeColor
            inputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
            inputBox.Size = UDim2.new(0, 100, 0, 25)
            inputBox.Position = UDim2.new(1, -110, 0.5, -12.5)
            inputBox.PlaceholderText = options.Placeholder or "Enter text..."
            inputBox.Parent = textboxFrame
            
            local inputCorner = Instance.new("UICorner")
            inputCorner.CornerRadius = UDim.new(0, 4)
            inputCorner.Parent = inputBox
            
            inputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    textbox.Text = inputBox.Text
                    textbox.Callback(inputBox.Text)
                end
            end)
            
            table.insert(tab.Elements, textbox)
            return textbox
        end
        
        if not window.Tabs then window.Tabs = {} end
        table.insert(window.Tabs, tab)
        return tab
    end
    
    return window
end

return UILib
