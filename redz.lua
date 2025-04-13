local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Themes = {
	Dark = {
		AcrylicBlur = Color3.fromRGB(30, 30, 30),
		AcrylicNoise = Color3.fromRGB(40, 40, 40),
		TitleBar = Color3.fromRGB(25, 25, 25),
		TabBar = Color3.fromRGB(35, 35, 35),
		Tab = Color3.fromRGB(45, 45, 45),
		TabHover = Color3.fromRGB(55, 55, 55),
		TabSelected = Color3.fromRGB(60, 60, 60),
		TabText = Color3.fromRGB(200, 200, 200),
		TabIcon = Color3.fromRGB(180, 180, 180),
		Section = Color3.fromRGB(50, 50, 50),
		SectionText = Color3.fromRGB(220, 220, 220),
		Control = Color3.fromRGB(60, 60, 60),
		ControlHover = Color3.fromRGB(70, 70, 70),
		ControlActive = Color3.fromRGB(80, 80, 80),
		ControlText = Color3.fromRGB(200, 200, 200),
		ControlStroke = Color3.fromRGB(90, 90, 90),
		Dialog = Color3.fromRGB(40, 40, 40),
		DialogText = Color3.fromRGB(220, 220, 220),
		DialogButton = Color3.fromRGB(60, 60, 60),
		DialogButtonHover = Color3.fromRGB(70, 70, 70),
		DialogButtonActive = Color3.fromRGB(80, 80, 80),
		DialogButtonText = Color3.fromRGB(200, 200, 200),
	}
}

