-- Khai báo các dịch vụ
local UserInputService = game:GetService("UserInputService")

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DraggableButtonGUI"
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1, 0, 1, 0) -- Khung chiếm toàn bộ màn hình
Frame.BackgroundTransparency = 1 -- Không có nền khung
Frame.Parent = ScreenGui

-- Khung bao quanh nút
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(0, 50, 0, 50) -- Kích thước của khung bao quanh
ButtonFrame.Position = UDim2.new(0, 120, 0, 0) -- Đặt khung cách bên trái 120 pixels
ButtonFrame.BackgroundTransparency = 1 -- Trong suốt để thấy viền bên ngoài
ButtonFrame.Parent = Frame

-- Viền tròn màu vàng
local BorderFrame = Instance.new("Frame")
BorderFrame.Size = UDim2.new(1, 0, 1, 0) -- Kích thước bằng với ButtonFrame
BorderFrame.Position = UDim2.new(0, 0, 0, 0) -- Căn viền vào khung
BorderFrame.BackgroundTransparency = 1 -- Trong suốt
BorderFrame.BorderSizePixel = 4 -- Kích thước viền
BorderFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- Màu viền vàng
BorderFrame.Parent = ButtonFrame

-- Thêm UICorner để làm góc tròn cho viền
local UICornerBorder = Instance.new("UICorner")
UICornerBorder.CornerRadius = UDim.new(0.5, 0) -- Góc tròn hoàn toàn
UICornerBorder.Parent = BorderFrame

-- Nút
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40) -- Kích thước nút
ToggleButton.Position = UDim2.new(0.5, -20, 0.5, -20) -- Căn giữa nút trong ButtonFrame
ToggleButton.Image = "rbxassetid://18832975581" -- Đặt ID hình ảnh
ToggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0 -- Không có viền nút
ToggleButton.Parent = ButtonFrame

-- Thêm UICorner để làm góc tròn cho nút
local UICornerButton = Instance.new("UICorner")
UICornerButton.CornerRadius = UDim.new(0.2, 0) -- Góc tròn vừa phải hơn
UICornerButton.Parent = ToggleButton

-- Biến để theo dõi trạng thái kéo thả
local dragging = false
local dragStart, startPos

-- Hàm bắt đầu kéo thả
local function onDragStart(input)
    dragging = true
    dragStart = input.Position
    startPos = ButtonFrame.Position
end

-- Hàm kéo thả
local function onDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        
        -- Thay đổi vị trí khung bao quanh và viền
        ButtonFrame.Position = newPos
    end
end

-- Hàm kết thúc kéo thả
local function onDragEnd()
    dragging = false
end

-- Kết nối các sự kiện
ToggleButton.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        onDragStart(input)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        onDrag(input)
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        onDragEnd()
    end
end)
