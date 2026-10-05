-- ==========================================================
-- EON VISUAL v11 — FINAL
-- ==========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ОЧИСТКА СТАРОГО
pcall(function()
    local names = {"EonKey","EonMain","EonCursor","EonPick","CheonKey","CheonMain","CheonCursor"}
    for _, n in ipairs(names) do
        if CoreGui:FindFirstChild(n) then CoreGui[n]:Destroy() end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg and pg:FindFirstChild(n) then pg[n]:Destroy() end
    end
end)
task.wait(0.15)

-- FIREBASE + KEYS
local FIREBASE_URL = "https://cheon-keys-default-rtdb.firebaseio.com"
local KEYS_PATH = "used_keys"

local MASTER_KEYS = {
    ["eonvisual_3qthfmdnlwfu_7"] = {product="EON VISUAL", days=7, lifetime=false},
    ["eonvisual_test_7"]         = {product="EON VISUAL", days=7, lifetime=false},
    ["eonvisual_test_30"]        = {product="EON VISUAL", days=30, lifetime=false},
    ["eonvisual_test_forever"]   = {product="EON VISUAL", days=0, lifetime=true},
    ["cheon_v0hftxvllgdf_7"]     = {product="EON VISUAL", days=7, lifetime=false},
}

-- СОХРАНЁННОЕ УСТРОЙСТВО
local savedDevice = nil
pcall(function()
    if readfile and isfile and isfile("eon_device.txt") then
        savedDevice = readfile("eon_device.txt"):gsub("%s", "")
    end
end)

local isMobile, deviceType
if savedDevice == "PC" then
    isMobile = false
    deviceType = "PC"
elseif savedDevice == "MOBILE" then
    isMobile = true
    deviceType = "MOBILE"
else
    isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    deviceType = isMobile and "MOBILE" or "PC"
end

-- ЦВЕТА
local C = {
    bg = Color3.fromRGB(11, 11, 15), bg2 = Color3.fromRGB(16, 16, 21),
    bg3 = Color3.fromRGB(22, 22, 28), bgRow = Color3.fromRGB(26, 26, 32),
    bgRowHov = Color3.fromRGB(38, 38, 46), bgSlider = Color3.fromRGB(55, 55, 65),
    text = Color3.fromRGB(242, 242, 248), textDim = Color3.fromRGB(150, 150, 162),
    textDim2 = Color3.fromRGB(95, 95, 108), stroke = Color3.fromRGB(44, 44, 52),
    strokeHi = Color3.fromRGB(78, 78, 90), accent = Color3.fromRGB(110, 150, 255),
    accent2 = Color3.fromRGB(170, 110, 255), accent3 = Color3.fromRGB(255, 110, 190),
    white = Color3.fromRGB(252, 252, 255), success = Color3.fromRGB(85, 215, 135),
    warning = Color3.fromRGB(252, 195, 85), danger = Color3.fromRGB(240, 95, 95),
}

local T = {
    ru = {
        k_title="ВВЕДИТЕ КЛЮЧ", k_desc="Ключ доступа к EON VISUAL",
        k_ph="eonVISUAL_xxxxxxxxxxxx_30", k_btn="ПРОВЕРИТЬ",
        k_check="Проверка...", k_ok="Ключ активирован",
        k_no="Неверный ключ", k_used="Ключ использован",
        k_err="Ошибка", k_expired="Подписка истекла",
        k_buy="Купить: eon.website",
        pick_title="ВЫБЕРИ УСТРОЙСТВО", pick_desc="От этого зависит способ открытия",
        pick_pc="ПК", pick_pc_sub="Клавиша INSERT",
        pick_mob="Телефон", pick_mob_sub="Кнопка Е снизу",
        pick_auto="Авто", pick_auto_sub="Определить само",
        load_init="Инициализация", load_mod="Загрузка модулей", load_apply="Применение", load_ok="Готово",
        cat_world="Мир", cat_visuals="Визуалы", cat_player="Персонаж",
        cat_cursor="Курсор", cat_sub="Подписка", cat_settings="Настройки",
        sec_sky="НЕБО", sec_time="ВРЕМЯ", sec_fx="ЭФФЕКТЫ", sec_char="ПЕРСОНАЖ",
        sec_lang="ЯЗЫК", sec_reset="СБРОС",
        sky_space="Космос", sky_sunset="Закат", sky_night="Ночь", sky_dawn="Рассвет",
        sky_storm="Гроза", sky_clear="День", sky_nebula="Туманность", sky_off="Убрать",
        time_day="День", time_evening="Вечер", time_night="Ночь",
        fog="Туман", bloom="Bloom", cc="Цветокоррекция", dof="Резкость",
        blur="Размытие", sunrays="Лучи",
        charGlow="Свечение", charRGB="RGB аура", charTrail="Трейл", charSparkles="Искры", charFire="Огонь",
        reset="Сбросить всё", lang_ru="Русский", lang_en="English",
        sub_active="АКТИВНА", sub_expired="ИСТЕКЛА", sub_lifetime="НАВСЕГДА",
        sub_product="Продукт", sub_key="Ключ", sub_bought="Куплено", sub_expires="Истекает",
        sub_none="Нет подписки", sub_none_desc="Введи ключ",
        sub_active_subs="МОИ ПОДПИСКИ", sub_forever="Бессрочно",
        online="Онлайн",
    },
    en = {
        k_title="ENTER KEY", k_desc="Access key for EON VISUAL", k_ph="eonVISUAL_xxxxxxxxxxxx_30",
        k_btn="VERIFY", k_check="Checking...", k_ok="Key activated", k_no="Invalid key",
        k_used="Key used", k_err="Error", k_expired="Subscription expired",
        k_buy="Buy: eon.website",
        pick_title="SELECT DEVICE", pick_desc="Affects how menu opens",
        pick_pc="PC", pick_pc_sub="INSERT key",
        pick_mob="Mobile", pick_mob_sub="E button bottom",
        pick_auto="Auto", pick_auto_sub="Auto-detect",
        load_init="Initializing", load_mod="Loading", load_apply="Applying", load_ok="Done",
        cat_world="World", cat_visuals="Visuals", cat_player="Player",
        cat_cursor="Cursor", cat_sub="Subscription", cat_settings="Settings",
        sec_sky="SKY", sec_time="TIME", sec_fx="EFFECTS", sec_char="CHARACTER",
        sec_lang="LANGUAGE", sec_reset="RESET",
        sky_space="Space", sky_sunset="Sunset", sky_night="Night", sky_dawn="Dawn",
        sky_storm="Storm", sky_clear="Day", sky_nebula="Nebula", sky_off="Remove",
        time_day="Day", time_evening="Evening", time_night="Night",
        fog="Fog", bloom="Bloom", cc="Color correction", dof="DOF",
        blur="Blur", sunrays="Sun rays",
        charGlow="Glow", charRGB="RGB aura", charTrail="Trail", charSparkles="Sparkles", charFire="Fire",
        reset="Reset all", lang_ru="Русский", lang_en="English",
        sub_active="ACTIVE", sub_expired="EXPIRED", sub_lifetime="LIFETIME",
        sub_product="Product", sub_key="Key", sub_bought="Bought", sub_expires="Expires",
        sub_none="No subscription", sub_none_desc="Enter key",
        sub_active_subs="MY SUBSCRIPTIONS", sub_forever="Forever",
        online="Online",
    }
}
local Lang = "ru"
local function tr(k) return T[Lang][k] or k end

-- PARSE
local function parseKey(key)
    key = key:gsub("%s", "")
    if key == "" then return nil end
    local lower = key:lower()
    local mk = MASTER_KEYS[lower]
    if mk then
        return {product=mk.product, days=mk.days, lifetime=mk.lifetime, raw=key, master=true}
    end
    local product, rand, dur = lower:match("^(%a+)_([%a0-9]+)_([%a0-9]+)$")
    if not product or not rand or not dur then return nil end
    if #rand < 6 then return nil end
    if product ~= "cheon" and product ~= "eonvisual" then return nil end
    local lifetime = (dur == "lifetime")
    local days = lifetime and 0 or tonumber(dur)
    if not lifetime and (not days or days <= 0) then return nil end
    return {product="EON VISUAL", days=days, lifetime=lifetime, raw=key, master=false}
end