function Library:MakeWindow(Settings)
	local Window = {
		Tabs = {},
		Flags = {},
		Save = Settings.Save or {
			UISize = {600, 450},
			TabSize = 180,
			Theme = "Dark"
		}
	}
	local MainFrame = Instance.new("ScreenGui")
	MainFrame.Name = HttpService:GenerateGUID(false)
	MainFrame.Parent = CoreGui
	MainFrame.IgnoreGuiInset = true
	local AcrylicFrame = Instance.new("Frame")
	AcrylicFrame.Size = UDim2.new(0, Window.Save.UISize[1], 0, Window.Save.UISize[2])
	AcrylicFrame.Position = UDim2.new(0.5, -Window.Save.UISize[1]/2, 0.5, -Window.Save.UISize[2]/2)
	AcrylicFrame.BackgroundColor3 = Themes[Window.Save.Theme].AcrylicBlur
	AcrylicFrame.BackgroundTransparency = 0.3
	AcrylicFrame.BorderSizePixel = 0
	AcrylicFrame.Parent = MainFrame
	local NoiseFrame = Instance.new("ImageLabel")
	NoiseFrame.Size = UDim2.new(1, 0, 1, 0)
	NoiseFrame.Image = "rbxassetid://9125573726"
	NoiseFrame.ImageColor3 = Themes[Window.Save.Theme].AcrylicNoise
	NoiseFrame.ImageTransparency = 0.95
	NoiseFrame.BackgroundTransparency = 1
	NoiseFrame.Parent = AcrylicFrame
	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1
	Stroke.Color = Themes[Window.Save.Theme].ControlStroke
	Stroke.Parent = AcrylicFrame
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = AcrylicFrame
	local TitleBar = Instance.new("Frame")
	TitleBar.Size = UDim2.new(1, 0, 0, 40)
	TitleBar.BackgroundColor3 = Themes[Window.Save.Theme].TitleBar
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = AcrylicFrame
	local TitleText = Instance.new("TextLabel")
	TitleText.Size = UDim2.new(0.5, 0, 1, 0)
	TitleText.Position = UDim2.new(0, 10, 0, 0)
	TitleText.BackgroundTransparency = 1
	TitleText.Text = Settings.Title or "RedzLib"
	TitleText.TextColor3 = Themes[Window.Save.Theme].ControlText
	TitleText.TextSize = 16
	TitleText.Font = Enum.Font.SourceSansBold
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.Parent = TitleBar
	local SubTitleText = Instance.new("TextLabel")
	SubTitleText.Size = UDim2.new(0.5, 0, 1, 0)
	SubTitleText.Position = UDim2.new(0.5, 0, 0, 0)
	SubTitleText.BackgroundTransparency = 1
	SubTitleText.Text = Settings.SubTitle or ""
	SubTitleText.TextColor3 = Themes[Window.Save.Theme].ControlText
	SubTitleText.TextSize = 14
	SubTitleText.Font = Enum.Font.SourceSans
	SubTitleText.TextXAlignment = Enum.TextXAlignment.Right
	SubTitleText.Parent = TitleBar
	local TabContainer = Instance.new("Frame")
	TabContainer.Size = UDim2.new(0, Window.Save.TabSize, 1, -40)
	TabContainer.Position = UDim2.new(0, 0, 0, 40)
	TabContainer.BackgroundColor3 = Themes[Window.Save.Theme].TabBar
	TabContainer.BorderSizePixel = 0
	TabContainer.Parent = AcrylicFrame
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Vertical
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0, 5)
	TabLayout.Parent = TabContainer
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Size = UDim2.new(1, -Window.Save.TabSize, 1, -40)
	ContentFrame.Position = UDim2.new(0, Window.Save.TabSize, 0, 40)
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Parent = AcrylicFrame
	local DragStart, StartPos
	TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			DragStart = input.Position
			StartPos = AcrylicFrame.Position
		end
	end)
	TitleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and DragStart then
			local Delta = input.Position - DragStart
			AcrylicFrame.Position = UDim2.new(
				StartPos.X.Scale,
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale,
				StartPos.Y.Offset + Delta.Y
			)
		end
	end)
	TitleBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			DragStart = nil
		end
	end)
	function Window:MakeTab(Settings)
		local Tab = {
			Sections = {}
		}
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(1, 0, 0, 40)
		TabButton.BackgroundColor3 = Themes[Window.Save.Theme].Tab
		TabButton.Text = ""
		TabButton.AutoButtonColor = false
		TabButton.Parent = TabContainer
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
		TabIcon.BackgroundTransparency = 1
		TabIcon.Image = "rbxassetid://" .. (Settings.Icon or "9125573726")
		TabIcon.ImageColor3 = Themes[Window.Save.Theme].TabIcon
		TabIcon.Parent = TabButton
		local TabText = Instance.new("TextLabel")
		TabText.Size = UDim2.new(1, -40, 1, 0)
		TabText.Position = UDim2.new(0, 40, 0, 0)
		TabText.BackgroundTransparency = 1
		TabText.Text = Settings.Title or "Tab"
		TabText.TextColor3 = Themes[Window.Save.Theme].TabText
		TabText.TextSize = 14
		TabText.Font = Enum.Font.SourceSans
		TabText.TextXAlignment = Enum.TextXAlignment.Left
		TabText.Parent = TabButton
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Size = UDim2.new(1, 0, 1, 0)
		TabContent.BackgroundTransparency = 1
		TabContent.ScrollBarThickness = 4
		TabContent.ScrollBarImageColor3 = Themes[Window.Save.Theme].ControlStroke
		TabContent.Visible = false
		TabContent.Parent = ContentFrame
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.FillDirection = Enum.FillDirection.Vertical
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 10)
		ContentLayout.Parent = TabContent
		TabButton.MouseEnter:Connect(function()
			if not TabContent.Visible then
				TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].TabHover}):Play()
			end
		end)
		TabButton.MouseLeave:Connect(function()
			if not TabContent.Visible then
				TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].Tab}):Play()
			end
		end)
		TabButton.MouseButton1Click:Connect(function()
			for _, v in pairs(ContentFrame:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			for _, v in pairs(TabContainer:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].Tab}):Play()
				end
			end
			TabContent.Visible = true
			TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].TabSelected}):Play()
		end)
		function Tab:AddSection(Title)
			local Section = {}
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Size = UDim2.new(1, -10, 0, 0)
			SectionFrame.BackgroundColor3 = Themes[Window.Save.Theme].Section
			SectionFrame.BorderSizePixel = 0
			SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
			SectionFrame.Parent = TabContent
			local SectionStroke = Instance.new("UIStroke")
			SectionStroke.Thickness = 1
			SectionStroke.Color = Themes[Window.Save.Theme].ControlStroke
			SectionStroke.Parent = SectionFrame
			local SectionCorner = Instance.new("UICorner")
			SectionCorner.CornerRadius = UDim.new(0, 6)
			SectionCorner.Parent = SectionFrame
			local SectionTitle = Instance.new("TextLabel")
			SectionTitle.Size = UDim2.new(1, 0, 0, 30)
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Text = Title or "Section"
			SectionTitle.TextColor3 = Themes[Window.Save.Theme].SectionText
			SectionTitle.TextSize = 16
			SectionTitle.Font = Enum.Font.SourceSansBold
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			SectionTitle.TextYAlignment = Enum.TextYAlignment.Top
			SectionTitle.Parent = SectionFrame
			local SectionLayout = Instance.new("UIListLayout")
			SectionLayout.FillDirection = Enum.FillDirection.Vertical
			SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionLayout.Padding = UDim.new(0, 5)
			SectionLayout.Parent = SectionFrame
			local SectionPadding = Instance.new("UIPadding")
			SectionPadding.PaddingLeft = UDim.new(0, 10)
			SectionPadding.PaddingRight = UDim.new(0, 10)
			SectionPadding.PaddingTop = UDim.new(0, 10)
			SectionPadding.PaddingBottom = UDim.new(0, 10)
			SectionPadding.Parent = SectionFrame
			function Section:AddParagraph(Settings)
				local ParagraphFrame = Instance.new("Frame")
				ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
				ParagraphFrame.BackgroundTransparency = 1
				ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
				ParagraphFrame.Parent = SectionFrame
				local ParagraphTitle = Instance.new("TextLabel")
				ParagraphTitle.Size = UDim2.new(1, 0, 0, 0)
				ParagraphTitle.BackgroundTransparency = 1
				ParagraphTitle.Text = Settings.Title or "Paragraph"
				ParagraphTitle.TextColor3 = Themes[Window.Save.Theme].SectionText
				ParagraphTitle.TextSize = 16
				ParagraphTitle.Font = Enum.Font.SourceSansBold
				ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
				ParagraphTitle.TextWrapped = true
				ParagraphTitle.AutomaticSize = Enum.AutomaticSize.Y
				ParagraphTitle.Parent = ParagraphFrame
				local ParagraphText = Instance.new("TextLabel")
				ParagraphText.Size = UDim2.new(1, 0, 0, 0)
				ParagraphText.Position = UDim2.new(0, 0, 0, 0)
				ParagraphText.BackgroundTransparency = 1
				ParagraphText.Text = Settings.Text or ""
				ParagraphText.TextColor3 = Themes[Window.Save.Theme].SectionText
				ParagraphText.TextSize = 14
				ParagraphText.Font = Enum.Font.SourceSans
				ParagraphText.TextXAlignment = Enum.TextXAlignment.Left
				ParagraphText.TextWrapped = true
				ParagraphText.AutomaticSize = Enum.AutomaticSize.Y
				ParagraphText.Parent = ParagraphFrame
				local ParagraphLayout = Instance.new("UIListLayout")
				ParagraphLayout.FillDirection = Enum.FillDirection.Vertical
				ParagraphLayout.SortOrder = Enum.SortOrder.LayoutOrder
				ParagraphLayout.Padding = UDim.new(0, 5)
				ParagraphLayout.Parent = ParagraphFrame
			end
			function Section:AddButton(Settings)
				local ButtonFrame = Instance.new("TextButton")
				ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
				ButtonFrame.BackgroundColor3 = Themes[Window.Save.Theme].Control
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Text = ""
				ButtonFrame.AutoButtonColor = false
				ButtonFrame.Parent = SectionFrame
				local ButtonStroke = Instance.new("UIStroke")
				ButtonStroke.Thickness = 1
				ButtonStroke.Color = Themes[Window.Save.Theme].ControlStroke
				ButtonStroke.Parent = ButtonFrame
				local ButtonCorner = Instance.new("UICorner")
				ButtonCorner.CornerRadius = UDim.new(0, 6)
				ButtonCorner.Parent = ButtonFrame
				local ButtonText = Instance.new("TextLabel")
				ButtonText.Size = UDim2.new(1, 0, 1, 0)
				ButtonText.BackgroundTransparency = 1
				ButtonText.Text = Settings.Title or "Button"
				ButtonText.TextColor3 = Themes[Window.Save.Theme].ControlText
				ButtonText.TextSize = 14
				ButtonText.Font = Enum.Font.SourceSans
				ButtonText.Parent = ButtonFrame
				ButtonFrame.MouseEnter:Connect(function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].ControlHover}):Play()
				end)
				ButtonFrame.MouseLeave:Connect(function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].Control}):Play()
				end)
				ButtonFrame.MouseButton1Down:Connect(function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Themes[Window.Save.Theme].ControlActive}):Play()
				end)
				ButtonFrame.MouseButton1Up:Connect(function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Themes[Window.Save.Theme].ControlHover}):Play()
					if Settings.Callback then
						Settings.Callback()
					end
				end)
			end
			function Section:AddToggle(Settings)
				local ToggleFrame = Instance.new("Frame")
				ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
				ToggleFrame.BackgroundTransparency = 1
				ToggleFrame.Parent = SectionFrame
				local ToggleButton = Instance.new("TextButton")
				ToggleButton.Size = UDim2.new(0, 20, 0, 20)
				ToggleButton.Position = UDim2.new(1, -30, 0.5, -10)
				ToggleButton.BackgroundColor3 = Themes[Window.Save.Theme].Control
				ToggleButton.BorderSizePixel = 0
				ToggleButton.Text = ""
				ToggleButton.AutoButtonColor = false
				ToggleButton.Parent = ToggleFrame
				local ToggleStroke = Instance.new("UIStroke")
				ToggleStroke.Thickness = 1
				ToggleStroke.Color = Themes[Window.Save.Theme].ControlStroke
				ToggleStroke.Parent = ToggleButton
				local ToggleCorner = Instance.new("UICorner")
				ToggleCorner.CornerRadius = UDim.new(0, 6)
				ToggleCorner.Parent = ToggleButton
				local ToggleCheck = Instance.new("ImageLabel")
				ToggleCheck.Size = UDim2.new(0, 14, 0, 14)
				ToggleCheck.Position = UDim2.new(0.5, -7, 0.5, -7)
				ToggleCheck.BackgroundTransparency = 1
				ToggleCheck.Image = "rbxassetid://9125573726"
				ToggleCheck.ImageColor3 = Themes[Window.Save.Theme].ControlText
				ToggleCheck.Visible = Settings.Default or false
				ToggleCheck.Parent = ToggleButton
				local ToggleText = Instance.new("TextLabel")
				ToggleText.Size = UDim2.new(1, -40, 1, 0)
				ToggleText.BackgroundTransparency = 1
				ToggleText.Text = Settings.Title or "Toggle"
				ToggleText.TextColor3 = Themes[Window.Save.Theme].ControlText
				ToggleText.TextSize = 14
				ToggleText.Font = Enum.Font.SourceSans
				ToggleText.TextXAlignment = Enum.TextXAlignment.Left
				ToggleText.Parent = ToggleFrame
				Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = Settings.Default or false
				ToggleButton.MouseButton1Click:Connect(function()
					Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = not Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)]
					ToggleCheck.Visible = Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)]
					if Settings.Callback then
						Settings.Callback(Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)])
					end
				end)
			end
			function Section:AddSlider(Settings)
				local SliderFrame = Instance.new("Frame")
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.Parent = SectionFrame
				local SliderText = Instance.new("TextLabel")
				SliderText.Size = UDim2.new(1, 0, 0, 20)
				SliderText.BackgroundTransparency = 1
				SliderText.Text = Settings.Title or "Slider"
				SliderText.TextColor3 = Themes[Window.Save.Theme].ControlText
				SliderText.TextSize = 14
				SliderText.Font = Enum.Font.SourceSans
				SliderText.TextXAlignment = Enum.TextXAlignment.Left
				SliderText.Parent = SliderFrame
				local SliderBar = Instance.new("Frame")
				SliderBar.Size = UDim2.new(1, 0, 0, 10)
				SliderBar.Position = UDim2.new(0, 0, 0, 30)
				SliderBar.BackgroundColor3 = Themes[Window.Save.Theme].Control
				SliderBar.BorderSizePixel = 0
				SliderBar.Parent = SliderFrame
				local SliderStroke = Instance.new("UIStroke")
				SliderStroke.Thickness = 1
				SliderStroke.Color = Themes[Window.Save.Theme].ControlStroke
				SliderStroke.Parent = SliderBar
				local SliderCorner = Instance.new("UICorner")
				SliderCorner.CornerRadius = UDim.new(0, 6)
				SliderCorner.Parent = SliderBar
				local SliderFill = Instance.new("Frame")
				SliderFill.Size = UDim2.new(0, 0, 1, 0)
				SliderFill.BackgroundColor3 = Themes[Window.Save.Theme].ControlActive
				SliderFill.BorderSizePixel = 0
				SliderFill.Parent = SliderBar
				local FillCorner = Instance.new("UICorner")
				FillCorner.CornerRadius = UDim.new(0, 6)
				FillCorner.Parent = SliderFill
				local SliderValue = Instance.new("TextLabel")
				SliderValue.Size = UDim2.new(0, 50, 0, 20)
				SliderValue.Position = UDim2.new(1, -60, 0, 5)
				SliderValue.BackgroundTransparency = 1
				SliderValue.Text = tostring(Settings.Default or Settings.Min)
				SliderValue.TextColor3 = Themes[Window.Save.Theme].ControlText
				SliderValue.TextSize = 14
				SliderValue.Font = Enum.Font.SourceSans
				SliderValue.Parent = SliderFrame
				Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = Settings.Default or Settings.Min
				local Dragging = false
				SliderBar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = true
					end
				end)
				SliderBar.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local MousePos = UserInputService:GetMouseLocation()
						local Relative = MousePos.X - SliderBar.AbsolutePosition.X
						local Percent = math.clamp(Relative / SliderBar.AbsoluteSize.X, 0, 1)
						local Value = Settings.Min + (Settings.Max - Settings.Min) * Percent
						Value = math.round(Value / Settings.Increase) * Settings.Increase
						Value = math.clamp(Value, Settings.Min, Settings.Max)
						SliderFill.Size = UDim2.new(Percent, 0, 1, 0)
						SliderValue.Text = tostring(Value)
						Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = Value
						if Settings.Callback then
							Settings.Callback(Value)
						end
					end
				end)
			end
			function Section:AddDropdown(Settings)
				local DropdownFrame = Instance.new("Frame")
				DropdownFrame.Size = UDim2.new(1, 0, 0, 30)
				DropdownFrame.BackgroundTransparency = 1
				DropdownFrame.Parent = SectionFrame
				local DropdownButton = Instance.new("TextButton")
				DropdownButton.Size = UDim2.new(1, 0, 0, 30)
				DropdownButton.BackgroundColor3 = Themes[Window.Save.Theme].Control
				DropdownButton.BorderSizePixel = 0
				DropdownButton.Text = ""
				DropdownButton.AutoButtonColor = false
				DropdownButton.Parent = DropdownFrame
				local DropdownStroke = Instance.new("UIStroke")
				DropdownStroke.Thickness = 1
				DropdownStroke.Color = Themes[Window.Save.Theme].ControlStroke
				DropdownStroke.Parent = DropdownButton
				local DropdownCorner = Instance.new("UICorner")
				DropdownCorner.CornerRadius = UDim.new(0, 6)
				DropdownCorner.Parent = DropdownButton
				local DropdownText = Instance.new("TextLabel")
				DropdownText.Size = UDim2.new(1, -30, 1, 0)
				DropdownText.Position = UDim2.new(0, 10, 0, 0)
				DropdownText.BackgroundTransparency = 1
				DropdownText.Text = Settings.Title or "Dropdown"
				DropdownText.TextColor3 = Themes[Window.Save.Theme].ControlText
				DropdownText.TextSize = 14
				DropdownText.Font = Enum.Font.SourceSans
				DropdownText.TextXAlignment = Enum.TextXAlignment.Left
				DropdownText.Parent = DropdownButton
				local DropdownArrow = Instance.new("ImageLabel")
				DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
				DropdownArrow.Position = UDim2.new(1, -25, 0.5, -10)
				DropdownArrow.BackgroundTransparency = 1
				DropdownArrow.Image = "rbxassetid://9125573726"
				DropdownArrow.ImageColor3 = Themes[Window.Save.Theme].ControlText
				DropdownArrow.Parent = DropdownButton
				local DropdownList = Instance.new("Frame")
				DropdownList.Size = UDim2.new(1, 0, 0, 0)
				DropdownList.Position = UDim2.new(0, 0, 1, 5)
				DropdownList.BackgroundColor3 = Themes[Window.Save.Theme].Control
				DropdownList.BorderSizePixel = 0
				DropdownList.Visible = false
				DropdownList.AutomaticSize = Enum.AutomaticSize.Y
				DropdownList.Parent = DropdownFrame
				local ListStroke = Instance.new("UIStroke")
				ListStroke.Thickness = 1
				ListStroke.Color = Themes[Window.Save.Theme].ControlStroke
				ListStroke.Parent = DropdownList
				local ListCorner = Instance.new("UICorner")
				ListCorner.CornerRadius = UDim.new(0, 6)
				ListCorner.Parent = DropdownList
				local ListLayout = Instance.new("UIListLayout")
				ListLayout.FillDirection = Enum.FillDirection.Vertical
				ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				ListLayout.Padding = UDim.new(0, 5)
				ListLayout.Parent = DropdownList
				local ListPadding = Instance.new("UIPadding")
				ListPadding.PaddingTop = UDim.new(0, 5)
				ListPadding.PaddingBottom = UDim.new(0, 5)
				ListPadding.Parent = DropdownList
				Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = Settings.Default or Settings.Options[1]
				for _, Option in ipairs(Settings.Options or {}) do
					local OptionButton = Instance.new("TextButton")
					OptionButton.Size = UDim2.new(1, 0, 0, 25)
					OptionButton.BackgroundTransparency = 1
					OptionButton.Text = Option
					OptionButton.TextColor3 = Themes[Window.Save.Theme].ControlText
					OptionButton.TextSize = 14
					OptionButton.Font = Enum.Font.SourceSans
					OptionButton.Parent = DropdownList
					OptionButton.MouseButton1Click:Connect(function()
						DropdownText.Text = Option
						Window.Flags[Settings.Flag or HttpService:GenerateGUID(false)] = Option
						DropdownList.Visible = false
						if Settings.Callback then
							Settings.Callback(Option)
						end
					end)
				end
				DropdownButton.MouseButton1Click:Connect(function()
					DropdownList.Visible = not DropdownList.Visible
				end)
			end
			function Section:AddTextBox(Settings)
				local TextBoxFrame = Instance.new("Frame")
				TextBoxFrame.Size = UDim2.new(1, 0, 0, 30)
				TextBoxFrame.BackgroundTransparency = 1
				TextBoxFrame.Parent = SectionFrame
				local TextBox = Instance.new("TextBox")
				TextBox.Size = UDim2.new(1, 0, 0, 30)
				TextBox.BackgroundColor3 = Themes[Window.Save.Theme].Control
				TextBox.BorderSizePixel = 0
				TextBox.Text = Settings.Default or ""
				TextBox.PlaceholderText = Settings.PlaceholderText or "Digite"
				TextBox.TextColor3 = Themes[Window.Save.Theme].ControlText
				TextBox.TextSize = 14
				TextBox.Font = Enum.Font.SourceSans
				TextBox.Parent = TextBoxFrame
				local TextBoxStroke = Instance.new("UIStroke")
				TextBoxStroke.Thickness = 1
				TextBoxStroke.Color = Themes[Window.Save.Theme].ControlStroke
				TextBoxStroke.Parent = TextBox
				local TextBoxCorner = Instance.new("UICorner")
				TextBoxCorner.CornerRadius = UDim.new(0, 6)
				TextBoxCorner.Parent = TextBox
				TextBox.FocusLost:Connect(function()
					if Settings.Callback then
						Settings.Callback(TextBox.Text)
					end
				end)
			end
			function Section:AddDiscordInvite(Settings)
				local DiscordFrame = Instance.new("Frame")
				DiscordFrame.Size = UDim2.new(1, 0, 0, 60)
				DiscordFrame.BackgroundColor3 = Themes[Window.Save.Theme].Control
				DiscordFrame.BorderSizePixel = 0
				DiscordFrame.Parent = SectionFrame
				local DiscordStroke = Instance.new("UIStroke")
				DiscordStroke.Thickness = 1
				DiscordStroke.Color = Themes[Window.Save.Theme].ControlStroke
				DiscordStroke.Parent = DiscordFrame
				local DiscordCorner = Instance.new("UICorner")
				DiscordCorner.CornerRadius = UDim.new(0, 6)
				DiscordCorner.Parent = DiscordFrame
				local DiscordIcon = Instance.new("ImageLabel")
				DiscordIcon.Size = UDim2.new(0, 40, 0, 40)
				DiscordIcon.Position = UDim2.new(0, 10, 0.5, -20)
				DiscordIcon.BackgroundTransparency = 1
				DiscordIcon.Image = Settings.Logo or "rbxassetid://9125573726"
				DiscordIcon.Parent = DiscordFrame
				local DiscordText = Instance.new("TextLabel")
				DiscordText.Size = UDim2.new(1, -60, 0, 20)
				DiscordText.Position = UDim2.new(0, 60, 0, 10)
				DiscordText.BackgroundTransparency = 1
				DiscordText.Text = Settings.Title or "DiscordInvite"
				DiscordText.TextColor3 = Themes[Window.Save.Theme].ControlText
				DiscordText.TextSize = 14
				DiscordText.Font = Enum.Font.SourceSansBold
				DiscordText.TextXAlignment = Enum.TextXAlignment.Left
				DiscordText.Parent = DiscordFrame
				local DiscordSubText = Instance.new("TextLabel")
				DiscordSubText.Size = UDim2.new(1, -60, 0, 20)
				DiscordSubText.Position = UDim2.new(0, 60, 0, 30)
				DiscordSubText.BackgroundTransparency = 1
				DiscordSubText.Text = Settings.Invite or ""
				DiscordSubText.TextColor3 = Themes[Window.Save.Theme].ControlText
				DiscordSubText.TextSize = 12
				DiscordSubText.Font = Enum.Font.SourceSans
				DiscordSubText.TextXAlignment = Enum.TextXAlignment.Left
				DiscordSubText.Parent = DiscordFrame
			end
			return Section
		end
		function Window:Dialog(Settings)
			local DialogFrame = Instance.new("Frame")
			DialogFrame.Size = UDim2.new(0, 300, 0, 150)
			DialogFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
			DialogFrame.BackgroundColor3 = Themes[Window.Save.Theme].Dialog
			DialogFrame.BorderSizePixel = 0
			DialogFrame.Parent = MainFrame
			local DialogStroke = Instance.new("UIStroke")
			DialogStroke.Thickness = 1
			DialogStroke.Color = Themes[Window.Save.Theme].ControlStroke
			DialogStroke.Parent = DialogFrame
			local DialogCorner = Instance.new("UICorner")
			DialogCorner.CornerRadius = UDim.new(0, 8)
			DialogCorner.Parent = DialogFrame
			local DialogTitle = Instance.new("TextLabel")
			DialogTitle.Size = UDim2.new(1, 0, 0, 30)
			DialogTitle.BackgroundTransparency = 1
			DialogTitle.Text = Settings.Title or "Dialog"
			DialogTitle.TextColor3 = Themes[Window.Save.Theme].DialogText
			DialogTitle.TextSize = 16
			DialogTitle.Font = Enum.Font.SourceSansBold
			DialogTitle.Parent = DialogFrame
			local DialogText = Instance.new("TextLabel")
			DialogText.Size = UDim2.new(1, -20, 0, 80)
			DialogText.Position = UDim2.new(0, 10, 0, 30)
			DialogText.BackgroundTransparency = 1
			DialogText.Text = Settings.Text or ""
			DialogText.TextColor3 = Themes[Window.Save.Theme].DialogText
			DialogText.TextSize = 14
			DialogText.Font = Enum.Font.SourceSans
			DialogText.TextWrapped = true
			DialogText.Parent = DialogFrame
			local ButtonLayout = Instance.new("UIListLayout")
			ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
			ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
			ButtonLayout.Padding = UDim.new(0, 10)
			ButtonLayout.Parent = DialogFrame
			for _, Option in ipairs(Settings.Options or {}) do
				local OptionButton = Instance.new("TextButton")
				OptionButton.Size = UDim2.new(0, 100, 0, 30)
				OptionButton.BackgroundColor3 = Themes[Window.Save.Theme].DialogButton
				OptionButton.BorderSizePixel = 0
				OptionButton.Text = Option.Title or "Option"
				OptionButton.TextColor3 = Themes[Window.Save.Theme].DialogButtonText
				OptionButton.TextSize = 14
				OptionButton.Font = Enum.Font.SourceSans
				OptionButton.Parent = DialogFrame
				local OptionStroke = Instance.new("UIStroke")
				OptionStroke.Thickness = 1
				OptionStroke.Color = Themes[Window.Save.Theme].ControlStroke
				OptionStroke.Parent = OptionButton
				local OptionCorner = Instance.new("UICorner")
				OptionCorner.CornerRadius = UDim.new(0, 6)
				OptionCorner.Parent = OptionButton
				OptionButton.MouseEnter:Connect(function()
					TweenService:Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].DialogButtonHover}):Play()
				end)
				OptionButton.MouseLeave:Connect(function()
					TweenService:Create(OptionButton, TweenInfo.new(0.2), {BackgroundColor3 = Themes[Window.Save.Theme].DialogButton}):Play()
				end)
				OptionButton.MouseButton1Click:Connect(function()
					if Option.Callback then
						Option.Callback()
					end
					DialogFrame:Destroy()
				end)
			end
		end
		function Window:Minimize()
			AcrylicFrame.Visible = not AcrylicFrame.Visible
		end
		function Window:AddMinimizeButton(Settings)
			local MinimizeButton = Instance.new("TextButton")
			MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
			MinimizeButton.Position = UDim2.new(1, -50, 0, 10)
			MinimizeButton.BackgroundColor3 = Themes[Window.Save.Theme].Control
			MinimizeButton.BorderSizePixel = 0
			MinimizeButton.Text = ""
			MinimizeButton.AutoButtonColor = false
			MinimizeButton.Parent = MainFrame
			local MinimizeIcon = Instance.new("ImageLabel")
			MinimizeIcon.Size = UDim2.new(0, 20, 0, 20)
			MinimizeIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
			MinimizeIcon.BackgroundTransparency = 1
			MinimizeIcon.Image = Settings.Button.Image or "rbxassetid://9125573726"
			MinimizeIcon.ImageColor3 = Themes[Window.Save.Theme].ControlText
			MinimizeIcon.Parent = MinimizeButton
			local MinimizeStroke = Instance.new("UIStroke")
			MinimizeStroke.Thickness = Settings.Stroke.Thickness or 1
			MinimizeStroke.Color = Themes[Window.Save.Theme].ControlStroke
			MinimizeStroke.Parent = MinimizeButton
			local MinimizeCorner = Instance.new("UICorner")
			MinimizeCorner.CornerRadius = Settings.Corner.CornerRadius or UDim.new(0, 8)
			MinimizeCorner.Parent = MinimizeButton
			MinimizeButton.MouseButton1Click:Connect(function()
				Window:Minimize()
			end)
		end
		table.insert(Window.Tabs, Tab)
		return Tab
	end
	return Window
end

return Library
