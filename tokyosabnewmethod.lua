local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- GUI inject notification
StarterGui:SetCore("SendNotification", {
    Title = "Key System",
    Text = "GUI Loaded – New Method Loaded",
    Duration = 5,
    Icon = ""
})

-- GUI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local getKeyButton = Instance.new("TextButton")
local checkKeyButton = Instance.new("TextButton")
local messageLabel = Instance.new("TextLabel")

screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "KeySystemGUI"

frame.Parent = screenGui
frame.Size = UDim2.new(0.4, 0, 0.4, 0)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Başlık
title.Parent = frame
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🔐 Get key to continue"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Mesaj etiketi
messageLabel.Parent = frame
messageLabel.Size = UDim2.new(1, -20, 0.2, 0)
messageLabel.Position = UDim2.new(0, 10, 0.7, 0)
messageLabel.Text = "" -- Başlangıçta boş
messageLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
messageLabel.BackgroundTransparency = 1
messageLabel.Font = Enum.Font.Gotham
messageLabel.TextScaled = true
messageLabel.TextWrapped = true

-- Get Key Button
getKeyButton.Parent = frame
getKeyButton.Size = UDim2.new(0.4, 0, 0.15, 0)
getKeyButton.Position = UDim2.new(0.1, 0, 0.4, 0)
getKeyButton.Text = "🔑 Get Key"
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
getKeyButton.TextColor3 = Color3.new(1, 1, 1)
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextScaled = true
local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 6)
getCorner.Parent = getKeyButton

-- Check Key Button
checkKeyButton.Parent = frame
checkKeyButton.Size = UDim2.new(0.4, 0, 0.15, 0)
checkKeyButton.Position = UDim2.new(0.5, 0, 0.4, 0)
checkKeyButton.Text = "✅ Check Key"
checkKeyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
checkKeyButton.TextColor3 = Color3.new(1, 1, 1)
checkKeyButton.Font = Enum.Font.GothamBold
checkKeyButton.TextScaled = true
local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 6)
checkCorner.Parent = checkKeyButton

-- Key giriş kutusu
local keyBox = Instance.new("TextBox")
keyBox.Parent = frame
keyBox.Size = UDim2.new(0.8, 0, 0.15, 0)
keyBox.Position = UDim2.new(0.1, 0, 0.6, 0)
keyBox.PlaceholderText = "Put the key here..."
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextScaled = true
keyBox.ClearTextOnFocus = false

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 6)
keyCorner.Parent = keyBox

-- Get Key Button işlevi
getKeyButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        setclipboard("https://tokyosab.lovable.app/")
    end)
    if success then
        messageLabel.Text = "Link Copyed! Go the website ans get the key!✅"
        messageLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Yeşil
    else
        messageLabel.Text = "Cant copy on the board❌. please write and copy.https://tokyosab.lovable.app/"
        messageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Check Key Button işlevi (boş veya her zaman wrong)
checkKeyButton.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text
    
    if enteredKey == "" then
        messageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(0.5)
        messageLabel.Text = "❌ Invalid key"
    else
        messageLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        messageLabel.Text = "🔄 Checking key..."
        task.wait(2.5)
        messageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        messageLabel.Text = "❌ Wrong key!"
    end
end)

-- Arka plan animasyonu
task.spawn(function()
    local colors = {
        Color3.fromRGB(20, 20, 20),
        Color3.fromRGB(30, 30, 50),
        Color3.fromRGB(40, 20, 40)
    }
    local index = 1
    while true do
        local nextIndex = index + 1
        if nextIndex > #colors then nextIndex = 1 end
        local tween = TweenService:Create(frame, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundColor3 = colors[nextIndex]})
        tween:Play()
        tween.Completed:Wait()
        index = nextIndex
    end
end)

-- Mobil ve PC sürükleme
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)