local function checkKey(key)
    local p = parseKey(key)
    if not p then return false, "invalid", nil end
    local now = os.time()
    if p.master then
        return true, "master", {
            key=p.raw, product=p.product, days=p.days, lifetime=p.lifetime,
            activatedAt=now, expiresAt=p.lifetime and 0 or (now + p.days * 86400)
        }
    end
    local safe = p.raw:lower():gsub("[%./%[%]%$#]", "_")
    local url = FIREBASE_URL .. "/" .. KEYS_PATH .. "/" .. safe .. ".json"
    local ok, res = pcall(function() return HttpService:GetAsync(url) end)
    if ok and res and res ~= "" and res ~= "null" then
        local ok2, dec = pcall(function() return HttpService:JSONDecode(res) end)
        if ok2 and dec then
            if dec.userId and dec.userId ~= LocalPlayer.UserId then return false, "used", nil end
            if dec.lifetime then return true, "reactivate", dec end
            if dec.expiresAt and dec.expiresAt > now then return true, "reactivate", dec end
            return false, "expired", nil
        end
    end
    local data = {
        userId=LocalPlayer.UserId, username=LocalPlayer.Name,
        product=p.product, days=p.days, lifetime=p.lifetime,
        activatedAt=now, expiresAt=p.lifetime and 0 or (now + p.days * 86400), rawKey=p.raw
    }
    pcall(function() HttpService:PutAsync(url, HttpService:JSONEncode(data)) end)
    return true, "new", data
end

local startMain
local currentSubs = {}

-- ==========================================================
-- KEY GUI
-- ==========================================================
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "EonKey"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 2147483640
pcall(function() KeyGui.Parent = CoreGui end)
if not KeyGui.Parent then KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local KeyBg = Instance.new("Frame")
KeyBg.Size = UDim2.new(1, 0, 1, 0)
KeyBg.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
KeyBg.BackgroundTransparency = 0.15
KeyBg.BorderSizePixel = 0
KeyBg.ZIndex = 99990
KeyBg.Parent = KeyGui

local KGBgGrad = Instance.new("UIGradient")
KGBgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 14)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 12, 34)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 14)),
})
KGBgGrad.Rotation = 45
KGBgGrad.Parent = KeyBg

local KeyBox = Instance.new("Frame")
KeyBox.Size = UDim2.new(0, 460, 0, 380)
KeyBox.Position = UDim2.new(0.5, -230, 0.5, -190)
KeyBox.BackgroundColor3 = C.bg
KeyBox.BorderSizePixel = 0
KeyBox.ZIndex = 99992
KeyBox.Parent = KeyBg

local KBCorner = Instance.new("UICorner"); KBCorner.CornerRadius = UDim.new(0, 20); KBCorner.Parent = KeyBox
local KBS1 = Instance.new("UIStroke"); KBS1.Color = C.stroke; KBS1.Thickness = 1; KBS1.Parent = KeyBox
local KBS2 = Instance.new("UIStroke"); KBS2.Color = C.accent; KBS2.Thickness = 2; KBS2.Transparency = 0.6; KBS2.Parent = KeyBox

task.spawn(function()
    while KBS2.Parent do
        local a = (math.sin(tick() * 1.2) + 1) / 2
        KBS2.Transparency = 0.3 + a * 0.5
        KBS2.Color = C.accent:Lerp(C.accent2, a)
        task.wait(0.05)
    end
end)

local IconHolder = Instance.new("Frame")
IconHolder.Size = UDim2.new(0, 68, 0, 68)
IconHolder.Position = UDim2.new(0.5, -34, 0, 30)
IconHolder.BackgroundColor3 = C.bg3
IconHolder.BorderSizePixel = 0
IconHolder.ZIndex = 99993
IconHolder.Parent = KeyBox
local IHC = Instance.new("UICorner"); IHC.CornerRadius = UDim.new(0, 16); IHC.Parent = IconHolder
local IHS = Instance.new("UIStroke"); IHS.Color = C.accent; IHS.Thickness = 1.5; IHS.Transparency = 0.3; IHS.Parent = IconHolder
local IHL = Instance.new("TextLabel")
IHL.Size = UDim2.new(1, 0, 1, 0); IHL.BackgroundTransparency = 1
IHL.Text = "🔐"; IHL.TextSize = 32; IHL.Font = Enum.Font.GothamBold; IHL.ZIndex = 99994
IHL.Parent = IconHolder

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -40, 0, 28)
KeyTitle.Position = UDim2.new(0, 20, 0, 120)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = tr("k_title")
KeyTitle.TextColor3 = C.white
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 19
KeyTitle.ZIndex = 99993
KeyTitle.Parent = KeyBox

local KeyDesc = Instance.new("TextLabel")
KeyDesc.Size = UDim2.new(1, -40, 0, 18)
KeyDesc.Position = UDim2.new(0, 20, 0, 148)
KeyDesc.BackgroundTransparency = 1
KeyDesc.Text = tr("k_desc")
KeyDesc.TextColor3 = C.textDim
KeyDesc.Font = Enum.Font.Gotham
KeyDesc.TextSize = 12
KeyDesc.ZIndex = 99993
KeyDesc.Parent = KeyBox

local KIF = Instance.new("Frame")
KIF.Size = UDim2.new(1, -40, 0, 50)
KIF.Position = UDim2.new(0, 20, 0, 180)
KIF.BackgroundColor3 = C.bg2
KIF.BorderSizePixel = 0
KIF.ZIndex = 99993
KIF.Parent = KeyBox
local KIFC = Instance.new("UICorner"); KIFC.CornerRadius = UDim.new(0, 12); KIFC.Parent = KIF
local KIFS = Instance.new("UIStroke"); KIFS.Color = C.stroke; KIFS.Thickness = 1.5; KIFS.Parent = KIF

local KInput = Instance.new("TextBox")
KInput.Size = UDim2.new(1, -28, 1, 0)
KInput.Position = UDim2.new(0, 14, 0, 0)
KInput.BackgroundTransparency = 1
KInput.Text = ""
KInput.PlaceholderText = tr("k_ph")
KInput.PlaceholderColor3 = C.textDim2
KInput.TextColor3 = C.white
KInput.Font = Enum.Font.GothamBold
KInput.TextSize = 14
KInput.TextXAlignment = Enum.TextXAlignment.Center
KInput.ClearTextOnFocus = false
KInput.ZIndex = 99994
KInput.Parent = KIF

local KBtn = Instance.new("TextButton")
KBtn.Size = UDim2.new(1, -40, 0, 50)
KBtn.Position = UDim2.new(0, 20, 0, 244)
KBtn.BackgroundColor3 = C.accent
KBtn.BorderSizePixel = 0
KBtn.Text = tr("k_btn")
KBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KBtn.Font = Enum.Font.GothamBold
KBtn.TextSize = 14
KBtn.ZIndex = 99993
KBtn.AutoButtonColor = false
KBtn.Parent = KeyBox

local KBC = Instance.new("UICorner"); KBC.CornerRadius = UDim.new(0, 12); KBC.Parent = KBtn
local KBGrad = Instance.new("UIGradient")
KBGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, C.accent), ColorSequenceKeypoint.new(1, C.accent2)})
KBGrad.Rotation = 15; KBGrad.Parent = KBtn

local KStatus = Instance.new("TextLabel")
KStatus.Size = UDim2.new(1, -40, 0, 18)
KStatus.Position = UDim2.new(0, 20, 0, 305)
KStatus.BackgroundTransparency = 1
KStatus.Text = ""
KStatus.TextColor3 = C.textDim
KStatus.Font = Enum.Font.Gotham
KStatus.TextSize = 12
KStatus.ZIndex = 99993
KStatus.Parent = KeyBox

local KBuy = Instance.new("TextLabel")
KBuy.Size = UDim2.new(1, -40, 0, 18)
KBuy.Position = UDim2.new(0, 20, 0, 335)
KBuy.BackgroundTransparency = 1
KBuy.Text = tr("k_buy")
KBuy.TextColor3 = C.textDim2
KBuy.Font = Enum.Font.Gotham
KBuy.TextSize = 11
KBuy.ZIndex = 99993
KBuy.Parent = KeyBox

local function submitKey()
    local k = KInput.Text
    if k == "" then KStatus.Text = tr("k_no"); KStatus.TextColor3 = C.danger; return end
    KStatus.Text = tr("k_check"); KStatus.TextColor3 = C.textDim
    KBtn.Text = "..."

    task.spawn(function()
        local ok, valid, reason, subData = pcall(checkKey, k)
        task.wait(0.5)
        if ok and valid then
            local p = parseKey(k)
            table.insert(currentSubs, subData or {
                key=k, product="EON VISUAL", days=p and p.days or 0,
                lifetime=p and p.lifetime or false, activatedAt=os.time(), expiresAt=0
            })
            KStatus.Text = "✓ " .. tr("k_ok")
            KStatus.TextColor3 = C.success
            KBtn.Text = "✓ OK"
            KBtn.BackgroundColor3 = C.success
            task.wait(0.6)

            -- ЖЁСТКОЕ УБИЙСТВО
            pcall(function() KeyGui:Destroy() end)
            pcall(function()
                if CoreGui:FindFirstChild("EonKey") then CoreGui.EonKey:Destroy() end
                if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("EonKey") then
                    LocalPlayer.PlayerGui.EonKey:Destroy()
                end
            end)
            task.wait(0.3)
            pcall(startMain)
        else
            KBtn.Text = tr("k_btn")
            KBtn.BackgroundColor3 = C.accent
            KStatus.TextColor3 = C.danger
            if reason == "used" then KStatus.Text = tr("k_used")
            elseif reason == "expired" then KStatus.Text = tr("k_expired")
            elseif reason == "invalid" then KStatus.Text = tr("k_no")
            else KStatus.Text = "Ошибка" end
        end
    end)
end

KBtn.MouseButton1Click:Connect(submitKey)
KInput.FocusLost:Connect(function(e) if e then submitKey() end end)

-- ==========================================================
-- ГЛАВНАЯ
-- ==========================================================
startMain = function()
    -- ЭКРАН ВЫБОРА УСТРОЙСТВА
    if not savedDevice then
        local PickGui = Instance.new("ScreenGui")
        PickGui.Name = "EonPick"
        PickGui.ResetOnSpawn = false
        PickGui.IgnoreGuiInset = true
        PickGui.DisplayOrder = 2147483641
        pcall(function() PickGui.Parent = CoreGui end)
        if not PickGui.Parent then PickGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

        local PickBg = Instance.new("Frame")
        PickBg.Size = UDim2.new(1, 0, 1, 0)
        PickBg.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
        PickBg.BackgroundTransparency = 0.1
        PickBg.BorderSizePixel = 0
        PickBg.ZIndex = 99990
        PickBg.Parent = PickGui

        local PBG = Instance.new("UIGradient")
        PBG.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 14)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 12, 34)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 14)),
        })
        PBG.Rotation = 45
        PBG.Parent = PickBg

        local PickBox = Instance.new("Frame")
        PickBox.Size = UDim2.new(0, 620, 0, 380)
        PickBox.Position = UDim2.new(0.5, -310, 0.5, -190)
        PickBox.BackgroundColor3 = C.bg
        PickBox.BorderSizePixel = 0
        PickBox.ZIndex = 99992
        PickBox.Parent = PickBg

        local PBC = Instance.new("UICorner"); PBC.CornerRadius = UDim.new(0, 20); PBC.Parent = PickBox
        local PBS = Instance.new("UIStroke"); PBS.Color = C.stroke; PBS.Thickness = 1; PBS.Parent = PickBox
        local PBS2 = Instance.new("UIStroke"); PBS2.Color = C.accent; PBS2.Thickness = 2; PBS2.Transparency = 0.6; PBS2.Parent = PickBox

        task.spawn(function()
            while PBS2.Parent do
                local a = (math.sin(tick() * 1.2) + 1) / 2
                PBS2.Transparency = 0.3 + a * 0.5
                PBS2.Color = C.accent:Lerp(C.accent2, a)
                task.wait(0.05)
            end
        end)

        local PickTitle = Instance.new("TextLabel")
        PickTitle.Size = UDim2.new(1, -40, 0, 30)
        PickTitle.Position = UDim2.new(0, 20, 0, 25)
        PickTitle.BackgroundTransparency = 1
        PickTitle.Text = tr("pick_title")
        PickTitle.TextColor3 = C.white
        PickTitle.Font = Enum.Font.GothamBlack
        PickTitle.TextSize = 20
        PickTitle.ZIndex = 99993
        PickTitle.Parent = PickBox

        local PickDesc = Instance.new("TextLabel")
        PickDesc.Size = UDim2.new(1, -40, 0, 18)
        PickDesc.Position = UDim2.new(0, 20, 0, 58)
        PickDesc.BackgroundTransparency = 1
        PickDesc.Text = tr("pick_desc")
        PickDesc.TextColor3 = C.textDim
        PickDesc.Font = Enum.Font.Gotham
        PickDesc.TextSize = 12
        PickDesc.ZIndex = 99993
        PickDesc.Parent = PickBox

        local pickDone = false
        local function donePick(choice)
            if pickDone then return end
            pickDone = true
            if choice == "PC" then
                isMobile = false; deviceType = "PC"
            elseif choice == "MOBILE" then
                isMobile = true; deviceType = "MOBILE"
            else
                isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
                deviceType = isMobile and "MOBILE" or "PC"
            end
            pcall(function()
                if writefile then writefile("eon_device.txt", choice) end
            end)
            PickGui:Destroy()
        end

        local function mkCard(x, icon, title, sub, choice)
            local card = Instance.new("TextButton")
            card.Size = UDim2.new(0, 180, 0, 200)
            card.Position = UDim2.new(0, x, 0, 100)
            card.BackgroundColor3 = C.bg2
            card.BorderSizePixel = 0
            card.Text = ""
            card.AutoButtonColor = false
            card.ZIndex = 99993
            card.Parent = PickBox

            local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 16); c.Parent = card
            local s = Instance.new("UIStroke"); s.Color = C.stroke; s.Thickness = 1.5; s.Parent = card

            local ico = Instance.new("TextLabel")
            ico.Size = UDim2.new(1, 0, 0, 70)
            ico.Position = UDim2.new(0, 0, 0, 30)
            ico.BackgroundTransparency = 1
            ico.Text = icon
            ico.TextSize = 50
            ico.Font = Enum.Font.GothamBold
            ico.ZIndex = 99994
            ico.Parent = card

            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, 0, 0, 24)
            t.Position = UDim2.new(0, 0, 0, 115)
            t.BackgroundTransparency = 1
            t.Text = title
            t.TextColor3 = C.white
            t.Font = Enum.Font.GothamBold
            t.TextSize = 15
            t.ZIndex = 99994
            t.Parent = card

            local sb = Instance.new("TextLabel")
            sb.Size = UDim2.new(1, -20, 0, 40)
            sb.Position = UDim2.new(0, 10, 0, 142)
            sb.BackgroundTransparency = 1
            sb.Text = sub
            sb.TextColor3 = C.textDim
            sb.Font = Enum.Font.Gotham
            sb.TextSize = 10
            sb.TextWrapped = true
            sb.TextYAlignment = Enum.TextYAlignment.Top
            sb.ZIndex = 99994
            sb.Parent = card

            card.MouseEnter:Connect(function()
                TweenService:Create(card, TweenInfo.new(0.2), {
                    BackgroundColor3 = C.bgRowHov,
                    Size = UDim2.new(0, 184, 0, 204),
                    Position = UDim2.new(0, x - 2, 0, 98)
                }):Play()
                TweenService:Create(s, TweenInfo.new(0.2), {Color = C.accent, Transparency = 0}):Play()
            end)
            card.MouseLeave:Connect(function()
                TweenService:Create(card, TweenInfo.new(0.2), {
                    BackgroundColor3 = C.bg2,
                    Size = UDim2.new(0, 180, 0, 200),
                    Position = UDim2.new(0, x, 0, 100)
                }):Play()
                TweenService:Create(s, TweenInfo.new(0.2), {Color = C.stroke, Transparency = 0}):Play()
            end)
            card.MouseButton1Click:Connect(function()
                donePick(choice)
            end)
        end

        mkCard(20, "🖥", tr("pick_pc"), tr("pick_pc_sub"), "PC")
        mkCard(220, "📱", tr("pick_mob"), tr("pick_mob_sub"), "MOBILE")
        mkCard(420, "❓", tr("pick_auto"), tr("pick_auto_sub"), "AUTO")

        while not pickDone do task.wait(0.1) end
    end

    -- ЗАГРУЗКА
    local LoadGui = Instance.new("ScreenGui")
    LoadGui.Name = "EonMain"
    LoadGui.ResetOnSpawn = false
    LoadGui.IgnoreGuiInset = true
    LoadGui.DisplayOrder = 999990
    pcall(function() LoadGui.Parent = CoreGui end)
    if not LoadGui.Parent then LoadGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local LoadScreen = Instance.new("Frame")
    LoadScreen.Size = UDim2.new(1, 0, 1, 0)
    LoadScreen.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    LoadScreen.BorderSizePixel = 0
    LoadScreen.ZIndex = 999
    LoadScreen.Parent = LoadGui

    local LLogo = Instance.new("TextLabel")
    LLogo.Size = UDim2.new(0, 700, 0, 110)
    LLogo.Position = UDim2.new(0.5, -350, 0.5, -100)
    LLogo.BackgroundTransparency = 1
    LLogo.Text = "EON"
    LLogo.TextColor3 = C.white
    LLogo.Font = Enum.Font.GothamBlack
    LLogo.TextSize = 110
    LLogo.ZIndex = 1001
    LLogo.Parent = LoadScreen

    local LG = Instance.new("UIGradient")
    LG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.white),
        ColorSequenceKeypoint.new(0.5, C.accent),
        ColorSequenceKeypoint.new(1, C.accent2),
    })
    LG.Parent = LLogo

    local LSub = Instance.new("TextLabel")
    LSub.Size = UDim2.new(0, 700, 0, 24)
    LSub.Position = UDim2.new(0.5, -350, 0.5, 25)
    LSub.BackgroundTransparency = 1
    LSub.Text = "V I S U A L   ·   v11.0"
    LSub.TextColor3 = C.textDim
    LSub.Font = Enum.Font.Gotham
    LSub.TextSize = 11
    LSub.ZIndex = 1001
    LSub.Parent = LoadScreen

    local LBarWrap = Instance.new("Frame")
    LBarWrap.Size = UDim2.new(0, 440, 0, 4)
    LBarWrap.Position = UDim2.new(0.5, -220, 0.5, 80)
    LBarWrap.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    LBarWrap.BorderSizePixel = 0
    LBarWrap.ZIndex = 1001
    LBarWrap.Parent = LoadScreen
    local LBWC = Instance.new("UICorner"); LBWC.CornerRadius = UDim.new(1, 0); LBWC.Parent = LBarWrap

    local LFill = Instance.new("Frame")
    LFill.Size = UDim2.new(0, 0, 1, 0)
    LFill.BackgroundColor3 = C.accent
    LFill.BorderSizePixel = 0
    LFill.ZIndex = 1002
    LFill.Parent = LBarWrap
    local LFC = Instance.new("UICorner"); LFC.CornerRadius = UDim.new(1, 0); LFC.Parent = LFill
    local LFG = Instance.new("UIGradient")
    LFG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.accent),
        ColorSequenceKeypoint.new(0.5, C.accent2),
        ColorSequenceKeypoint.new(1, C.accent3),
    })
    LFG.Parent = LFill

    local LStatus = Instance.new("TextLabel")
    LStatus.Size = UDim2.new(0, 700, 0, 18)
    LStatus.Position = UDim2.new(0.5, -350, 0.5, 105)
    LStatus.BackgroundTransparency = 1
    LStatus.Text = tr("load_init") .. "..."
    LStatus.TextColor3 = C.textDim
    LStatus.Font = Enum.Font.Gotham
    LStatus.TextSize = 11
    LStatus.ZIndex = 1001
    LStatus.Parent = LoadScreen

    task.spawn(function()
        for _, s in ipairs({{p=0.4,t=tr("load_init")},{p=0.75,t=tr("load_mod")},{p=1.0,t=tr("load_ok")}}) do
            TweenService:Create(LFill, TweenInfo.new(0.4), {Size = UDim2.new(s.p, 0, 1, 0)}):Play()
            LStatus.Text = s.t .. "..."
            task.wait(0.45)
        end
        LStatus.Text = tr("load_ok") .. " ✓"
        LStatus.TextColor3 = C.success
        task.wait(0.4)
        LoadScreen:Destroy()
    end)

    -- МЕНЮ
    local MW, MH = 840, 540
    if isMobile then
        MW = math.min(750, workspace.CurrentCamera.ViewportSize.X - 40)
        MH = math.min(500, workspace.CurrentCamera.ViewportSize.Y - 100)
    end

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, MW, 0, MH)
    Main.Position = UDim2.new(0.5, -MW/2, 0.5, -MH/2)
    Main.BackgroundColor3 = C.bg
    Main.BorderSizePixel = 0
    Main.Active = false
    Main.Visible = false
    Main.ZIndex = 100
    Main.Parent = LoadGui

    local MCorner = Instance.new("UICorner"); MCorner.CornerRadius = UDim.new(0, 14); MCorner.Parent = Main
    local MStroke = Instance.new("UIStroke"); MStroke.Color = C.strokeHi; MStroke.Thickness = 1; MStroke.Transparency = 0.3; MStroke.Parent = Main

    -- Sidebar
    local SB = Instance.new("Frame")
    SB.Size = UDim2.new(0, 200, 1, 0)
    SB.BackgroundColor3 = C.bg2
    SB.BorderSizePixel = 0; SB.ZIndex = 101; SB.Parent = Main
    local SBC = Instance.new("UICorner"); SBC.CornerRadius = UDim.new(0, 14); SBC.Parent = SB
    local SBFix = Instance.new("Frame")
    SBFix.Size = UDim2.new(0, 14, 1, 0); SBFix.Position = UDim2.new(1, -14, 0, 0)
    SBFix.BackgroundColor3 = C.bg2; SBFix.BorderSizePixel = 0; SBFix.ZIndex = 101; SBFix.Parent = SB

    local SBLogo = Instance.new("Frame")
    SBLogo.Size = UDim2.new(1, 0, 0, 60)
    SBLogo.BackgroundColor3 = C.bg; SBLogo.BorderSizePixel = 0; SBLogo.ZIndex = 102; SBLogo.Parent = SB
    local SBLC = Instance.new("UICorner"); SBLC.CornerRadius = UDim.new(0, 14); SBLC.Parent = SBLogo
    local SBLFix = Instance.new("Frame")
    SBLFix.Size = UDim2.new(1, 0, 0, 14); SBLFix.Position = UDim2.new(0, 0, 1, -14)
    SBLFix.BackgroundColor3 = C.bg; SBLFix.BorderSizePixel = 0; SBLFix.ZIndex = 102; SBLFix.Parent = SBLogo

    local LIcon = Instance.new("Frame")
    LIcon.Size = UDim2.new(0, 32, 0, 32)
    LIcon.Position = UDim2.new(0, 14, 0.5, -16)
    LIcon.BackgroundColor3 = C.accent; LIcon.BorderSizePixel = 0
    LIcon.ZIndex = 103; LIcon.Parent = SBLogo
    local LIC = Instance.new("UICorner"); LIC.CornerRadius = UDim.new(0, 8); LIC.Parent = LIcon
    local LIG = Instance.new("UIGradient")
    LIG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, C.accent), ColorSequenceKeypoint.new(1, C.accent2)})
    LIG.Rotation = 45; LIG.Parent = LIcon
    local LIL = Instance.new("TextLabel")
    LIL.Size = UDim2.new(1, 0, 1, 0); LIL.BackgroundTransparency = 1
    LIL.Text = "E"; LIL.TextColor3 = Color3.fromRGB(255,255,255)
    LIL.Font = Enum.Font.GothamBlack; LIL.TextSize = 18
    LIL.ZIndex = 104; LIL.Parent = LIcon

    local SBName = Instance.new("TextLabel")
    SBName.Size = UDim2.new(1, -60, 0, 18); SBName.Position = UDim2.new(0, 54, 0, 14)
    SBName.BackgroundTransparency = 1; SBName.Text = "EON VISUAL"
    SBName.TextColor3 = C.white; SBName.Font = Enum.Font.GothamBlack
    SBName.TextSize = 13; SBName.TextXAlignment = Enum.TextXAlignment.Left
    SBName.ZIndex = 103; SBName.Parent = SBLogo

    local SBVer = Instance.new("TextLabel")
    SBVer.Size = UDim2.new(1, -60, 0, 14); SBVer.Position = UDim2.new(0, 54, 0, 32)
    SBVer.BackgroundTransparency = 1; SBVer.Text = "v11 · " .. deviceType
    SBVer.TextColor3 = C.textDim2; SBVer.Font = Enum.Font.Gotham
    SBVer.TextSize = 9; SBVer.TextXAlignment = Enum.TextXAlignment.Left
    SBVer.ZIndex = 103; SBVer.Parent = SBLogo

    local NavFrame = Instance.new("Frame")
    NavFrame.Size = UDim2.new(1, 0, 1, -140)
    NavFrame.Position = UDim2.new(0, 0, 0, 66)
    NavFrame.BackgroundTransparency = 1; NavFrame.ZIndex = 102; NavFrame.Parent = SB
    local NavLayout = Instance.new("UIListLayout")
    NavLayout.Padding = UDim.new(0, 3); NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NavLayout.Parent = NavFrame

    local UserFrame = Instance.new("Frame")
    UserFrame.Size = UDim2.new(1, -20, 0, 56)
    UserFrame.Position = UDim2.new(0, 10, 1, -66)
    UserFrame.BackgroundColor3 = C.bg; UserFrame.BorderSizePixel = 0
    UserFrame.ZIndex = 102; UserFrame.Parent = SB
    local UFC = Instance.new("UICorner"); UFC.CornerRadius = UDim.new(0, 10); UFC.Parent = UserFrame

    local UserAvatar = Instance.new("ImageLabel")
    UserAvatar.Size = UDim2.new(0, 34, 0, 34); UserAvatar.Position = UDim2.new(0, 11, 0, 11)
    UserAvatar.BackgroundColor3 = C.bgRow; UserAvatar.BorderSizePixel = 0
    UserAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=100&h=100"
    UserAvatar.ZIndex = 103; UserAvatar.Parent = UserFrame
    local UAC = Instance.new("UICorner"); UAC.CornerRadius = UDim.new(1, 0); UAC.Parent = UserAvatar

    local UserName = Instance.new("TextLabel")
    UserName.Size = UDim2.new(1, -55, 0, 16); UserName.Position = UDim2.new(0, 52, 0, 12)
    UserName.BackgroundTransparency = 1; UserName.Text = LocalPlayer.DisplayName or LocalPlayer.Name
    UserName.TextColor3 = C.text; UserName.Font = Enum.Font.GothamBold
    UserName.TextSize = 12; UserName.TextXAlignment = Enum.TextXAlignment.Left
    UserName.ZIndex = 103; UserName.Parent = UserFrame

    -- Topbar
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, -200, 0, 60); TopBar.Position = UDim2.new(0, 200, 0, 0)
    TopBar.BackgroundColor3 = C.bg2; TopBar.BorderSizePixel = 0; TopBar.Active = true
    TopBar.ZIndex = 101; TopBar.Parent = Main
    local TBC = Instance.new("UICorner"); TBC.CornerRadius = UDim.new(0, 14); TBC.Parent = TopBar
    local TBFix = Instance.new("Frame")
    TBFix.Size = UDim2.new(1, 0, 0, 14); TBFix.Position = UDim2.new(0, 0, 1, -14)
    TBFix.BackgroundColor3 = C.bg2; TBFix.BorderSizePixel = 0; TBFix.ZIndex = 101; TBFix.Parent = TopBar
    local TBDiv = Instance.new("Frame")
    TBDiv.Size = UDim2.new(1, 0, 0, 1); TBDiv.Position = UDim2.new(0, 0, 1, -1)
    TBDiv.BackgroundColor3 = C.stroke; TBDiv.BorderSizePixel = 0; TBDiv.ZIndex = 102; TBDiv.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 400, 0, 22); Title.Position = UDim2.new(0, 20, 0, 12)
    Title.BackgroundTransparency = 1; Title.Text = "EON VISUAL"
    Title.TextColor3 = C.text; Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15; Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 102; Title.Parent = TopBar

    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0, 400, 0, 14); SubTitle.Position = UDim2.new(0, 20, 0, 34)
    SubTitle.BackgroundTransparency = 1; SubTitle.Text = "Premium Roblox Visuals · " .. deviceType
    SubTitle.TextColor3 = C.textDim2; SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 10; SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.ZIndex = 102; SubTitle.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 36, 0, 36); CloseBtn.Position = UDim2.new(1, -48, 0, 12)
    CloseBtn.BackgroundColor3 = C.bgRow; CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"; CloseBtn.TextColor3 = C.textDim
    CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 16
    CloseBtn.AutoButtonColor = false
    CloseBtn.ZIndex = 103; CloseBtn.Parent = TopBar
    local CBC = Instance.new("UICorner"); CBC.CornerRadius = UDim.new(0, 8); CBC.Parent = CloseBtn

    -- Drag
    local dragging, dragStart, startPos = false, nil, nil
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Content
    local ContentScroll = Instance.new("ScrollingFrame")
    ContentScroll.Size = UDim2.new(1, -220, 1, -80)
    ContentScroll.Position = UDim2.new(0, 210, 0, 70)
    ContentScroll.BackgroundTransparency = 1; ContentScroll.BorderSizePixel = 0
    ContentScroll.ScrollBarThickness = 4; ContentScroll.ScrollBarImageColor3 = C.strokeHi
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0); ContentScroll.ZIndex = 102
    ContentScroll.Parent = Main

    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 6); ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Parent = ContentScroll

    local function updateCanvas()
        ContentScroll.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
    end

    local function clearContent()
        for _, c in ipairs(ContentScroll:GetChildren()) do
            if c:IsA("GuiObject") then c:Destroy() end
        end
    end

    local function mkSection(text, order)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, -10, 0, 30); f.BackgroundTransparency = 1
        f.LayoutOrder = order; f.ZIndex = 103; f.Parent = ContentScroll
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 3, 0, 14); dot.Position = UDim2.new(0, 4, 0.5, -7)
        dot.BackgroundColor3 = C.accent; dot.BorderSizePixel = 0
        dot.ZIndex = 104; dot.Parent = f
        local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 1, 0); lbl.Position = UDim2.new(0, 16, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = text
        lbl.TextColor3 = C.textDim; lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 10; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 103; lbl.Parent = f
        task.defer(updateCanvas)
    end

    local function mkGrid(order)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, -10, 0, 0); f.BackgroundTransparency = 1
        f.LayoutOrder = order; f.ZIndex = 103; f.Parent = ContentScroll
        local grid = Instance.new("UIGridLayout")
        grid.CellSize = UDim2.new(0.5, -5, 0, 38)
        grid.CellPadding = UDim2.new(0, 10, 0, 8)
        grid.SortOrder = Enum.SortOrder.LayoutOrder
        grid.Parent = f
        local function upd()
            local count = 0
            for _, c in ipairs(f:GetChildren()) do if c:IsA("GuiObject") then count = count + 1 end end
            f.Size = UDim2.new(1, -10, 0, math.ceil(count/2) * 46)
            task.defer(updateCanvas)
        end
        f.ChildAdded:Connect(function() task.defer(upd) end)
        f.ChildRemoved:Connect(function() task.defer(upd) end)
        task.defer(upd)
        return f
    end

    local function mkToggle(parent, label, state, callback, order)
        local row = Instance.new("Frame")
        row.BackgroundColor3 = C.bgRow; row.BorderSizePixel = 0
        row.LayoutOrder = order or 0; row.ZIndex = 104; row.Parent = parent
        local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row
        local rs = Instance.new("UIStroke"); rs.Color = C.stroke; rs.Thickness = 1; rs.Transparency = 0.5; rs.Parent = row

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -70, 1, 0); lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = label
        lbl.TextColor3 = C.text; lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 105; lbl.Parent = row

        local swBg = Instance.new("Frame")
        swBg.Size = UDim2.new(0, 36, 0, 20); swBg.Position = UDim2.new(1, -48, 0.5, -10)
        swBg.BackgroundColor3 = state and C.accent or C.bgSlider
        swBg.BorderSizePixel = 0; swBg.ZIndex = 105; swBg.Parent = row
        local swC = Instance.new("UICorner"); swC.CornerRadius = UDim.new(1, 0); swC.Parent = swBg
        local swGrad = Instance.new("UIGradient")
        swGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, C.accent), ColorSequenceKeypoint.new(1, C.accent2)})
        swGrad.Enabled = state; swGrad.Parent = swBg

        local swDot = Instance.new("Frame")
        swDot.Size = UDim2.new(0, 14, 0, 14)
        swDot.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        swDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255); swDot.BorderSizePixel = 0
        swDot.ZIndex = 106; swDot.Parent = swBg
        local sdC = Instance.new("UICorner"); sdC.CornerRadius = UDim.new(1, 0); sdC.Parent = swDot

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1
        btn.Text = ""; btn.ZIndex = 107; btn.Parent = row

        local isOn = state
        btn.MouseButton1Click:Connect(function()
            isOn = not isOn
            TweenService:Create(swBg, TweenInfo.new(0.25, Enum.EasingStyle.Back), {BackgroundColor3 = isOn and C.accent or C.bgSlider}):Play()
            swGrad.Enabled = isOn
            TweenService:Create(swDot, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                Position = isOn and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            }):Play()
            callback(isOn)
        end)
        btn.MouseEnter:Connect(function()
            TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bgRowHov}):Play()
            TweenService:Create(rs, TweenInfo.new(0.15), {Color = C.strokeHi, Transparency = 0}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bgRow}):Play()
            TweenService:Create(rs, TweenInfo.new(0.15), {Color = C.stroke, Transparency = 0.5}):Play()
        end)
    end

    local function mkButton(parent, label, callback, order)
        local row = Instance.new("Frame")
        row.BackgroundColor3 = C.bgRow; row.BorderSizePixel = 0
        row.LayoutOrder = order or 0; row.ZIndex = 104; row.Parent = parent
        local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row
        local rs = Instance.new("UIStroke"); rs.Color = C.stroke; rs.Thickness = 1; rs.Transparency = 0.5; rs.Parent = row

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 1, 0); lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = label
        lbl.TextColor3 = C.text; lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 105; lbl.Parent = row

        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 20, 1, 0); arrow.Position = UDim2.new(1, -26, 0, 0)
        arrow.BackgroundTransparency = 1; arrow.Text = "›"
        arrow.TextColor3 = C.textDim2; arrow.Font = Enum.Font.GothamBold
        arrow.TextSize = 16; arrow.ZIndex = 105; arrow.Parent = row

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1
        btn.Text = ""; btn.ZIndex = 107; btn.Parent = row

        btn.MouseEnter:Connect(function()
            TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bgRowHov}):Play()
            TweenService:Create(rs, TweenInfo.new(0.15), {Color = C.strokeHi, Transparency = 0}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bgRow}):Play()
            TweenService:Create(rs, TweenInfo.new(0.15), {Color = C.stroke, Transparency = 0.5}):Play()
        end)
        btn.MouseButton1Click:Connect(callback)
    end

    local toasts = {}
    local function notify(text)
        local t = Instance.new("Frame")
        t.Size = UDim2.new(0, 260, 0, 42); t.Position = UDim2.new(1, 20, 0, 20)
        t.BackgroundColor3 = C.bg; t.BorderSizePixel = 0
        t.ZIndex = 999998; t.Parent = LoadGui
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = t
        local s = Instance.new("UIStroke"); s.Color = C.strokeHi; s.Thickness = 1; s.Transparency = 0.3; s.Parent = t
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 6, 0, 6); dot.Position = UDim2.new(0, 14, 0.5, -3)
        dot.BackgroundColor3 = C.accent; dot.BorderSizePixel = 0
        dot.ZIndex = 999999; dot.Parent = t
        local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -34, 1, 0); lbl.Position = UDim2.new(0, 28, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = text
        lbl.TextColor3 = C.text; lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 999999; lbl.Parent = t

        for _, old in ipairs(toasts) do
            TweenService:Create(old, TweenInfo.new(0.25), {Position = old.Position + UDim2.new(0, 0, 0, 48)}):Play()
        end
        table.insert(toasts, t)
        TweenService:Create(t, TweenInfo.new(0.35, Enum.EasingStyle.Back), {Position = UDim2.new(1, -280, 0, 20)}):Play()
        task.delay(2.5, function()
            TweenService:Create(t, TweenInfo.new(0.3), {Position = UDim2.new(1, 20, 0, 20), BackgroundTransparency = 1}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 1}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            TweenService:Create(dot, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.35)
            t:Destroy()
            for i, x in ipairs(toasts) do if x == t then table.remove(toasts, i) break end end
        end)
    end

    local st = {sky=nil, fog=false, bloom=false, cc=false, dof=false, blur=false, sunrays=false,
        charGlow=false, charRGB=false, charTrail=false, charSparkles=false, charFire=false}

    local skyList = {
        {id="space",k="sky_space"},{id="sunset",k="sky_sunset"},{id="night",k="sky_night"},
        {id="dawn",k="sky_dawn"},{id="storm",k="sky_storm"},{id="clear",k="sky_clear"},
        {id="nebula",k="sky_nebula"},{id="off",k="sky_off"},
    }

    local function applySky(id)
        for _, v in ipairs(Lighting:GetChildren()) do
            if v.Name == "EonSky" then v:Destroy() end
        end
        if id == "off" then return end
        local sky = Instance.new("Sky")
        sky.Name = "EonSky"
        if id == "space" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime = 0
        elseif id == "sunset" then
            sky.SkyboxBk="rbxassetid://188705813"; sky.SkyboxDn="rbxassetid://188705788"
            sky.SkyboxFt="rbxassetid://188705800"; sky.SkyboxLf="rbxassetid://188705834"
            sky.SkyboxRt="rbxassetid://188705821"; sky.SkyboxUp="rbxassetid://188705845"
            Lighting.ClockTime = 18
        elseif id == "night" then
            sky.SkyboxBk="rbxassetid://12064107"; sky.SkyboxDn="rbxassetid://12064152"
            sky.SkyboxFt="rbxassetid://12064121"; sky.SkyboxLf="rbxassetid://12063984"
            sky.SkyboxRt="rbxassetid://12064114"; sky.SkyboxUp="rbxassetid://12063943"
            Lighting.ClockTime = 0
        elseif id == "dawn" then
            sky.SkyboxBk="rbxassetid://188705813"; sky.SkyboxDn="rbxassetid://188705788"
            sky.SkyboxFt="rbxassetid://188705800"; sky.SkyboxLf="rbxassetid://188705834"
            sky.SkyboxRt="rbxassetid://188705821"; sky.SkyboxUp="rbxassetid://188705845"
            Lighting.ClockTime = 6
        elseif id == "storm" then
            sky.SkyboxBk="rbxassetid://570557023"; sky.SkyboxDn="rbxassetid://570557020"
            sky.SkyboxFt="rbxassetid://570557026"; sky.SkyboxLf="rbxassetid://570557029"
            sky.SkyboxRt="rbxassetid://570557017"; sky.SkyboxUp="rbxassetid://570557032"
            Lighting.ClockTime = 15
        elseif id == "clear" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime = 14
        elseif id == "nebula" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime = 22
        end
        sky.Parent = Lighting
    end

    local charFX = {}
    local function clearCharFX()
        for _, o in ipairs(charFX) do pcall(function() o:Destroy() end) end
        charFX = {}
    end
    local function applyCharFX()
        clearCharFX()
        local ch = LocalPlayer.Character
        if not ch then return end
        local hrp = ch:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if st.charGlow then
            local l = Instance.new("PointLight")
            l.Brightness=3; l.Range=15; l.Color=Color3.fromRGB(255,255,255); l.Parent=hrp
            table.insert(charFX, l)
        end
        if st.charRGB then
            local l = Instance.new("PointLight")
            l.Brightness=4; l.Range=18; l.Parent=hrp
            table.insert(charFX, l)
            task.spawn(function()
                while l.Parent do
                    l.Color = Color3.fromHSV((tick()*0.3)%1, 0.9, 1)
                    task.wait(0.05)
                end
            end)
        end
        if st.charTrail then
            local a0 = Instance.new("Attachment"); a0.Position=Vector3.new(1,0,0); a0.Parent=hrp
            local a1 = Instance.new("Attachment"); a1.Position=Vector3.new(-1,0,0); a1.Parent=hrp
            local tr = Instance.new("Trail")
            tr.Attachment0=a0; tr.Attachment1=a1; tr.Lifetime=0.5
            tr.Color = ColorSequence.new(C.white)
            tr.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(1, 1)
            })
            tr.Parent = hrp
            table.insert(charFX, a0); table.insert(charFX, a1); table.insert(charFX, tr)
        end
        if st.charSparkles then
            local s = Instance.new("Sparkles"); s.SparkleColor=Color3.fromRGB(255,255,255); s.Parent=hrp
            table.insert(charFX, s)
        end
        if st.charFire then
            local f = Instance.new("Fire"); f.Size=4; f.Heat=8
            f.Color=Color3.fromRGB(255,120,50); f.SecondaryColor=Color3.fromRGB(255,200,100)
            f.Parent = hrp
            table.insert(charFX, f)
        end
    end
    LocalPlayer.CharacterAdded:Connect(function() task.wait(1) applyCharFX() end)

    local function fmtDate(ts)
        if not ts or ts == 0 then return "—" end
        local d = os.date("*t", ts)
        return string.format("%02d.%02d.%04d", d.day, d.month, d.year)
    end

    local categories = {
        {id="world",icon="🌍",k="cat_world"},
        {id="visuals",icon="✨",k="cat_visuals"},
        {id="player",icon="👤",k="cat_player"},
        {id="sub",icon="⭐",k="cat_sub"},
        {id="settings",icon="⚙",k="cat_settings"},
    }
    local catButtons = {}
    local activeCat = "world"

    local renderContent
    renderContent = function()
        clearContent()

        if activeCat == "world" then
            mkSection(tr("sec_sky"), 1)
            local g1 = mkGrid(2)
            for i, s in ipairs(skyList) do
                mkToggle(g1, tr(s.k), st.sky == s.id, function(on)
                    if on then
                        applySky(s.id); st.sky = s.id
                        notify("Небо: " .. tr(s.k))
                        renderContent()
                    else
                        if st.sky == s.id then
                            for _, v in ipairs(Lighting:GetChildren()) do
                                if v.Name == "EonSky" then v:Destroy() end
                            end
                            st.sky = nil
                            notify("Небо выключено")
                            renderContent()
                        end
                    end
                end, i)
            end
            mkSection(tr("sec_time"), 20)
            local g2 = mkGrid(21)
            mkButton(g2, tr("time_day"), function() Lighting.ClockTime=14 notify(tr("time_day")) end, 1)
            mkButton(g2, tr("time_evening"), function() Lighting.ClockTime=18 notify(tr("time_evening")) end, 2)
            mkButton(g2, tr("time_night"), function() Lighting.ClockTime=0 notify(tr("time_night")) end, 3)

        elseif activeCat == "visuals" then
            mkSection(tr("sec_fx"), 1)
            local g = mkGrid(2)
            local fxList = {
                {k="fog", on=st.fog, name="EonFog", mk=function()
                    local a = Instance.new("Atmosphere")
                    a.Density=0.4; a.Offset=0.25
                    a.Color=Color3.fromRGB(200,200,220)
                    a.Decay=Color3.fromRGB(120,100,140)
                    return a
                end, set=function(v) st.fog=v end},
                {k="bloom", on=st.bloom, name="EonBloom", mk=function()
                    local b = Instance.new("BloomEffect"); b.Intensity=1.5; b.Size=32; b.Threshold=0.8; return b
                end, set=function(v) st.bloom=v end},
                {k="cc", on=st.cc, name="EonCC", mk=function()
                    local c = Instance.new("ColorCorrectionEffect")
                    c.Brightness=0.05; c.Contrast=0.15; c.Saturation=0.25; return c
                end, set=function(v) st.cc=v end},
                {k="dof", on=st.dof, name="EonDOF", mk=function()
                    local d = Instance.new("DepthOfFieldEffect")
                    d.FarIntensity=0.3; d.FocusDistance=50; d.InFocusRadius=30; return d
                end, set=function(v) st.dof=v end},
                {k="blur", on=st.blur, name="EonBlur", mk=function()
                    local b = Instance.new("BlurEffect"); b.Size=8; return b
                end, set=function(v) st.blur=v end},
                {k="sunrays", on=st.sunrays, name="EonSun", mk=function()
                    local s = Instance.new("SunRaysEffect"); s.Intensity=0.15; s.Spread=1; return s
                end, set=function(v) st.sunrays=v end},
            }
            for i, fx in ipairs(fxList) do
                mkToggle(g, tr(fx.k), fx.on, function(on)
                    fx.set(on)
                    local ex = Lighting:FindFirstChild(fx.name)
                    if on then
                        if not ex then local o = fx.mk(); o.Name = fx.name; o.Parent = Lighting end
                    else
                        if ex then ex:Destroy() end
                    end
                    notify(tr(fx.k) .. ": " .. (on and "ВКЛ" or "ВЫКЛ"))
                end, i)
            end

        elseif activeCat == "player" then
            mkSection(tr("sec_char"), 1)
            local g = mkGrid(2)
            local list = {
                {k="charGlow", on=st.charGlow, set=function(v) st.charGlow=v end},
                {k="charRGB", on=st.charRGB, set=function(v) st.charRGB=v end},
                {k="charTrail", on=st.charTrail, set=function(v) st.charTrail=v end},
                {k="charSparkles", on=st.charSparkles, set=function(v) st.charSparkles=v end},
                {k="charFire", on=st.charFire, set=function(v) st.charFire=v end},
            }
            for i, e in ipairs(list) do
                mkToggle(g, tr(e.k), e.on, function(on)
                    e.set(on); applyCharFX()
                    notify(tr(e.k) .. ": " .. (on and "ВКЛ" or "ВЫКЛ"))
                end, i)
            end

        elseif activeCat == "sub" then
            mkSection(tr("sub_active_subs"), 1)
            if #currentSubs == 0 then
                local empty = Instance.new("Frame")
                empty.Size = UDim2.new(1, -10, 0, 110)
                empty.BackgroundColor3 = C.bgRow
                empty.BorderSizePixel = 0
                empty.LayoutOrder = 3
                empty.ZIndex = 103
                empty.Parent = ContentScroll
                local ec = Instance.new("UICorner"); ec.CornerRadius = UDim.new(0, 10); ec.Parent = empty
                local el = Instance.new("TextLabel")
                el.Size = UDim2.new(1, -20, 1, 0); el.Position = UDim2.new(0, 10, 0, 0)
                el.BackgroundTransparency = 1
                el.Text = tr("sub_none") .. "\n" .. tr("sub_none_desc")
                el.TextColor3 = C.textDim
                el.Font = Enum.Font.Gotham
                el.TextSize = 12
                el.TextYAlignment = Enum.TextYAlignment.Center
                el.ZIndex = 104
                el.Parent = empty
            else
                local order = 3
                for _, sub in ipairs(currentSubs) do
                    local isLifetime = sub.lifetime
                    local isExpired = false
                    if not isLifetime and sub.expiresAt and sub.expiresAt > 0 then
                        isExpired = sub.expiresAt <= os.time()
                    end
                    local isActive = isLifetime or not isExpired

                    local card = Instance.new("Frame")
                    card.Size = UDim2.new(1, -10, 0, 200)
                    card.BackgroundColor3 = C.bgRow
                    card.BorderSizePixel = 0
                    card.LayoutOrder = order
                    card.ZIndex = 103
                    card.Parent = ContentScroll
                    order = order + 1

                    local cc2 = Instance.new("UICorner"); cc2.CornerRadius = UDim.new(0, 12); cc2.Parent = card
                    local cs2 = Instance.new("UIStroke")
                    cs2.Color = isActive and (isLifetime and C.warning or C.success) or C.danger
                    cs2.Thickness = 1.5; cs2.Transparency = 0.5; cs2.Parent = card

                    local sideBar = Instance.new("Frame")
                    sideBar.Size = UDim2.new(0, 4, 1, -24)
                    sideBar.Position = UDim2.new(0, 0, 0, 12)
                    sideBar.BackgroundColor3 = isActive and (isLifetime and C.warning or C.success) or C.danger
                    sideBar.BorderSizePixel = 0; sideBar.ZIndex = 104; sideBar.Parent = card
                    local sbc = Instance.new("UICorner"); sbc.CornerRadius = UDim.new(1, 0); sbc.Parent = sideBar

                    local prodLbl = Instance.new("TextLabel")
                    prodLbl.Size = UDim2.new(1, -170, 0, 22)
                    prodLbl.Position = UDim2.new(0, 22, 0, 14)
                    prodLbl.BackgroundTransparency = 1
                    prodLbl.Text = sub.product
                    prodLbl.TextColor3 = C.white
                    prodLbl.Font = Enum.Font.GothamBlack
                    prodLbl.TextSize = 16
                    prodLbl.TextXAlignment = Enum.TextXAlignment.Left
                    prodLbl.ZIndex = 104; prodLbl.Parent = card

                    local badgeBg = Instance.new("Frame")
                    badgeBg.Size = UDim2.new(0, 110, 0, 24)
                    badgeBg.Position = UDim2.new(1, -124, 0, 14)
                    badgeBg.BackgroundColor3 = isActive and (isLifetime and C.warning or C.success) or C.danger
                    badgeBg.BackgroundTransparency = 0.85
                    badgeBg.BorderSizePixel = 0; badgeBg.ZIndex = 104; badgeBg.Parent = card
                    local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(1, 0); bbc.Parent = badgeBg
                    local badgeText = Instance.new("TextLabel")
                    badgeText.Size = UDim2.new(1, 0, 1, 0)
                    badgeText.BackgroundTransparency = 1
                    if isLifetime then badgeText.Text = "∞ " .. tr("sub_lifetime")
                    elseif isActive then badgeText.Text = "● " .. tr("sub_active")
                    else badgeText.Text = "● " .. tr("sub_expired") end
                    badgeText.TextColor3 = isActive and (isLifetime and C.warning or C.success) or C.danger
                    badgeText.Font = Enum.Font.GothamBold
                    badgeText.TextSize = 9
                    badgeText.ZIndex = 105; badgeText.Parent = badgeBg

                    local keyLbl = Instance.new("TextLabel")
                    keyLbl.Size = UDim2.new(1, -40, 0, 14)
                    keyLbl.Position = UDim2.new(0, 22, 0, 44)
                    keyLbl.BackgroundTransparency = 1
                    keyLbl.Text = tr("sub_key") .. ": " .. tostring(sub.key)
                    keyLbl.TextColor3 = C.textDim2
                    keyLbl.Font = Enum.Font.Gotham
                    keyLbl.TextSize = 10
                    keyLbl.TextXAlignment = Enum.TextXAlignment.Left
                    keyLbl.ZIndex = 104; keyLbl.Parent = card

                    local boughtLbl = Instance.new("TextLabel")
                    boughtLbl.Size = UDim2.new(1, -40, 0, 14)
                    boughtLbl.Position = UDim2.new(0, 22, 0, 70)
                    boughtLbl.BackgroundTransparency = 1
                    boughtLbl.Text = tr("sub_bought") .. ": " .. fmtDate(sub.activatedAt)
                    boughtLbl.TextColor3 = C.textDim
                    boughtLbl.Font = Enum.Font.Gotham
                    boughtLbl.TextSize = 10
                    boughtLbl.TextXAlignment = Enum.TextXAlignment.Left
                    boughtLbl.ZIndex = 104; boughtLbl.Parent = card

                    local expLbl = Instance.new("TextLabel")
                    expLbl.Size = UDim2.new(1, -40, 0, 14)
                    expLbl.Position = UDim2.new(0, 22, 0, 88)
                    expLbl.BackgroundTransparency = 1
                    expLbl.Text = tr("sub_expires") .. ": " .. (isLifetime and "∞" or fmtDate(sub.expiresAt))
                    expLbl.TextColor3 = C.textDim
                    expLbl.Font = Enum.Font.Gotham
                    expLbl.TextSize = 10
                    expLbl.TextXAlignment = Enum.TextXAlignment.Left
                    expLbl.ZIndex = 104; expLbl.Parent = card

                    local daysLbl = Instance.new("TextLabel")
                    daysLbl.Size = UDim2.new(1, -40, 0, 20)
                    daysLbl.Position = UDim2.new(0, 22, 0, 115)
                    daysLbl.BackgroundTransparency = 1
                    if isLifetime then
                        daysLbl.Text = "∞ " .. tr("sub_forever")
                        daysLbl.TextColor3 = C.warning
                    else
                        local diff = sub.expiresAt - os.time()
                        if diff <= 0 then
                            daysLbl.Text = "● " .. tr("sub_expired")
                            daysLbl.TextColor3 = C.danger
                        else
                            local dd = math.floor(diff / 86400)
                            daysLbl.Text = "Осталось: " .. dd .. " дней"
                            daysLbl.TextColor3 = C.text
                        end
                    end
                    daysLbl.Font = Enum.Font.GothamBold
                    daysLbl.TextSize = 11
                    daysLbl.TextXAlignment = Enum.TextXAlignment.Left
                    daysLbl.ZIndex = 104; daysLbl.Parent = card

                    if not isLifetime then
                        local daysVal = math.max(0, math.floor((sub.expiresAt - os.time()) / 86400))
                        local percent = 0
                        if sub.days > 0 then percent = math.clamp(daysVal / sub.days, 0, 1) end
                        local barBg = Instance.new("Frame")
                        barBg.Size = UDim2.new(1, -44, 0, 8); barBg.Position = UDim2.new(0, 22, 0, 145)
                        barBg.BackgroundColor3 = C.bgSlider; barBg.BorderSizePixel = 0
                        barBg.ZIndex = 104; barBg.Parent = card
                        local bbc2 = Instance.new("UICorner"); bbc2.CornerRadius = UDim.new(1, 0); bbc2.Parent = barBg
                        local barFill = Instance.new("Frame")
                        barFill.Size = UDim2.new(percent, 0, 1, 0)
                        barFill.BackgroundColor3 = percent < 0.2 and C.danger or (percent < 0.5 and C.warning or C.success)
                        barFill.BorderSizePixel = 0; barFill.ZIndex = 105; barFill.Parent = barBg
                        local bfc2 = Instance.new("UICorner"); bfc2.CornerRadius = UDim.new(1, 0); bfc2.Parent = barFill
                    end
                end
            end
            task.defer(updateCanvas)

        elseif activeCat == "settings" then
            mkSection(tr("sec_lang"), 1)
            local g1 = mkGrid(2)
            mkToggle(g1, "🇷🇺 " .. tr("lang_ru"), Lang == "ru", function(on)
                if on then
                    Lang = "ru"
                    for _, b in ipairs(catButtons) do b.label.Text = tr(b.key) end
                    renderContent()
                    notify("Язык: Русский")
                end
            end, 1)
            mkToggle(g1, "🇺🇸 " .. tr("lang_en"), Lang == "en", function(on)
                if on then
                    Lang = "en"
                    for _, b in ipairs(catButtons) do b.label.Text = tr(b.key) end
                    renderContent()
                    notify("Language: English")
                end
            end, 2)
            mkSection(tr("sec_reset"), 20)
            local g2 = mkGrid(21)
            mkButton(g2, tr("reset"), function()
                for _, v in ipairs(Lighting:GetChildren()) do
                    if v.Name:sub(1,3) == "Eon" then v:Destroy() end
                end
                clearCharFX()
                for k in pairs(st) do if type(st[k]) == "boolean" then st[k] = false end end
                st.sky = nil
                notify(tr("reset"))
                renderContent()
            end, 1)
            mkSection("EON VISUAL v11 · eon.website", 40)
        end
    end

    local renderSidebar = function()
        for _, b in ipairs(catButtons) do
            if b.id == activeCat then
                TweenService:Create(b.row, TweenInfo.new(0.25), {BackgroundColor3 = C.bgRow}):Play()
                b.icon.TextColor3 = C.white
                b.label.TextColor3 = C.white
                b.bar.Visible = true
            else
                TweenService:Create(b.row, TweenInfo.new(0.25), {BackgroundColor3 = C.bg2}):Play()
                b.icon.TextColor3 = C.textDim
                b.label.TextColor3 = C.textDim
                b.bar.Visible = false
            end
        end
    end

    local selectCat = function(id)
        activeCat = id
        renderSidebar()
        renderContent()
    end

    for i, cat in ipairs(categories) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -20, 0, 40); row.Position = UDim2.new(0, 10, 0, 0)
        row.BackgroundColor3 = C.bg2; row.BorderSizePixel = 0
        row.LayoutOrder = i; row.ZIndex = 103; row.Parent = NavFrame
        local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 3, 0, 20); bar.Position = UDim2.new(0, 0, 0.5, -10)
        bar.BackgroundColor3 = C.accent; bar.BorderSizePixel = 0
        bar.ZIndex = 105; bar.Visible = false; bar.Parent = row
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(1, 0); bc.Parent = bar
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 28, 1, 0); icon.Position = UDim2.new(0, 12, 0, 0)
        icon.BackgroundTransparency = 1; icon.Text = cat.icon
        icon.TextColor3 = C.textDim; icon.Font = Enum.Font.Gotham
        icon.TextSize = 15; icon.ZIndex = 104; icon.Parent = row
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 1, 0); label.Position = UDim2.new(0, 46, 0, 0)
        label.BackgroundTransparency = 1; label.Text = tr(cat.k)
        label.TextColor3 = C.textDim; label.Font = Enum.Font.Gotham
        label.TextSize = 12; label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 104; label.Parent = row
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1
        btn.Text = ""; btn.ZIndex = 106; btn.Parent = row
        btn.MouseEnter:Connect(function()
            if activeCat ~= cat.id then TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bgRowHov}):Play() end
        end)
        btn.MouseLeave:Connect(function()
            if activeCat ~= cat.id then TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = C.bg2}):Play() end
        end)
        btn.MouseButton1Click:Connect(function() selectCat(cat.id) end)
        table.insert(catButtons, {id=cat.id, row=row, icon=icon, label=label, bar=bar, key=cat.k})
    end

    renderSidebar()
    renderContent()

    local opened = false

    local function doOpen()
        opened = true
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
        Main.BackgroundTransparency = 1
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, MW, 0, MH),
            Position = UDim2.new(0.5, -MW/2, 0.5, -MH/2),
            BackgroundTransparency = 0,
        }):Play()
    end

    local function doClose()
        opened = false
        TweenService:Create(Main, TweenInfo.new(0.25), {
            Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), BackgroundTransparency = 1
        }):Play()
        task.wait(0.26)
        Main.Visible = false
    end

    CloseBtn.MouseButton1Click:Connect(doClose)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightShift then
            if opened then doClose() else doOpen() end
        end
    end)

    -- Кнопка для мобилки
    if isMobile then
        local openBtn = Instance.new("TextButton")
        openBtn.Size = UDim2.new(0, 64, 0, 64)
        openBtn.Position = UDim2.new(1, -90, 1, -100)
        openBtn.BackgroundColor3 = C.accent
        openBtn.BorderSizePixel = 0
        openBtn.Text = "E"
        openBtn.TextColor3 = Color3.fromRGB(255,255,255)
        openBtn.Font = Enum.Font.GothamBlack
        openBtn.TextSize = 28
        openBtn.AutoButtonColor = false
        openBtn.ZIndex = 999991
        openBtn.Active = true
        openBtn.Parent = LoadGui
        local ObC = Instance.new("UICorner"); ObC.CornerRadius = UDim.new(1, 0); ObC.Parent = openBtn
        local ObG = Instance.new("UIGradient")
        ObG.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.accent),
            ColorSequenceKeypoint.new(0.5, C.accent2),
            ColorSequenceKeypoint.new(1, C.accent3),
        })
        ObG.Rotation = 45; ObG.Parent = openBtn

        local dragB, dragBStart, startBPos = false, nil, nil
        openBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragB = true; dragBStart = input.Position; startBPos = openBtn.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragB and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
                local d = input.Position - dragBStart
                openBtn.Position = UDim2.new(startBPos.X.Scale, startBPos.X.Offset + d.X, startBPos.Y.Scale, startBPos.Y.Offset + d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragB = false
            end
        end)
        openBtn.MouseButton1Click:Connect(function()
            if opened then doClose() else doOpen() end
        end)
    end

    -- АВТО-ОТКРЫТИЕ
    task.wait(2.8)
    notify("EON VISUAL загружен ✓")
    task.wait(0.5)
    doOpen()

    print("[EON VISUAL v11] Loaded ✓ Device:", deviceType)
end
