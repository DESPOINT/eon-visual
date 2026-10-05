-- EON VISUAL v15
local Players=game:GetService("Players")
local TS=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
local UIS=game:GetService("UserInputService")
local CG=game:GetService("CoreGui")
local HS=game:GetService("HttpService")
local SS=game:GetService("SoundService")
local LP=Players.LocalPlayer

-- АГРЕССИВНАЯ ОЧИСТКА: убивает ВСЕ гуи по подстроке
pcall(function()
    local function wipe(parent)
        if not parent then return end
        for _,g in ipairs(parent:GetChildren()) do
            if g:IsA("ScreenGui") then
                local n = g.Name:lower()
                if n:find("eon") or n:find("cheon") or n:find("hub") then
                    g:Destroy()
                end
            end
        end
    end
    wipe(CG)
    wipe(LP:FindFirstChild("PlayerGui"))
    for _,v in ipairs(Lighting:GetChildren()) do
        if v.Name:sub(1,3)=="Eon" or v.Name:sub(1,5)=="Cheon" then v:Destroy() end
    end
    for _,v in ipairs(workspace:GetChildren()) do
        if v.Name=="EonWea" or v.Name=="CheonWea" then v:Destroy() end
    end
end)
task.wait(0.4)

local FB="https://cheon-keys-default-rtdb.firebaseio.com"
local KP="used_keys"
local MK={
    ["eonvisual_3qthfmdnlwfu_7"]={p="EON VISUAL",d=7,l=false},
    ["eonvisual_test_7"]={p="EON VISUAL",d=7,l=false},
    ["eonvisual_test_30"]={p="EON VISUAL",d=30,l=false},
    ["eonvisual_test_forever"]={p="EON VISUAL",d=0,l=true},
    ["cheon_v0hftxvllgdf_7"]={p="EON VISUAL",d=7,l=false},
}

local sDev=nil
pcall(function()
    if readfile and isfile and isfile("eon_device.txt") then
        sDev=readfile("eon_device.txt"):gsub("%s","")
    end
end)
local isMob,dType
if sDev=="PC" then isMob=false; dType="PC"
elseif sDev=="MOBILE" then isMob=true; dType="MOBILE"
else isMob=UIS.TouchEnabled and not UIS.KeyboardEnabled; dType=isMob and "MOBILE" or "PC" end

local C={
    bg=Color3.fromRGB(11,11,15),bg2=Color3.fromRGB(16,16,21),bg3=Color3.fromRGB(22,22,28),
    row=Color3.fromRGB(26,26,32),rowH=Color3.fromRGB(38,38,46),sl=Color3.fromRGB(55,55,65),
    txt=Color3.fromRGB(242,242,248),dim=Color3.fromRGB(150,150,162),dim2=Color3.fromRGB(95,95,108),
    str=Color3.fromRGB(44,44,52),strH=Color3.fromRGB(78,78,90),
    ac=Color3.fromRGB(110,150,255),ac2=Color3.fromRGB(170,110,255),ac3=Color3.fromRGB(255,110,190),
    wh=Color3.fromRGB(252,252,255),suc=Color3.fromRGB(85,215,135),
    warn=Color3.fromRGB(252,195,85),dan=Color3.fromRGB(240,95,95),
}

local TR={
    ru={
        kt="ВВЕДИТЕ КЛЮЧ",kd="Ключ доступа к EON VISUAL",kp="eonVISUAL_xxxxxxxxxxxx_30",
        kb="ПРОВЕРИТЬ",kc="Проверка...",kok="Ключ активирован",kno="Неверный ключ",
        kus="Ключ использован",ker="Ошибка",kex="Подписка истекла",kbu="eon.website",
        pt="ВЫБЕРИ УСТРОЙСТВО",pd="От этого зависит способ открытия",
        ppc="ПК",ppcs="Клавиша INSERT",pm="Телефон",pms="Кнопка Е снизу",
        pa="Авто",pas="Определить само",
        cw="🌍 Мир",cv="✨ Визуалы",cp="👤 Персонаж",cs="🖥 Экран",
        cc="🎯 Курсор",csn="🔊 Звук",csub="⭐ Подписка",cst="⚙ Настройки",
        sSky="НЕБО",sWea="ПОГОДА",sTim="ВРЕМЯ",sLig="ОСВЕЩЕНИЕ",
        sCf="ЭФФЕКТЫ ПЕРСОНАЖА",sCz="РАЗМЕР",sCc="ЦВЕТ ТЕЛА",
        sHUD="ИНТЕРФЕЙС",sOv="ОВЕРЛЕИ",
        sSh="ФОРМА",sCo="ЦВЕТ",sSi="РАЗМЕР",sFx="ЭФФЕКТЫ",
        sMus="МУЗЫКА",sSfx="ЗВУКИ",sLan="ЯЗЫК",sRes="СБРОС",
        sky_space="Космос",sky_sunset="Закат",sky_night="Ночь",sky_dawn="Рассвет",
        sky_storm="Гроза",sky_clear="День",sky_nebula="Туманность",
        sky_cartoon="Мультяшное",sky_alien="Чужое",sky_off="Убрать",
        wRain="🌧 Дождь",wSnow="❄ Снег",wStorm="⛈ Гроза",wOff="❌ Убрать",
        tDay="☀ День",tEve="🌆 Вечер",tNight="🌙 Ночь",tMorn="🌅 Утро",tReal="⏰ Реальное",
        fog="Туман",bloom="Bloom",ccE="Цветокоррекция",dof="Глубина резкости",
        blur="Размытие",sunrays="Лучи",
        cGlow="Свечение",cRGB="RGB аура",cTrail="Трейл",cSpark="Искры",
        cFire="🔥 Огонь",cFroz="❄ Лёд",cLight="⚡ Молния",cHeart="❤ Сердечки",
        cNote="♪ Ноты",cFly="✨ Светлячки",cHalo="😇 Ореол",cRain="🌈 Радужный",
        hBig="🗣 Голова ×2",hNorm="🗣 Обычная",hSmall="🗣 Голова ×0.5",
        bNorm="💪 Обычное",bWide="💪 Широкое",bTall="💪 Высокое",bSmall="💪 Маленькое",
        colR="🔴 Красный",colB="🔵 Синий",colG="🟢 Зелёный",colY="🟡 Жёлтый",
        colP="🟣 Фиолетовый",colW="⚪ Белый",colReset="↺ Сброс",
        hFPS="FPS",hPing="Ping",hClock="🕐 Часы",hWM="💧 Watermark",
        hCoord="📍 Координаты",hSpeed="🏃 Скорость",
        oVig="🎭 Виньетка",oRGB="🌈 RGB рамка",oScan="📺 Полосы",
        shDot="Точка",shCH="Прицел",shRing="Кольцо",shDiam="Ромб",
        shStar="Звезда",shArrow="Стрелка",shTarg="Мишень",shBr="Скобки",
        shHeart="❤ Сердце",shLight="⚡ Молния",
        coW="Белый",coB="Чёрный",coR="Красный",coC="Голубой",
        coG="Зелёный",coGo="Золотой",coP="Розовый",coPu="Фиолетовый",
        coRGB="🌈 RGB",cOff="Выключить",cOn="Включить",
        siS="Малый",siM="Средний",siL="Большой",siH="Огромный",
        cTrail="Трейл",cPulse="Пульсация",
        mE="🎵 Epic",mC="🎵 Chill",mN="❌ Выкл",
        sfxC="Клик",sfxH="Наведение",
        reset="🔄 Сбросить всё",langRu="🇷🇺 Русский",langEn="🇺🇸 English",
        subA="АКТИВНА",subE="ИСТЕКЛА",subL="НАВСЕГДА",
        subK="Ключ",subB="Куплено",subX="Истекает",
        subN="Нет подписки",subND="Введи ключ",
        subS="МОИ ПОДПИСКИ",subF="Бессрочно",
        left="Осталось: ",days=" дней",
    },
    en={
        kt="ENTER KEY",kd="Access key",kp="eonVISUAL_xxxxxxxxxxxx_30",
        kb="VERIFY",kc="Checking...",kok="Activated",kno="Invalid",
        kus="Used",ker="Error",kex="Expired",kbu="eon.website",
        pt="SELECT DEVICE",pd="Affects opening",
        ppc="PC",ppcs="INSERT key",pm="Mobile",pms="E button",
        pa="Auto",pas="Auto-detect",
        cw="🌍 World",cv="✨ Visuals",cp="👤 Player",cs="🖥 Screen",
        cc="🎯 Cursor",csn="🔊 Sound",csub="⭐ Sub",cst="⚙ Settings",
        sSky="SKY",sWea="WEATHER",sTim="TIME",sLig="LIGHTING",
        sCf="CHAR FX",sCz="SIZE",sCc="BODY COLOR",sHUD="HUD",sOv="OVERLAYS",
        sSh="SHAPE",sCo="COLOR",sSi="SIZE",sFx="FX",
        sMus="MUSIC",sSfx="SFX",sLan="LANG",sRes="RESET",
        sky_space="Space",sky_sunset="Sunset",sky_night="Night",sky_dawn="Dawn",
        sky_storm="Storm",sky_clear="Day",sky_nebula="Nebula",
        sky_cartoon="Cartoon",sky_alien="Alien",sky_off="Remove",
        wRain="🌧 Rain",wSnow="❄ Snow",wStorm="⛈ Storm",wOff="❌ Remove",
        tDay="☀ Day",tEve="🌆 Eve",tNight="🌙 Night",tMorn="🌅 Morn",tReal="⏰ Real",
        fog="Fog",bloom="Bloom",ccE="CC",dof="DOF",blur="Blur",sunrays="Sun",
        cGlow="Glow",cRGB="RGB",cTrail="Trail",cSpark="Spark",
        cFire="🔥 Fire",cFroz="❄ Ice",cLight="⚡ Bolt",cHeart="❤ Heart",
        cNote="♪ Note",cFly="✨ Fly",cHalo="😇 Halo",cRain="🌈 Rain",
        hBig="🗣 Head ×2",hNorm="🗣 Normal",hSmall="🗣 ×0.5",
        bNorm="💪 Normal",bWide="💪 Wide",bTall="💪 Tall",bSmall="💪 Small",
        colR="🔴 Red",colB="🔵 Blue",colG="🟢 Green",colY="🟡 Yellow",
        colP="🟣 Purple",colW="⚪ White",colReset="↺ Reset",
        hFPS="FPS",hPing="Ping",hClock="🕐 Clock",hWM="💧 WM",
        hCoord="📍 Coords",hSpeed="🏃 Speed",
        oVig="🎭 Vignette",oRGB="🌈 RGB",oScan="📺 Scan",
        shDot="Dot",shCH="Cross",shRing="Ring",shDiam="Diamond",
        shStar="Star",shArrow="Arrow",shTarg="Target",shBr="Brackets",
        shHeart="❤ Heart",shLight="⚡ Bolt",
        coW="White",coB="Black",coR="Red",coC="Cyan",
        coG="Green",coGo="Gold",coP="Pink",coPu="Purple",
        coRGB="🌈 RGB",cOff="Disable",cOn="Enable",
        siS="Small",siM="Medium",siL="Large",siH="Huge",
        cTrail="Trail",cPulse="Pulse",
        mE="🎵 Epic",mC="🎵 Chill",mN="❌ Off",
        sfxC="Click",sfxH="Hover",
        reset="🔄 Reset",langRu="🇷🇺 Русский",langEn="🇺🇸 English",
        subA="ACTIVE",subE="EXPIRED",subL="LIFETIME",
        subK="Key",subB="Bought",subX="Expires",
        subN="No sub",subND="Enter key",
        subS="MY SUBS",subF="Forever",
        left="Left: ",days=" days",
    }
}
local Lang="ru"
local function tr(k) return TR[Lang][k] or k end

local function parseKey(key)
    key=key:gsub("%s","")
    if key=="" then return nil end
    local lower=key:lower()
    local mk=MK[lower]
    if mk then return {product=mk.p,days=mk.d,lifetime=mk.l,raw=key,master=true} end
    local prod,rand,dur=lower:match("^(%a+)_([%a0-9]+)_([%a0-9]+)$")
    if not prod or not rand or not dur then return nil end
    if #rand<6 then return nil end
    if prod~="cheon" and prod~="eonvisual" then return nil end
    local lt=(dur=="lifetime")
    local d=lt and 0 or tonumber(dur)
    if not lt and (not d or d<=0) then return nil end
    return {product="EON VISUAL",days=d,lifetime=lt,raw=key,master=false}
end

local function checkKey(key)
    local p=parseKey(key)
    if not p then return false,"invalid",nil end
    local now=os.time()
    if p.master then
        return true,"master",{key=p.raw,product=p.product,days=p.days,lifetime=p.lifetime,activatedAt=now,expiresAt=p.lifetime and 0 or (now+p.days*86400)}
    end
    local safe=p.raw:lower():gsub("[%./%[%]%$#]","_")
    local url=FB.."/"..KP.."/"..safe..".json"
    local ok,res=pcall(function() return HS:GetAsync(url) end)
    if ok and res and res~="" and res~="null" then
        local ok2,dec=pcall(function() return HS:JSONDecode(res) end)
        if ok2 and dec then
            if dec.userId and dec.userId~=LP.UserId then return false,"used",nil end
            if dec.lifetime then return true,"reactivate",dec end
            if dec.expiresAt and dec.expiresAt>now then return true,"reactivate",dec end
            return false,"expired",nil
        end
    end
    local data={userId=LP.UserId,username=LP.Name,product=p.product,days=p.days,lifetime=p.lifetime,activatedAt=now,expiresAt=p.lifetime and 0 or (now+p.days*86400),rawKey=p.raw}
    pcall(function() HS:PutAsync(url,HS:JSONEncode(data)) end)
    return true,"new",data
end

local startMain
local subs={}

-- KEY GUI
local KG=Instance.new("ScreenGui")
KG.Name="EonKeyGui"; KG.ResetOnSpawn=false; KG.IgnoreGuiInset=true; KG.DisplayOrder=2147483640
pcall(function() KG.Parent=CG end)
if not KG.Parent then KG.Parent=LP:WaitForChild("PlayerGui") end

local KBg=Instance.new("Frame")
KBg.Size=UDim2.new(1,0,1,0); KBg.BackgroundColor3=Color3.fromRGB(6,6,10)
KBg.BackgroundTransparency=0.15; KBg.BorderSizePixel=0; KBg.ZIndex=99990; KBg.Parent=KG

local KBox=Instance.new("Frame")
KBox.Size=UDim2.new(0,460,0,380); KBox.Position=UDim2.new(0.5,-230,0.5,-190)
KBox.BackgroundColor3=C.bg; KBox.BorderSizePixel=0; KBox.ZIndex=99992; KBox.Parent=KBg
local KBC=Instance.new("UICorner"); KBC.CornerRadius=UDim.new(0,20); KBC.Parent=KBox
local KBS1=Instance.new("UIStroke"); KBS1.Color=C.str; KBS1.Thickness=1; KBS1.Parent=KBox
local KBS2=Instance.new("UIStroke"); KBS2.Color=C.ac; KBS2.Thickness=2; KBS2.Transparency=0.6; KBS2.Parent=KBox
task.spawn(function()
    while KBS2.Parent do
        KBS2.Color=C.ac:Lerp(C.ac2,(math.sin(tick()*1.2)+1)/2)
        task.wait(0.05)
    end
end)

local ICH=Instance.new("Frame")
ICH.Size=UDim2.new(0,68,0,68); ICH.Position=UDim2.new(0.5,-34,0,30)
ICH.BackgroundColor3=C.bg3; ICH.BorderSizePixel=0; ICH.ZIndex=99993; ICH.Parent=KBox
local ICHC=Instance.new("UICorner"); ICHC.CornerRadius=UDim.new(0,16); ICHC.Parent=ICH
local ICHS=Instance.new("UIStroke"); ICHS.Color=C.ac; ICHS.Thickness=1.5; ICHS.Transparency=0.3; ICHS.Parent=ICH
local ICHL=Instance.new("TextLabel")
ICHL.Size=UDim2.new(1,0,1,0); ICHL.BackgroundTransparency=1; ICHL.Text="🔐"
ICHL.TextSize=32; ICHL.Font=Enum.Font.GothamBold; ICHL.ZIndex=99994; ICHL.Parent=ICH

local KTi=Instance.new("TextLabel")
KTi.Size=UDim2.new(1,-40,0,28); KTi.Position=UDim2.new(0,20,0,120)
KTi.BackgroundTransparency=1; KTi.Text=tr("kt"); KTi.TextColor3=C.wh
KTi.Font=Enum.Font.GothamBlack; KTi.TextSize=19; KTi.ZIndex=99993; KTi.Parent=KBox

local KDe=Instance.new("TextLabel")
KDe.Size=UDim2.new(1,-40,0,18); KDe.Position=UDim2.new(0,20,0,148)
KDe.BackgroundTransparency=1; KDe.Text=tr("kd"); KDe.TextColor3=C.dim
KDe.Font=Enum.Font.Gotham; KDe.TextSize=12; KDe.ZIndex=99993; KDe.Parent=KBox

local KIF=Instance.new("Frame")
KIF.Size=UDim2.new(1,-40,0,50); KIF.Position=UDim2.new(0,20,0,180)
KIF.BackgroundColor3=C.bg2; KIF.BorderSizePixel=0; KIF.ZIndex=99993; KIF.Parent=KBox
local KIFC=Instance.new("UICorner"); KIFC.CornerRadius=UDim.new(0,12); KIFC.Parent=KIF
local KIFS=Instance.new("UIStroke"); KIFS.Color=C.str; KIFS.Thickness=1.5; KIFS.Parent=KIF

local KI=Instance.new("TextBox")
KI.Size=UDim2.new(1,-28,1,0); KI.Position=UDim2.new(0,14,0,0)
KI.BackgroundTransparency=1; KI.Text=""; KI.PlaceholderText=tr("kp")
KI.PlaceholderColor3=C.dim2; KI.TextColor3=C.wh; KI.Font=Enum.Font.GothamBold
KI.TextSize=14; KI.TextXAlignment=Enum.TextXAlignment.Center; KI.ClearTextOnFocus=false
KI.ZIndex=99994; KI.Parent=KIF

local KB=Instance.new("TextButton")
KB.Size=UDim2.new(1,-40,0,50); KB.Position=UDim2.new(0,20,0,244)
KB.BackgroundColor3=C.ac; KB.BorderSizePixel=0; KB.Text=tr("kb")
KB.TextColor3=C.wh; KB.Font=Enum.Font.GothamBold; KB.TextSize=14
KB.ZIndex=99993; KB.AutoButtonColor=false; KB.Parent=KBox
local KBC2=Instance.new("UICorner"); KBC2.CornerRadius=UDim.new(0,12); KBC2.Parent=KB
local KBG=Instance.new("UIGradient")
KBG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.ac),ColorSequenceKeypoint.new(1,C.ac2)})
KBG.Rotation=15; KBG.Parent=KB

local KSt=Instance.new("TextLabel")
KSt.Size=UDim2.new(1,-40,0,18); KSt.Position=UDim2.new(0,20,0,305)
KSt.BackgroundTransparency=1; KSt.Text=""; KSt.TextColor3=C.dim
KSt.Font=Enum.Font.Gotham; KSt.TextSize=12; KSt.ZIndex=99993; KSt.Parent=KBox

local KBu=Instance.new("TextLabel")
KBu.Size=UDim2.new(1,-40,0,18); KBu.Position=UDim2.new(0,20,0,335)
KBu.BackgroundTransparency=1; KBu.Text=tr("kbu"); KBu.TextColor3=C.dim2
KBu.Font=Enum.Font.Gotham; KBu.TextSize=11; KBu.ZIndex=99993; KBu.Parent=KBox

local function submitKey()
    local k=KI.Text
    if k=="" then KSt.Text=tr("kno"); KSt.TextColor3=C.dan; return end
    KSt.Text=tr("kc"); KSt.TextColor3=C.dim; KB.Text="..."
    task.spawn(function()
        local ok,v,r,sd=pcall(checkKey,k)
        task.wait(0.5)
        if ok and v then
            local p=parseKey(k)
            table.insert(subs,sd or {key=k,product="EON VISUAL",days=p and p.days or 0,lifetime=p and p.lifetime or false,activatedAt=os.time(),expiresAt=0})
            KSt.Text="✓ "..tr("kok"); KSt.TextColor3=C.suc
            KB.Text="✓ OK"; KB.BackgroundColor3=C.suc
            task.wait(0.6)
            pcall(function() KG:Destroy() end)
            task.wait(0.3)
            pcall(startMain)
        else
            KB.Text=tr("kb"); KB.BackgroundColor3=C.ac
            KSt.TextColor3=C.dan
            if r=="used" then KSt.Text=tr("kus")
            elseif r=="expired" then KSt.Text=tr("kex")
            elseif r=="invalid" then KSt.Text=tr("kno")
            else KSt.Text="Ошибка" end
        end
    end)
end
KB.MouseButton1Click:Connect(submitKey)
KI.FocusLost:Connect(function(e) if e then submitKey() end end)

-- MAIN
startMain=function()
    if not sDev then
        local PG=Instance.new("ScreenGui")
        PG.Name="EonPickGui"; PG.ResetOnSpawn=false; PG.IgnoreGuiInset=true; PG.DisplayOrder=2147483641
        pcall(function() PG.Parent=CG end)
        if not PG.Parent then PG.Parent=LP:WaitForChild("PlayerGui") end
        local PBg=Instance.new("Frame")
        PBg.Size=UDim2.new(1,0,1,0); PBg.BackgroundColor3=Color3.fromRGB(6,6,10)
        PBg.BackgroundTransparency=0.1; PBg.BorderSizePixel=0; PBg.ZIndex=99990; PBg.Parent=PG
        local PBox=Instance.new("Frame")
        PBox.Size=UDim2.new(0,620,0,380); PBox.Position=UDim2.new(0.5,-310,0.5,-190)
        PBox.BackgroundColor3=C.bg; PBox.BorderSizePixel=0; PBox.ZIndex=99992; PBox.Parent=PBg
        local PBC=Instance.new("UICorner"); PBC.CornerRadius=UDim.new(0,20); PBC.Parent=PBox
        local PBS=Instance.new("UIStroke"); PBS.Color=C.str; PBS.Thickness=1; PBS.Parent=PBox
        local PTitle=Instance.new("TextLabel")
        PTitle.Size=UDim2.new(1,-40,0,30); PTitle.Position=UDim2.new(0,20,0,25)
        PTitle.BackgroundTransparency=1; PTitle.Text=tr("pt"); PTitle.TextColor3=C.wh
        PTitle.Font=Enum.Font.GothamBlack; PTitle.TextSize=20; PTitle.ZIndex=99993; PTitle.Parent=PBox
        local PDesc=Instance.new("TextLabel")
        PDesc.Size=UDim2.new(1,-40,0,18); PDesc.Position=UDim2.new(0,20,0,58)
        PDesc.BackgroundTransparency=1; PDesc.Text=tr("pd"); PDesc.TextColor3=C.dim
        PDesc.Font=Enum.Font.Gotham; PDesc.TextSize=12; PDesc.ZIndex=99993; PDesc.Parent=PBox
        local done=false
        local function fin(ch)
            if done then return end
            done=true
            if ch=="PC" then isMob=false; dType="PC"
            elseif ch=="MOBILE" then isMob=true; dType="MOBILE"
            else isMob=UIS.TouchEnabled and not UIS.KeyboardEnabled; dType=isMob and "MOBILE" or "PC" end
            pcall(function() if writefile then writefile("eon_device.txt",ch) end end)
            PG:Destroy()
        end
        local function mkCard(x,ico,ttl,sb,ch)
            local card=Instance.new("TextButton")
            card.Size=UDim2.new(0,180,0,200); card.Position=UDim2.new(0,x,0,100)
            card.BackgroundColor3=C.bg2; card.BorderSizePixel=0; card.Text=""
            card.AutoButtonColor=false; card.ZIndex=99993; card.Parent=PBox
            local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,16); c.Parent=card
            local s=Instance.new("UIStroke"); s.Color=C.str; s.Thickness=1.5; s.Parent=card
            local i=Instance.new("TextLabel")
            i.Size=UDim2.new(1,0,0,70); i.Position=UDim2.new(0,0,0,30)
            i.BackgroundTransparency=1; i.Text=ico; i.TextSize=50
            i.Font=Enum.Font.GothamBold; i.ZIndex=99994; i.Parent=card
            local t=Instance.new("TextLabel")
            t.Size=UDim2.new(1,0,0,24); t.Position=UDim2.new(0,0,0,115)
            t.BackgroundTransparency=1; t.Text=ttl; t.TextColor3=C.wh
            t.Font=Enum.Font.GothamBold; t.TextSize=15; t.ZIndex=99994; t.Parent=card
            local sb2=Instance.new("TextLabel")
            sb2.Size=UDim2.new(1,-20,0,40); sb2.Position=UDim2.new(0,10,0,142)
            sb2.BackgroundTransparency=1; sb2.Text=sb; sb2.TextColor3=C.dim
            sb2.Font=Enum.Font.Gotham; sb2.TextSize=10; sb2.TextWrapped=true
            sb2.TextYAlignment=Enum.TextYAlignment.Top; sb2.ZIndex=99994; sb2.Parent=card
            card.MouseEnter:Connect(function()
                TS:Create(card,TweenInfo.new(0.2),{BackgroundColor3=C.rowH}):Play()
                TS:Create(s,TweenInfo.new(0.2),{Color=C.ac,Transparency=0}):Play()
            end)
            card.MouseLeave:Connect(function()
                TS:Create(card,TweenInfo.new(0.2),{BackgroundColor3=C.bg2}):Play()
                TS:Create(s,TweenInfo.new(0.2),{Color=C.str,Transparency=0}):Play()
            end)
            card.MouseButton1Click:Connect(function() fin(ch) end)
        end
        mkCard(20,"🖥",tr("ppc"),tr("ppcs"),"PC")
        mkCard(220,"📱",tr("pm"),tr("pms"),"MOBILE")
        mkCard(420,"❓",tr("pa"),tr("pas"),"AUTO")
        while not done do task.wait(0.1) end
    end

    local LG=Instance.new("ScreenGui")
    LG.Name="EonMainGui"; LG.ResetOnSpawn=false; LG.IgnoreGuiInset=true; LG.DisplayOrder=999990
    pcall(function() LG.Parent=CG end)
    if not LG.Parent then LG.Parent=LP:WaitForChild("PlayerGui") end

    -- ЗАГРУЗКА С ПОЛОСКОЙ
    local LS=Instance.new("Frame")
    LS.Size=UDim2.new(1,0,1,0); LS.BackgroundColor3=Color3.fromRGB(8,8,12)
    LS.BorderSizePixel=0; LS.ZIndex=999; LS.Parent=LG

    local LL=Instance.new("TextLabel")
    LL.Size=UDim2.new(0,700,0,110); LL.Position=UDim2.new(0.5,-350,0.5,-120)
    LL.BackgroundTransparency=1; LL.Text="EON"; LL.TextColor3=C.wh
    LL.Font=Enum.Font.GothamBlack; LL.TextSize=110; LL.ZIndex=1001; LL.Parent=LS
    local LLG=Instance.new("UIGradient")
    LLG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.wh),ColorSequenceKeypoint.new(0.5,C.ac),ColorSequenceKeypoint.new(1,C.ac2)})
    LLG.Parent=LL

    local LSb=Instance.new("TextLabel")
    LSb.Size=UDim2.new(0,700,0,24); LSb.Position=UDim2.new(0.5,-350,0.5,0)
    LSb.BackgroundTransparency=1; LSb.Text="P R E M I U M   V I S U A L S   ·   v15"
    LSb.TextColor3=C.dim; LSb.Font=Enum.Font.Gotham; LSb.TextSize=11; LSb.ZIndex=1001; LSb.Parent=LS

    -- ПОЛОСКА ЗАГРУЗКИ
    local LBarWrap=Instance.new("Frame")
    LBarWrap.Size=UDim2.new(0,440,0,4); LBarWrap.Position=UDim2.new(0.5,-220,0.5,55)
    LBarWrap.BackgroundColor3=Color3.fromRGB(28,28,34); LBarWrap.BorderSizePixel=0
    LBarWrap.ZIndex=1001; LBarWrap.Parent=LS
    local LBWC=Instance.new("UICorner"); LBWC.CornerRadius=UDim.new(1,0); LBWC.Parent=LBarWrap

    local LFill=Instance.new("Frame")
    LFill.Size=UDim2.new(0,0,1,0); LFill.BackgroundColor3=C.ac
    LFill.BorderSizePixel=0; LFill.ZIndex=1002; LFill.Parent=LBarWrap
    local LFC=Instance.new("UICorner"); LFC.CornerRadius=UDim.new(1,0); LFC.Parent=LFill
    local LFG=Instance.new("UIGradient")
    LFG.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,C.ac),
        ColorSequenceKeypoint.new(0.5,C.ac2),
        ColorSequenceKeypoint.new(1,C.ac3),
    })
    LFG.Parent=LFill

    local LStatus=Instance.new("TextLabel")
    LStatus.Size=UDim2.new(0,700,0,18); LStatus.Position=UDim2.new(0.5,-350,0.5,80)
    LStatus.BackgroundTransparency=1; LStatus.Text="Инициализация..."
    LStatus.TextColor3=C.dim; LStatus.Font=Enum.Font.Gotham; LStatus.TextSize=11
    LStatus.ZIndex=1001; LStatus.Parent=LS

    local LPerc=Instance.new("TextLabel")
    LPerc.Size=UDim2.new(0,80,0,20); LPerc.Position=UDim2.new(0.5,240,0.5,55)
    LPerc.BackgroundTransparency=1; LPerc.Text="0%"
    LPerc.TextColor3=C.dim; LPerc.Font=Enum.Font.GothamBold; LPerc.TextSize=11
    LPerc.ZIndex=1001; LPerc.Parent=LS

    -- Анимация загрузки
    local lDone=false
    task.spawn(function()
        local steps={
            {p=0.25,t="Инициализация..."},
            {p=0.50,t="Загрузка модулей..."},
            {p=0.75,t="Применение визуалов..."},
            {p=1.00,t="Готово"},
        }
        for _,s in ipairs(steps) do
            if lDone then return end
            TS:Create(LFill,TweenInfo.new(0.35),{Size=UDim2.new(s.p,0,1,0)}):Play()
            LStatus.Text=s.t
            -- Анимируем проценты
            local startP = (LFill.Size.X.Scale)*100
            local endP = s.p*100
            task.spawn(function()
                for i=0,15 do
                    if lDone then return end
                    LPerc.Text=math.floor(startP + (endP-startP)*(i/15)).."%"
                    task.wait(0.02)
                end
            end)
            task.wait(0.45)
        end
        task.wait(0.3)
        lDone=true
        LStatus.Text="Готово ✓"
        LStatus.TextColor3=C.suc
        LPerc.Text="100%"
        task.wait(0.4)
        TS:Create(LS,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
        for _,ch in ipairs(LS:GetDescendants()) do
            if ch:IsA("TextLabel") then
                pcall(function() TS:Create(ch,TweenInfo.new(0.5),{TextTransparency=1}):Play() end)
            elseif ch:IsA("GuiObject") then
                pcall(function() TS:Create(ch,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play() end)
            end
        end
        task.wait(0.6)
        LS:Destroy()
    end)

    -- HUD GUI (единственный экземпляр)
    local HG=Instance.new("ScreenGui")
    HG.Name="EonHUDGui"; HG.ResetOnSpawn=false; HG.IgnoreGuiInset=true; HG.DisplayOrder=999989
    pcall(function() HG.Parent=CG end)
    if not HG.Parent then HG.Parent=LP:WaitForChild("PlayerGui") end

    -- CURSOR
    local CGui=Instance.new("ScreenGui")
    CGui.Name="EonCursorGui"; CGui.ResetOnSpawn=false; CGui.IgnoreGuiInset=true
    CGui.DisplayOrder=2147483647; CGui.Enabled=false
    pcall(function() CGui.Parent=CG end)
    if not CGui.Parent then CGui.Parent=LP:WaitForChild("PlayerGui") end

    local CR=Instance.new("Frame")
    CR.Size=UDim2.new(0,100,0,100); CR.AnchorPoint=Vector2.new(0.5,0.5)
    CR.BackgroundTransparency=1; CR.ZIndex=10; CR.Parent=CGui
    local cs={shape="crosshair",color=C.wh,size=14,trail=false,enabled=false,rgb=false,pulse=false}
    local sp={}
    local function clrS()
        for _,p in ipairs(sp) do pcall(function() p:Destroy() end) end
        sp={}
    end
    local function mkL(w,h,x,y,rot)
        local f=Instance.new("Frame")
        f.Size=UDim2.new(0,w,0,h); f.Position=UDim2.new(0.5,x,0.5,y)
        f.AnchorPoint=Vector2.new(0.5,0.5); f.BackgroundColor3=cs.color
        f.BorderSizePixel=0; f.Rotation=rot or 0; f.ZIndex=10; f.Parent=CR
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(1,0); c.Parent=f
        table.insert(sp,f); return f
    end
    local function mkC(sz,fill,th)
        local f=Instance.new("Frame")
        f.Size=UDim2.new(0,sz,0,sz); f.Position=UDim2.new(0.5,0,0.5,0)
        f.AnchorPoint=Vector2.new(0.5,0.5); f.BackgroundColor3=cs.color
        f.BackgroundTransparency=fill and 0 or 1; f.BorderSizePixel=0; f.ZIndex=10; f.Parent=CR
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(1,0); c.Parent=f
        if not fill then
            local s=Instance.new("UIStroke"); s.Color=cs.color; s.Thickness=th or 2; s.Parent=f
        end
        table.insert(sp,f); return f
    end
    local function mkSq(sz,rot,fill,th)
        local f=Instance.new("Frame")
        f.Size=UDim2.new(0,sz,0,sz); f.Position=UDim2.new(0.5,0,0.5,0)
        f.AnchorPoint=Vector2.new(0.5,0.5); f.Rotation=rot or 0
        f.BackgroundColor3=cs.color; f.BackgroundTransparency=fill and 0 or 1
        f.BorderSizePixel=0; f.ZIndex=10; f.Parent=CR
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,2); c.Parent=f
        if not fill then
            local s=Instance.new("UIStroke"); s.Color=cs.color; s.Thickness=th or 2; s.Parent=f
        end
        table.insert(sp,f); return f
    end
    local function buildS(sh)
        clrS()
        local s=cs.size; local th=math.max(2,math.floor(s*0.16))
        if sh=="dot" then mkC(s,true)
        elseif sh=="crosshair" then
            local g=s*0.5; local l=s*1.4
            mkL(th,l,0,-(g+l/2),0); mkL(th,l,0,(g+l/2),0)
            mkL(l,th,-(g+l/2),0,0); mkL(l,th,(g+l/2),0,0)
            mkC(th,true)
        elseif sh=="ring" then mkC(s*1.8,false,th); mkC(th,true)
        elseif sh=="diamond" then mkSq(s*1.7,45,false,th); mkC(math.max(2,th-1),true)
        elseif sh=="star" then
            local l=s*2
            mkL(th-1,l,0,0,0); mkL(th-1,l,0,0,45); mkL(th-1,l,0,0,-45); mkL(th-1,l,0,0,90)
            mkC(th,true)
        elseif sh=="arrow" then
            local t=Instance.new("Frame")
            t.Size=UDim2.new(0,s*1.3,0,s*1.3); t.Position=UDim2.new(0.5,0,0.5,0)
            t.AnchorPoint=Vector2.new(0.5,0.5); t.Rotation=45
            t.BackgroundColor3=cs.color; t.BorderSizePixel=0; t.ZIndex=10; t.Parent=CR
            local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,2); c.Parent=t
            table.insert(sp,t)
        elseif sh=="target" then
            local r=s*2
            mkC(r,false,th); mkC(r*0.6,false,math.max(1,th-1)); mkC(math.max(2,th-1),true)
            local l=r*0.35
            mkL(th,l,0,-(r/2+l/2),0); mkL(th,l,0,(r/2+l/2),0)
            mkL(l,th,-(r/2+l/2),0,0); mkL(l,th,(r/2+l/2),0,0)
        elseif sh=="bracket" then
            local o=s*1.5; local l=s*1.0; local t=math.max(2,th-1)
            mkL(t,l,-o,-o+l/2,0); mkL(l,t,-o+l/2,-o,0)
            mkL(t,l,o,-o+l/2,0); mkL(l,t,o-l/2,-o,0)
            mkL(t,l,-o,o-l/2,0); mkL(l,t,-o+l/2,o,0)
            mkL(t,l,o,o-l/2,0); mkL(l,t,o-l/2,o,0)
            mkC(math.max(2,th-1),true)
        elseif sh=="heart" then
            local sz=s*1.2
            local lt=Instance.new("Frame")
            lt.Size=UDim2.new(0,sz,0,sz); lt.Position=UDim2.new(0.5,-sz/2,0.5,-sz/2)
            lt.Rotation=45; lt.BackgroundColor3=cs.color
            lt.BorderSizePixel=0; lt.ZIndex=10; lt.Parent=CR
            local ltc=Instance.new("UICorner"); ltc.CornerRadius=UDim.new(0,3); ltc.Parent=lt
            table.insert(sp,lt)
            local rt=Instance.new("Frame")
            rt.Size=UDim2.new(0,sz*1.4,0,sz*1.4)
            rt.Position=UDim2.new(0.5,-sz*0.7,0.5,-sz*1.2)
            rt.BackgroundColor3=cs.color; rt.BorderSizePixel=0
            rt.ZIndex=10; rt.Parent=CR
            local rtc=Instance.new("UICorner"); rtc.CornerRadius=UDim.new(1,0); rtc.Parent=rt
            table.insert(sp,rt)
        elseif sh=="lightning" then
            local l=s*2.5
            mkL(th,l,0,-s*0.3,0); mkL(th,l,-s*0.3,0,45)
            mkL(th,l,0,0,-45); mkL(th,s*0.3,0,-20)
        end
    end
    buildS(cs.shape)
    task.spawn(function()
        while CGui.Parent do
            if cs.enabled then
                local mp=UIS:GetMouseLocation()
                CR.Position=UDim2.new(0,mp.X,0,mp.Y)
                if cs.rgb then
                    local hue=(tick()*0.2)%1
                    local col=Color3.fromHSV(hue,0.85,1)
                    for _,p in ipairs(sp) do
                        pcall(function()
                            p.BackgroundColor3=col
                            local st=p:FindFirstChildOfClass("UIStroke")
                            if st then st.Color=col end
                        end)
                    end
                end
                if cs.pulse then
                    local sc=1+math.sin(tick()*4)*0.15
                    CR.Size=UDim2.new(0,100*sc,0,100*sc)
                end
                if cs.trail then
                    local t=Instance.new("Frame")
                    t.Size=UDim2.new(0,8,0,8); t.Position=UDim2.new(0,mp.X-4,0,mp.Y-4)
                    t.BackgroundColor3=cs.color; t.BackgroundTransparency=0.3
                    t.BorderSizePixel=0; t.ZIndex=5; t.Parent=CGui
                    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(1,0); c.Parent=t
                    TS:Create(t,TweenInfo.new(0.5),{Size=UDim2.new(0,0,0,0),BackgroundTransparency=1}):Play()
                    task.delay(0.55,function() pcall(function() t:Destroy() end) end)
                end
            end
            task.wait(0.02)
        end
    end)

    -- MAIN MENU
    local MW,MH=900,580
    if isMob then
        MW=math.min(750,workspace.CurrentCamera.ViewportSize.X-40)
        MH=math.min(500,workspace.CurrentCamera.ViewportSize.Y-100)
    end
    local Main=Instance.new("Frame")
    Main.Size=UDim2.new(0,MW,0,MH); Main.Position=UDim2.new(0.5,-MW/2,0.5,-MH/2)
    Main.BackgroundColor3=C.bg; Main.BorderSizePixel=0
    Main.Active=false; Main.Visible=false; Main.ZIndex=100; Main.Parent=LG
    local MC=Instance.new("UICorner"); MC.CornerRadius=UDim.new(0,14); MC.Parent=Main
    local MS=Instance.new("UIStroke"); MS.Color=C.strH; MS.Thickness=1; MS.Transparency=0.3; MS.Parent=Main

    local SB=Instance.new("Frame")
    SB.Size=UDim2.new(0,210,1,0); SB.BackgroundColor3=C.bg2
    SB.BorderSizePixel=0; SB.ZIndex=101; SB.Parent=Main
    local SBC=Instance.new("UICorner"); SBC.CornerRadius=UDim.new(0,14); SBC.Parent=SB
    local SBF=Instance.new("Frame")
    SBF.Size=UDim2.new(0,14,1,0); SBF.Position=UDim2.new(1,-14,0,0)
    SBF.BackgroundColor3=C.bg2; SBF.BorderSizePixel=0; SBF.ZIndex=101; SBF.Parent=SB

    local SBL=Instance.new("Frame")
    SBL.Size=UDim2.new(1,0,0,60); SBL.BackgroundColor3=C.bg
    SBL.BorderSizePixel=0; SBL.ZIndex=102; SBL.Parent=SB
    local SBLC=Instance.new("UICorner"); SBLC.CornerRadius=UDim.new(0,14); SBLC.Parent=SBL
    local SBLF=Instance.new("Frame")
    SBLF.Size=UDim2.new(1,0,0,14); SBLF.Position=UDim2.new(0,0,1,-14)
    SBLF.BackgroundColor3=C.bg; SBLF.BorderSizePixel=0; SBLF.ZIndex=102; SBLF.Parent=SBL

    local LI=Instance.new("Frame")
    LI.Size=UDim2.new(0,32,0,32); LI.Position=UDim2.new(0,14,0.5,-16)
    LI.BackgroundColor3=C.ac; LI.BorderSizePixel=0; LI.ZIndex=103; LI.Parent=SBL
    local LIC=Instance.new("UICorner"); LIC.CornerRadius=UDim.new(0,8); LIC.Parent=LI
    local LIG=Instance.new("UIGradient")
    LIG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.ac),ColorSequenceKeypoint.new(1,C.ac2)})
    LIG.Rotation=45; LIG.Parent=LI
    local LIL=Instance.new("TextLabel")
    LIL.Size=UDim2.new(1,0,1,0); LIL.BackgroundTransparency=1
    LIL.Text="E"; LIL.TextColor3=C.wh; LIL.Font=Enum.Font.GothamBlack
    LIL.TextSize=18; LIL.ZIndex=104; LIL.Parent=LI

    local SN=Instance.new("TextLabel")
    SN.Size=UDim2.new(1,-60,0,18); SN.Position=UDim2.new(0,54,0,14)
    SN.BackgroundTransparency=1; SN.Text="EON VISUAL"
    SN.TextColor3=C.wh; SN.Font=Enum.Font.GothamBlack; SN.TextSize=13
    SN.TextXAlignment=Enum.TextXAlignment.Left; SN.ZIndex=103; SN.Parent=SBL

    local SV=Instance.new("TextLabel")
    SV.Size=UDim2.new(1,-60,0,14); SV.Position=UDim2.new(0,54,0,32)
    SV.BackgroundTransparency=1; SV.Text="v15 · "..dType
    SV.TextColor3=C.dim2; SV.Font=Enum.Font.Gotham; SV.TextSize=9
    SV.TextXAlignment=Enum.TextXAlignment.Left; SV.ZIndex=103; SV.Parent=SBL

    local NF=Instance.new("Frame")
    NF.Size=UDim2.new(1,0,1,-140); NF.Position=UDim2.new(0,0,0,66)
    NF.BackgroundTransparency=1; NF.ZIndex=102; NF.Parent=SB
    local NSc=Instance.new("ScrollingFrame")
    NSc.Size=UDim2.new(1,0,1,0); NSc.BackgroundTransparency=1
    NSc.BorderSizePixel=0; NSc.ScrollBarThickness=3
    NSc.ScrollBarImageColor3=C.strH; NSc.CanvasSize=UDim2.new(0,0,0,0)
    NSc.ZIndex=102; NSc.Parent=NF
    local NL=Instance.new("UIListLayout")
    NL.Padding=UDim.new(0,3); NL.SortOrder=Enum.SortOrder.LayoutOrder; NL.Parent=NSc
    task.spawn(function()
        while NSc.Parent do
            NSc.CanvasSize=UDim2.new(0,0,0,NL.AbsoluteContentSize.Y+10)
            task.wait(0.5)
        end
    end)

    local UF=Instance.new("Frame")
    UF.Size=UDim2.new(1,-20,0,56); UF.Position=UDim2.new(0,10,1,-66)
    UF.BackgroundColor3=C.bg; UF.BorderSizePixel=0; UF.ZIndex=102; UF.Parent=SB
    local UFC=Instance.new("UICorner"); UFC.CornerRadius=UDim.new(0,10); UFC.Parent=UF
    local UA=Instance.new("ImageLabel")
    UA.Size=UDim2.new(0,34,0,34); UA.Position=UDim2.new(0,11,0,11)
    UA.BackgroundColor3=C.row; UA.BorderSizePixel=0
    UA.Image="rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=100&h=100"
    UA.ZIndex=103; UA.Parent=UF
    local UAC=Instance.new("UICorner"); UAC.CornerRadius=UDim.new(1,0); UAC.Parent=UA
    local UN=Instance.new("TextLabel")
    UN.Size=UDim2.new(1,-55,0,16); UN.Position=UDim2.new(0,52,0,12)
    UN.BackgroundTransparency=1; UN.Text=LP.DisplayName or LP.Name
    UN.TextColor3=C.txt; UN.Font=Enum.Font.GothamBold; UN.TextSize=12
    UN.TextXAlignment=Enum.TextXAlignment.Left; UN.ZIndex=103; UN.Parent=UF

    local TB=Instance.new("Frame")
    TB.Size=UDim2.new(1,-210,0,60); TB.Position=UDim2.new(0,210,0,0)
    TB.BackgroundColor3=C.bg2; TB.BorderSizePixel=0; TB.Active=true
    TB.ZIndex=101; TB.Parent=Main
    local TBC=Instance.new("UICorner"); TBC.CornerRadius=UDim.new(0,14); TBC.Parent=TB
    local TBF=Instance.new("Frame")
    TBF.Size=UDim2.new(1,0,0,14); TBF.Position=UDim2.new(0,0,1,-14)
    TBF.BackgroundColor3=C.bg2; TBF.BorderSizePixel=0; TBF.ZIndex=101; TBF.Parent=TB
    local TBD=Instance.new("Frame")
    TBD.Size=UDim2.new(1,0,0,1); TBD.Position=UDim2.new(0,0,1,-1)
    TBD.BackgroundColor3=C.str; TBD.BorderSizePixel=0; TBD.ZIndex=102; TBD.Parent=TB

    local TTi=Instance.new("TextLabel")
    TTi.Size=UDim2.new(0,400,0,22); TTi.Position=UDim2.new(0,20,0,12)
    TTi.BackgroundTransparency=1; TTi.Text="EON VISUAL"
    TTi.TextColor3=C.txt; TTi.Font=Enum.Font.GothamBold; TTi.TextSize=15
    TTi.TextXAlignment=Enum.TextXAlignment.Left; TTi.ZIndex=102; TTi.Parent=TB
    local TSb=Instance.new("TextLabel")
    TSb.Size=UDim2.new(0,400,0,14); TSb.Position=UDim2.new(0,20,0,34)
    TSb.BackgroundTransparency=1; TSb.Text="Premium Roblox Visuals"
    TSb.TextColor3=C.dim2; TSb.Font=Enum.Font.Gotham; TSb.TextSize=10
    TSb.TextXAlignment=Enum.TextXAlignment.Left; TSb.ZIndex=102; TSb.Parent=TB

    local CB=Instance.new("TextButton")
    CB.Size=UDim2.new(0,36,0,36); CB.Position=UDim2.new(1,-48,0,12)
    CB.BackgroundColor3=C.row; CB.BorderSizePixel=0
    CB.Text="✕"; CB.TextColor3=C.dim; CB.Font=Enum.Font.GothamBold
    CB.TextSize=16; CB.AutoButtonColor=false; CB.ZIndex=103; CB.Parent=TB
    local CBC=Instance.new("UICorner"); CBC.CornerRadius=UDim.new(0,8); CBC.Parent=CB

    local drag,ds,sp0=false,nil,nil
    TB.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            drag=true; ds=inp.Position; sp0=Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-ds
            Main.Position=UDim2.new(sp0.X.Scale,sp0.X.Offset+d.X,sp0.Y.Scale,sp0.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            drag=false
        end
    end)

    local CS=Instance.new("ScrollingFrame")
    CS.Size=UDim2.new(1,-230,1,-80); CS.Position=UDim2.new(0,220,0,70)
    CS.BackgroundTransparency=1; CS.BorderSizePixel=0
    CS.ScrollBarThickness=4; CS.ScrollBarImageColor3=C.strH
    CS.CanvasSize=UDim2.new(0,0,0,0); CS.ZIndex=102; CS.Parent=Main
    local CL=Instance.new("UIListLayout")
    CL.Padding=UDim.new(0,6); CL.SortOrder=Enum.SortOrder.LayoutOrder; CL.Parent=CS

    local function upd() CS.CanvasSize=UDim2.new(0,0,0,CL.AbsoluteContentSize.Y+20) end
    local function clr()
        for _,c in ipairs(CS:GetChildren()) do
            if c:IsA("GuiObject") then c:Destroy() end
        end
    end

    local function mkSec(text,order)
        local f=Instance.new("Frame")
        f.Size=UDim2.new(1,-10,0,30); f.BackgroundTransparency=1
        f.LayoutOrder=order; f.ZIndex=103; f.Parent=CS
        local d=Instance.new("Frame")
        d.Size=UDim2.new(0,3,0,14); d.Position=UDim2.new(0,4,0.5,-7)
        d.BackgroundColor3=C.ac; d.BorderSizePixel=0; d.ZIndex=104; d.Parent=f
        local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=d
        local l=Instance.new("TextLabel")
        l.Size=UDim2.new(1,-20,1,0); l.Position=UDim2.new(0,16,0,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.dim
        l.Font=Enum.Font.GothamBold; l.TextSize=10
        l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=103; l.Parent=f
        task.defer(upd)
    end

    local function mkGrid(order)
        local f=Instance.new("Frame")
        f.Size=UDim2.new(1,-10,0,0); f.BackgroundTransparency=1
        f.LayoutOrder=order; f.ZIndex=103; f.Parent=CS
        local g=Instance.new("UIGridLayout")
        g.CellSize=UDim2.new(0.5,-5,0,38); g.CellPadding=UDim2.new(0,10,0,8)
        g.SortOrder=Enum.SortOrder.LayoutOrder; g.Parent=f
        local function u2()
            local cnt=0
            for _,c in ipairs(f:GetChildren()) do if c:IsA("GuiObject") then cnt=cnt+1 end end
            f.Size=UDim2.new(1,-10,0,math.ceil(cnt/2)*46)
            task.defer(upd)
        end
        f.ChildAdded:Connect(function() task.defer(u2) end)
        f.ChildRemoved:Connect(function() task.defer(u2) end)
        task.defer(u2)
        return f
    end

    local function mkTog(parent,label,state,cb,order)
        local r=Instance.new("Frame")
        r.BackgroundColor3=C.row; r.BorderSizePixel=0
        r.LayoutOrder=order or 0; r.ZIndex=104; r.Parent=parent
        local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=r
        local rs=Instance.new("UIStroke"); rs.Color=C.str; rs.Thickness=1; rs.Transparency=0.5; rs.Parent=r
        local l=Instance.new("TextLabel")
        l.Size=UDim2.new(1,-70,1,0); l.Position=UDim2.new(0,14,0,0)
        l.BackgroundTransparency=1; l.Text=label; l.TextColor3=C.txt
        l.Font=Enum.Font.Gotham; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=105; l.Parent=r
        local sb=Instance.new("Frame")
        sb.Size=UDim2.new(0,36,0,20); sb.Position=UDim2.new(1,-48,0.5,-10)
        sb.BackgroundColor3=state and C.ac or C.sl
        sb.BorderSizePixel=0; sb.ZIndex=105; sb.Parent=r
        local sbc=Instance.new("UICorner"); sbc.CornerRadius=UDim.new(1,0); sbc.Parent=sb
        local sd=Instance.new("Frame")
        sd.Size=UDim2.new(0,14,0,14)
        sd.Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)
        sd.BackgroundColor3=C.wh; sd.BorderSizePixel=0; sd.ZIndex=106; sd.Parent=sb
        local sdc=Instance.new("UICorner"); sdc.CornerRadius=UDim.new(1,0); sdc.Parent=sd
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,0,1,0); b.BackgroundTransparency=1; b.Text=""
        b.ZIndex=107; b.Parent=r
        local on=state
        b.MouseButton1Click:Connect(function()
            on=not on
            TS:Create(sb,TweenInfo.new(0.25,Enum.EasingStyle.Back),{BackgroundColor3=on and C.ac or C.sl}):Play()
            TS:Create(sd,TweenInfo.new(0.25,Enum.EasingStyle.Back),{Position=on and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)}):Play()
            cb(on)
        end)
        b.MouseEnter:Connect(function()
            TS:Create(r,TweenInfo.new(0.15),{BackgroundColor3=C.rowH}):Play()
            TS:Create(rs,TweenInfo.new(0.15),{Color=C.strH,Transparency=0}):Play()
        end)
        b.MouseLeave:Connect(function()
            TS:Create(r,TweenInfo.new(0.15),{BackgroundColor3=C.row}):Play()
            TS:Create(rs,TweenInfo.new(0.15),{Color=C.str,Transparency=0.5}):Play()
        end)
    end

    local function mkBtn(parent,label,cb,order)
        local r=Instance.new("Frame")
        r.BackgroundColor3=C.row; r.BorderSizePixel=0
        r.LayoutOrder=order or 0; r.ZIndex=104; r.Parent=parent
        local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=r
        local rs=Instance.new("UIStroke"); rs.Color=C.str; rs.Thickness=1; rs.Transparency=0.5; rs.Parent=r
        local l=Instance.new("TextLabel")
        l.Size=UDim2.new(1,-20,1,0); l.Position=UDim2.new(0,14,0,0)
        l.BackgroundTransparency=1; l.Text=label; l.TextColor3=C.txt
        l.Font=Enum.Font.Gotham; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=105; l.Parent=r
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,0,1,0); b.BackgroundTransparency=1; b.Text=""
        b.ZIndex=107; b.Parent=r
        b.MouseEnter:Connect(function()
            TS:Create(r,TweenInfo.new(0.15),{BackgroundColor3=C.rowH}):Play()
            TS:Create(rs,TweenInfo.new(0.15),{Color=C.strH,Transparency=0}):Play()
        end)
        b.MouseLeave:Connect(function()
            TS:Create(r,TweenInfo.new(0.15),{BackgroundColor3=C.row}):Play()
            TS:Create(rs,TweenInfo.new(0.15),{Color=C.str,Transparency=0.5}):Play()
        end)
        b.MouseButton1Click:Connect(cb)
    end

    local tst={}
    local function notify(text)
        local t=Instance.new("Frame")
        t.Size=UDim2.new(0,260,0,42); t.Position=UDim2.new(1,20,0,20)
        t.BackgroundColor3=C.bg; t.BorderSizePixel=0
        t.ZIndex=999998; t.Parent=LG
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,10); c.Parent=t
        local s=Instance.new("UIStroke"); s.Color=C.strH; s.Thickness=1; s.Transparency=0.3; s.Parent=t
        local d=Instance.new("Frame")
        d.Size=UDim2.new(0,6,0,6); d.Position=UDim2.new(0,14,0.5,-3)
        d.BackgroundColor3=C.ac; d.BorderSizePixel=0; d.ZIndex=999999; d.Parent=t
        local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=d
        local l=Instance.new("TextLabel")
        l.Size=UDim2.new(1,-34,1,0); l.Position=UDim2.new(0,28,0,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt
        l.Font=Enum.Font.Gotham; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=999999; l.Parent=t
        for _,o in ipairs(tst) do
            TS:Create(o,TweenInfo.new(0.25),{Position=o.Position+UDim2.new(0,0,0,48)}):Play()
        end
        table.insert(tst,t)
        TS:Create(t,TweenInfo.new(0.35,Enum.EasingStyle.Back),{Position=UDim2.new(1,-280,0,20)}):Play()
        task.delay(2.2,function()
            TS:Create(t,TweenInfo.new(0.3),{Position=UDim2.new(1,20,0,20),BackgroundTransparency=1}):Play()
            TS:Create(s,TweenInfo.new(0.3),{Transparency=1}):Play()
            TS:Create(l,TweenInfo.new(0.3),{TextTransparency=1}):Play()
            TS:Create(d,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
            task.wait(0.35)
            t:Destroy()
            for i,x in ipairs(tst) do if x==t then table.remove(tst,i) break end end
        end)
    end

    local st={sky=nil,weather=nil,
        fog=false,bloom=false,ccE=false,dof=false,blur=false,sunrays=false,
        cGlow=false,cRGB=false,cTrail=false,cSpark=false,cFire=false,cFroz=false,
        cLight=false,cHeart=false,cNote=false,cFly=false,cHalo=false,cRain=false,
        head="normal",body="normal",bodyCol=nil}

    local hSt={fps=false,ping=false,clock=false,wm=false,coords=false,speed=false,
        oVig=false,oRGB=false,oScan=false}
    local hEl={}

    -- HUD updater
    local frameCount=0
    local lastTime=tick()
    local curFPS=60
    task.spawn(function()
        while HG.Parent do
            frameCount=frameCount+1
            local now=tick()
            if now-lastTime>=1 then
                curFPS=frameCount/(now-lastTime)
                frameCount=0
                lastTime=now
            end
            local ch=LP.Character
            if ch and ch:FindFirstChild("HumanoidRootPart") then
                local hrp=ch.HumanoidRootPart
                if hSt.wm and hEl.wm then hEl.wm.Text="EON VISUAL v15" end
                if hSt.fps and hEl.fps then hEl.fps.Text="FPS: "..math.floor(curFPS) end
                if hSt.clock and hEl.clock then hEl.clock.Text=os.date("%H:%M:%S") end
                if hSt.coords and hEl.coords then
                    hEl.coords.Text=string.format("X:%.0f Y:%.0f Z:%.0f",hrp.Position.X,hrp.Position.Y,hrp.Position.Z)
                end
                if hSt.speed and hEl.speed then
                    local hum=ch:FindFirstChildOfClass("Humanoid")
                    if hum then hEl.speed.Text="Speed: "..math.floor(hum.WalkSpeed) end
                end
                if hSt.ping and hEl.ping then
                    local ping=math.floor(LP:GetNetworkPing()*1000)
                    hEl.ping.Text="Ping: "..ping.."ms"
                end
            end
            task.wait(0.1)
        end
    end)

    local skyList={
        {id="space",k="sky_space"},{id="sunset",k="sky_sunset"},{id="night",k="sky_night"},
        {id="dawn",k="sky_dawn"},{id="storm",k="sky_storm"},{id="clear",k="sky_clear"},
        {id="nebula",k="sky_nebula"},{id="cartoon",k="sky_cartoon"},{id="alien",k="sky_alien"},
        {id="off",k="sky_off"},
    }
    local weaList={
        {id="rain",k="wRain"},{id="snow",k="wSnow"},{id="storm",k="wStorm"},{id="off",k="wOff"},
    }
    local shapeList={
        {id="dot",k="shDot"},{id="crosshair",k="shCH"},{id="ring",k="shRing"},
        {id="diamond",k="shDiam"},{id="star",k="shStar"},{id="arrow",k="shArrow"},
        {id="target",k="shTarg"},{id="bracket",k="shBr"},{id="heart",k="shHeart"},
        {id="lightning",k="shLight"},
    }
    local colorList={
        {k="coW",c=C.wh},{k="coB",c=Color3.fromRGB(30,30,30)},{k="coR",c=Color3.fromRGB(230,60,60)},
        {k="coC",c=Color3.fromRGB(60,200,230)},{k="coG",c=Color3.fromRGB(80,220,120)},
        {k="coGo",c=Color3.fromRGB(240,200,60)},{k="coP",c=Color3.fromRGB(255,120,180)},
        {k="coPu",c=Color3.fromRGB(180,120,255)},
    }
    local sizeList={
        {k="siS",v=10},{k="siM",v=14},{k="siL",v=20},{k="siH",v=28},
    }

    local function remEon()
        for _,v in ipairs(Lighting:GetChildren()) do
            if v.Name:sub(1,3)=="Eon" then v:Destroy() end
        end
    end

    local function applySky(id)
        remEon()
        if id=="off" then return end
        local sky=Instance.new("Sky"); sky.Name="EonSky"
        if id=="space" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime=0
        elseif id=="sunset" then
            sky.SkyboxBk="rbxassetid://188705813"; sky.SkyboxDn="rbxassetid://188705788"
            sky.SkyboxFt="rbxassetid://188705800"; sky.SkyboxLf="rbxassetid://188705834"
            sky.SkyboxRt="rbxassetid://188705821"; sky.SkyboxUp="rbxassetid://188705845"
            Lighting.ClockTime=18
        elseif id=="night" then
            sky.SkyboxBk="rbxassetid://12064107"; sky.SkyboxDn="rbxassetid://12064152"
            sky.SkyboxFt="rbxassetid://12064121"; sky.SkyboxLf="rbxassetid://12063984"
            sky.SkyboxRt="rbxassetid://12064114"; sky.SkyboxUp="rbxassetid://12063943"
            Lighting.ClockTime=0
        elseif id=="dawn" then
            sky.SkyboxBk="rbxassetid://188705813"; sky.SkyboxDn="rbxassetid://188705788"
            sky.SkyboxFt="rbxassetid://188705800"; sky.SkyboxLf="rbxassetid://188705834"
            sky.SkyboxRt="rbxassetid://188705821"; sky.SkyboxUp="rbxassetid://188705845"
            Lighting.ClockTime=6
        elseif id=="storm" then
            sky.SkyboxBk="rbxassetid://570557023"; sky.SkyboxDn="rbxassetid://570557020"
            sky.SkyboxFt="rbxassetid://570557026"; sky.SkyboxLf="rbxassetid://570557029"
            sky.SkyboxRt="rbxassetid://570557017"; sky.SkyboxUp="rbxassetid://570557032"
            Lighting.ClockTime=15
        elseif id=="clear" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime=14
        elseif id=="nebula" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime=22
        elseif id=="cartoon" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime=12
        elseif id=="alien" then
            sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300"; sky.SkyboxUp="rbxassetid://159454288"
            Lighting.ClockTime=3
        end
        sky.Parent=Lighting
    end

    local wFolder=nil
    local function applyWea(id)
        if wFolder then wFolder:Destroy(); wFolder=nil end
        if id=="off" then return end
        wFolder=Instance.new("Folder"); wFolder.Name="EonWea"; wFolder.Parent=workspace
        if id=="rain" then
            for i=1,40 do
                local p=Instance.new("Part")
                p.Size=Vector3.new(0.05,1.5,0.05)
                p.Position=Vector3.new(math.random(-40,40),math.random(20,50),math.random(-40,40))
                p.Anchored=true; p.CanCollide=false
                p.Material=Enum.Material.SmoothPlastic
                p.Color=Color3.fromRGB(180,200,255); p.Transparency=0.3
                p.Parent=wFolder
                task.spawn(function()
                    while p.Parent do
                        p.Position=p.Position-Vector3.new(0,1,0)
                        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                            if (p.Position-LP.Character.HumanoidRootPart.Position).Magnitude>60 then p:Destroy() break end
                        end
                        task.wait(0.02)
                    end
                end)
            end
        elseif id=="snow" then
            for i=1,60 do
                local p=Instance.new("Part")
                p.Shape=Enum.PartType.Ball; p.Size=Vector3.new(0.3,0.3,0.3)
                p.Position=Vector3.new(math.random(-40,40),math.random(20,50),math.random(-40,40))
                p.Anchored=true; p.CanCollide=false
                p.Material=Enum.Material.SmoothPlastic
                p.Color=Color3.fromRGB(255,255,255); p.Parent=wFolder
                task.spawn(function()
                    while p.Parent do
                        p.Position=p.Position-Vector3.new(math.random(-2,2)/10,0.1,math.random(-2,2)/10)
                        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                            if (p.Position-LP.Character.HumanoidRootPart.Position).Magnitude>60 then p:Destroy() break end
                        end
                        task.wait(0.05)
                    end
                end)
            end
        end
    end

    local cfx={}
    local function clrCFX()
        for _,o in ipairs(cfx) do pcall(function() o:Destroy() end) end
        cfx={}
    end
    local function applyCFX()
        clrCFX()
        local ch=LP.Character
        if not ch then return end
        local hrp=ch:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if st.cGlow then
            local l=Instance.new("PointLight")
            l.Brightness=3; l.Range=15; l.Color=C.wh; l.Parent=hrp
            table.insert(cfx,l)
        end
        if st.cRGB then
            local l=Instance.new("PointLight")
            l.Brightness=4; l.Range=18; l.Parent=hrp
            table.insert(cfx,l)
            task.spawn(function()
                while l.Parent do
                    l.Color=Color3.fromHSV((tick()*0.3)%1,0.9,1)
                    task.wait(0.05)
                end
            end)
        end
        if st.cTrail then
            local a0=Instance.new("Attachment"); a0.Position=Vector3.new(1,0,0); a0.Parent=hrp
            local a1=Instance.new("Attachment"); a1.Position=Vector3.new(-1,0,0); a1.Parent=hrp
            local tr=Instance.new("Trail")
            tr.Attachment0=a0; tr.Attachment1=a1; tr.Lifetime=0.5
            tr.Color=ColorSequence.new(C.wh)
            tr.Transparency=NumberSequence.new({
                NumberSequenceKeypoint.new(0,0.3), NumberSequenceKeypoint.new(1,1)
            })
            tr.Parent=hrp
            table.insert(cfx,a0); table.insert(cfx,a1); table.insert(cfx,tr)
        end
        if st.cSpark then
            local s=Instance.new("Sparkles"); s.SparkleColor=C.wh; s.Parent=hrp
            table.insert(cfx,s)
        end
        if st.cFire then
            local f=Instance.new("Fire")
            f.Size=4; f.Heat=8
            f.Color=Color3.fromRGB(255,120,50); f.SecondaryColor=Color3.fromRGB(255,200,100)
            f.Parent=hrp
            table.insert(cfx,f)
        end
        local function mkParticle(tex,rate,sp,life,col,sz)
            local p=Instance.new("ParticleEmitter")
            p.Texture=tex; p.Rate=rate; p.Speed=NumberRange.new(sp,sp+2)
            p.Lifetime=NumberRange.new(life,life+1)
            p.Color=ColorSequence.new(col); p.Size=NumberSequence.new(sz)
            p.Parent=hrp
            table.insert(cfx,p)
        end
        if st.cFroz then mkParticle("rbxassetid://243660364",30,2,0.5,Color3.fromRGB(150,220,255),0.4) end
        if st.cLight then mkParticle("rbxassetid://243098098",5,1,0.3,Color3.fromRGB(255,255,100),0.6) end
        if st.cHeart then mkParticle("rbxassetid://7136670107",5,3,1,Color3.fromRGB(255,100,150),0.5) end
        if st.cNote then mkParticle("rbxassetid://8072541754",5,3,1,Color3.fromRGB(255,255,150),0.5) end
        if st.cFly then mkParticle("",15,1.5,2,Color3.fromRGB(255,255,100),0.3) end
        if st.cHalo then
            local s=Instance.new("SelectionSphere")
            s.Adornee=hrp; s.Color3=Color3.fromRGB(255,220,100)
            s.Transparency=0.5; s.SurfaceTransparency=0.5; s.Parent=hrp
            table.insert(cfx,s)
        end
        if st.cRain then
            local l=Instance.new("PointLight")
            l.Brightness=3; l.Range=20; l.Parent=hrp
            table.insert(cfx,l)
            task.spawn(function()
                while l.Parent do
                    l.Color=Color3.fromHSV((tick()*0.5)%1,1,1)
                    task.wait(0.05)
                end
            end)
        end
        if st.head~="normal" then
            local head=ch:FindFirstChild("Head")
            if head then
                head.Size=st.head=="big" and Vector3.new(2,2,2) or Vector3.new(0.5,0.5,0.5)
                head.Massless=true
            end
        end
        if st.body~="normal" then
            local torso=ch:FindFirstChild("Torso") or ch:FindFirstChild("UpperTorso")
            if torso then
                if st.body=="wide" then torso.Size=Vector3.new(3,2,1)
                elseif st.body=="tall" then torso.Size=Vector3.new(2,4,1)
                elseif st.body=="small" then torso.Size=Vector3.new(1,1,0.5) end
            end
        end
        if st.bodyCol then
            for _,p in ipairs(ch:GetChildren()) do
                if p:IsA("BasePart") then p.Color=st.bodyCol end
            end
        end
    end
    LP.CharacterAdded:Connect(function() task.wait(1) applyCFX() end)

    local function createHudEl(id,name,pos,txt)
        if hEl[id] then return end
        local l=Instance.new("TextLabel")
        l.Name=name
        l.Size=UDim2.new(0,200,0,22); l.Position=pos
        l.BackgroundColor3=Color3.fromRGB(0,0,0); l.BackgroundTransparency=0.5
        l.BorderSizePixel=0; l.Text=txt; l.TextColor3=C.wh
        l.Font=Enum.Font.GothamBold; l.TextSize=12
        l.TextStrokeTransparency=0.5; l.ZIndex=999991; l.Parent=HG
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,4); c.Parent=l
        if id=="wm" then l.TextColor3=C.ac end
        hEl[id]=l
    end
    local function removeHudEl(id)
        if hEl[id] then
            pcall(function() hEl[id]:Destroy() end)
            hEl[id]=nil
        end
    end

    local function fmtD(ts)
        if not ts or ts==0 then return "—" end
        local d=os.date("*t",ts)
        return string.format("%02d.%02d.%04d",d.day,d.month,d.year)
    end

    local cats={
        {id="world",icon="🌍",k="cw"},
        {id="visuals",icon="✨",k="cv"},
        {id="player",icon="👤",k="cp"},
        {id="screen",icon="🖥",k="cs"},
        {id="cursor",icon="🎯",k="cc"},
        {id="sound",icon="🔊",k="csn"},
        {id="sub",icon="⭐",k="csub"},
        {id="settings",icon="⚙",k="cst"},
    }
    local catBtn={}
    local act="world"

    local render
    render=function()
        clr()
        if act=="world" then
            mkSec(tr("sSky"),1)
            local g1=mkGrid(2)
            for i,s in ipairs(skyList) do
                mkTog(g1,tr(s.k),st.sky==s.id,function(on)
                    if on then
                        applySky(s.id); st.sky=s.id
                        notify("Небо: "..tr(s.k)); render()
                    else
                        if st.sky==s.id then
                            for _,v in ipairs(Lighting:GetChildren()) do
                                if v.Name=="EonSky" then v:Destroy() end
                            end
                            st.sky=nil; notify("Небо выкл"); render()
                        end
                    end
                end,i)
            end
            mkSec(tr("sWea"),20)
            local g2=mkGrid(21)
            for i,w in ipairs(weaList) do
                mkTog(g2,tr(w.k),st.weather==w.id,function(on)
                    if on then
                        applyWea(w.id); st.weather=w.id
                        notify(tr(w.k)); render()
                    else
                        if st.weather==w.id then
                            applyWea("off"); st.weather=nil
                            notify("Погода выкл"); render()
                        end
                    end
                end,i)
            end
            mkSec(tr("sTim"),40)
            local g3=mkGrid(41)
            mkBtn(g3,tr("tDay"),function() Lighting.ClockTime=14 notify(tr("tDay")) end,1)
            mkBtn(g3,tr("tEve"),function() Lighting.ClockTime=18 notify(tr("tEve")) end,2)
            mkBtn(g3,tr("tNight"),function() Lighting.ClockTime=0 notify(tr("tNight")) end,3)
            mkBtn(g3,tr("tMorn"),function() Lighting.ClockTime=6 notify(tr("tMorn")) end,4)
            mkBtn(g3,tr("tReal"),function()
                local t=os.date("*t"); Lighting.ClockTime=t.hour+t.min/60
                notify(tr("tReal"))
            end,5)
        elseif act=="visuals" then
            mkSec(tr("sLig"),1)
            local g=mkGrid(2)
            local fx={
                {k="fog",n="EonFog",set=function(v) st.fog=v end,mk=function()
                    local a=Instance.new("Atmosphere")
                    a.Density=0.4; a.Offset=0.25
                    a.Color=Color3.fromRGB(200,200,220)
                    a.Decay=Color3.fromRGB(120,100,140)
                    return a end},
                {k="bloom",n="EonBloom",set=function(v) st.bloom=v end,mk=function()
                    local b=Instance.new("BloomEffect"); b.Intensity=1.5; b.Size=32; b.Threshold=0.8; return b end},
                {k="ccE",n="EonCC",set=function(v) st.ccE=v end,mk=function()
                    local c=Instance.new("ColorCorrectionEffect")
                    c.Brightness=0.05; c.Contrast=0.15; c.Saturation=0.25; return c end},
                {k="dof",n="EonDOF",set=function(v) st.dof=v end,mk=function()
                    local d=Instance.new("DepthOfFieldEffect")
                    d.FarIntensity=0.3; d.FocusDistance=50; d.InFocusRadius=30; return d end},
                {k="blur",n="EonBlur",set=function(v) st.blur=v end,mk=function()
                    local b=Instance.new("BlurEffect"); b.Size=8; return b end},
                {k="sunrays",n="EonSun",set=function(v) st.sunrays=v end,mk=function()
                    local s=Instance.new("SunRaysEffect"); s.Intensity=0.15; s.Spread=1; return s end},
            }
            for i,f in ipairs(fx) do
                mkTog(g,tr(f.k),st[f.k],function(on)
                    f.set(on)
                    local ex=Lighting:FindFirstChild(f.n)
                    if on then
                        if not ex then local o=f.mk(); o.Name=f.n; o.Parent=Lighting end
                    else if ex then ex:Destroy() end end
                    notify(tr(f.k)..": "..(on and "ВКЛ" or "ВЫКЛ"))
                end,i)
            end
        elseif act=="player" then
            mkSec(tr("sCf"),1)
            local g=mkGrid(2)
            local fx={
                {k="cGlow",set=function(v) st.cGlow=v end},
                {k="cRGB",set=function(v) st.cRGB=v end},
                {k="cTrail",set=function(v) st.cTrail=v end},
                {k="cSpark",set=function(v) st.cSpark=v end},
                {k="cFire",set=function(v) st.cFire=v end},
                {k="cFroz",set=function(v) st.cFroz=v end},
                {k="cLight",set=function(v) st.cLight=v end},
                {k="cHeart",set=function(v) st.cHeart=v end},
                {k="cNote",set=function(v) st.cNote=v end},
                {k="cFly",set=function(v) st.cFly=v end},
                {k="cHalo",set=function(v) st.cHalo=v end},
                {k="cRain",set=function(v) st.cRain=v end},
            }
            for i,f in ipairs(fx) do
                mkTog(g,tr(f.k),st[f.k],function(on)
                    f.set(on); applyCFX()
                    notify(tr(f.k)..": "..(on and "ВКЛ" or "ВЫКЛ"))
                end,i)
            end
            mkSec(tr("sCz"),30)
            local g2=mkGrid(31)
            mkBtn(g2,tr("hBig"),function() st.head="big" applyCFX() notify(tr("hBig")) end,1)
            mkBtn(g2,tr("hSmall"),function() st.head="small" applyCFX() notify(tr("hSmall")) end,2)
            mkBtn(g2,tr("hNorm"),function() st.head="normal" applyCFX() notify(tr("hNorm")) end,3)
            mkBtn(g2,tr("bNorm"),function() st.body="normal" applyCFX() notify(tr("bNorm")) end,4)
            mkBtn(g2,tr("bWide"),function() st.body="wide" applyCFX() notify(tr("bWide")) end,5)
            mkBtn(g2,tr("bTall"),function() st.body="tall" applyCFX() notify(tr("bTall")) end,6)
            mkBtn(g2,tr("bSmall"),function() st.body="small" applyCFX() notify(tr("bSmall")) end,7)
            mkSec(tr("sCc"),50)
            local g3=mkGrid(51)
            mkBtn(g3,tr("colR"),function() st.bodyCol=Color3.fromRGB(220,60,60) applyCFX() notify(tr("colR")) end,1)
            mkBtn(g3,tr("colB"),function() st.bodyCol=Color3.fromRGB(60,120,220) applyCFX() notify(tr("colB")) end,2)
            mkBtn(g3,tr("colG"),function() st.bodyCol=Color3.fromRGB(80,200,100) applyCFX() notify(tr("colG")) end,3)
            mkBtn(g3,tr("colY"),function() st.bodyCol=Color3.fromRGB(240,220,60) applyCFX() notify(tr("colY")) end,4)
            mkBtn(g3,tr("colP"),function() st.bodyCol=Color3.fromRGB(180,100,220) applyCFX() notify(tr("colP")) end,5)
            mkBtn(g3,tr("colW"),function() st.bodyCol=Color3.fromRGB(255,255,255) applyCFX() notify(tr("colW")) end,6)
            mkBtn(g3,tr("colReset"),function() st.bodyCol=nil applyCFX() notify(tr("colReset")) end,7)
        elseif act=="screen" then
            mkSec(tr("sHUD"),1)
            local g=mkGrid(2)
            local hudList={
                {k="hFPS",id="fps",name="EonFPS",pos=UDim2.new(0,20,0,50),txt="FPS: 60"},
                {k="hPing",id="ping",name="EonPing",pos=UDim2.new(0,20,0,80),txt="Ping: 0"},
                {k="hClock",id="clock",name="EonClock",pos=UDim2.new(1,-180,0,20),txt="00:00:00"},
                {k="hWM",id="wm",name="EonWM",pos=UDim2.new(0,20,0,20),txt="EON VISUAL v15"},
                {k="hCoord",id="coords",name="EonCoords",pos=UDim2.new(0,20,1,-50),txt="X:0 Y:0 Z:0"},
                {k="hSpeed",id="speed",name="EonSpeed",pos=UDim2.new(0,20,1,-80),txt="Speed: 16"},
            }
            for i,h in ipairs(hudList) do
                mkTog(g,tr(h.k),hSt[h.id],function(on)
                    hSt[h.id]=on
                    if on then
                        if not hEl[h.id] then
                            createHudEl(h.id,h.name,h.pos,h.txt)
                        end
                    else
                        removeHudEl(h.id)
                    end
                    notify(tr(h.k)..": "..(on and "ВКЛ" or "ВЫКЛ"))
                end,i)
            end
            mkSec(tr("sOv"),20)
            local g2=mkGrid(21)
            local ovList={
                {k="oVig",id="oVig"},{k="oRGB",id="oRGB"},{k="oScan",id="oScan"},
            }
            for i,o in ipairs(ovList) do
                mkTog(g2,tr(o.k),hSt[o.id],function(on)
                    hSt[o.id]=on
                    local ex=HG:FindFirstChild("Ov_"..o.id)
                    if on and not ex then
                        if o.id=="oVig" then
                            local f=Instance.new("Frame")
                            f.Name="Ov_oVig"; f.Size=UDim2.new(1,0,1,0)
                            f.BackgroundColor3=Color3.fromRGB(0,0,0)
                            f.BackgroundTransparency=0.6; f.BorderSizePixel=0
                            f.ZIndex=1; f.Parent=HG
                        elseif o.id=="oRGB" then
                            local f=Instance.new("Frame")
                            f.Name="Ov_oRGB"; f.Size=UDim2.new(1,0,1,0)
                            f.BackgroundTransparency=1; f.BorderSizePixel=0
                            f.ZIndex=2; f.Parent=HG
                            local s=Instance.new("UIStroke")
                            s.Thickness=4; s.Parent=f
                            task.spawn(function()
                                while f.Parent do
                                    s.Color=Color3.fromHSV((tick()*0.3)%1,1,1)
                                    task.wait(0.05)
                                end
                            end)
                        elseif o.id=="oScan" then
                            local f=Instance.new("Frame")
                            f.Name="Ov_oScan"; f.Size=UDim2.new(1,0,1,0)
                            f.BackgroundTransparency=1; f.ZIndex=3; f.Parent=HG
                            for j=0,60 do
                                local ln=Instance.new("Frame")
                                ln.Size=UDim2.new(1,0,0,1)
                                ln.Position=UDim2.new(0,0,j/60,0)
                                ln.BackgroundColor3=Color3.fromRGB(0,0,0)
                                ln.BackgroundTransparency=0.85
                                ln.BorderSizePixel=0; ln.ZIndex=3; ln.Parent=f
                            end
                        end
                    elseif not on and ex then ex:Destroy() end
                    notify(tr(o.k)..": "..(on and "ВКЛ" or "ВЫКЛ"))
                end,i)
            end
        elseif act=="cursor" then
            mkSec(tr("sFx"),1)
            local g0=mkGrid(2)
            mkTog(g0,cs.enabled and tr("cOn") or tr("cOff"),cs.enabled,function(on)
                cs.enabled=on; CGui.Enabled=on
                UIS.MouseIconEnabled=not on
                notify(on and "Курсор вкл" or "Курсор выкл")
                render()
            end,1)
            mkTog(g0,tr("cTrail"),cs.trail,function(on)
                cs.trail=on; notify("Трейл: "..(on and "ВКЛ" or "ВЫКЛ"))
            end,2)
            mkTog(g0,tr("cPulse"),cs.pulse,function(on)
                cs.pulse=on
                if not on then CR.Size=UDim2.new(0,100,0,100) end
                notify("Пульсация: "..(on and "ВКЛ" or "ВЫКЛ"))
            end,3)
            mkSec(tr("sSh"),20)
            local g1=mkGrid(21)
            for i,s in ipairs(shapeList) do
                mkTog(g1,tr(s.k),cs.shape==s.id,function(on)
                    if on then
                        cs.shape=s.id; buildS(s.id)
                        cs.enabled=true; CGui.Enabled=true
                        UIS.MouseIconEnabled=false
                        notify("Форма: "..tr(s.k)); render()
                    end
                end,i)
            end
            mkSec(tr("sCo"),40)
            local g2=mkGrid(41)
            for i,c in ipairs(colorList) do
                mkTog(g2,tr(c.k),cs.color==c.c,function(on)
                    if on then
                        cs.color=c.c; cs.rgb=false; buildS(cs.shape)
                        notify("Цвет: "..tr(c.k)); render()
                    end
                end,i)
            end
            mkTog(g2,tr("coRGB"),cs.rgb,function(on)
                cs.rgb=on
                if not on then buildS(cs.shape) end
                notify("RGB: "..(on and "ВКЛ" or "ВЫКЛ"))
            end,100)
            mkSec(tr("sSi"),60)
            local g3=mkGrid(61)
            for i,s in ipairs(sizeList) do
                mkTog(g3,tr(s.k),cs.size==s.v,function(on)
                    if on then
                        cs.size=s.v; buildS(cs.shape)
                        notify("Размер: "..tr(s.k)); render()
                    end
                end,i)
            end
        elseif act=="sound" then
            mkSec(tr("sMus"),1)
            local g=mkGrid(2)
            mkBtn(g,tr("mE"),function()
                notify(tr("mE"))
                local s=Instance.new("Sound")
                s.SoundId="rbxassetid://1837879082"; s.Volume=0.5
                s.Looped=true; s.Parent=SS
                s:Play()
                task.delay(10,function() s:Destroy() end)
            end,1)
            mkBtn(g,tr("mC"),function()
                notify(tr("mC"))
                local s=Instance.new("Sound")
                s.SoundId="rbxassetid://1836132708"; s.Volume=0.5
                s.Looped=true; s.Parent=SS
                s:Play()
                task.delay(10,function() s:Destroy() end)
            end,2)
            mkBtn(g,tr("mN"),function()
                for _,s in ipairs(SS:GetChildren()) do
                    if s:IsA("Sound") then s:Destroy() end
                end
                notify("Музыка выкл")
            end,3)
            mkSec(tr("sSfx"),20)
            local g2=mkGrid(21)
            mkBtn(g2,tr("sfxC"),function()
                local s=Instance.new("Sound")
                s.SoundId="rbxassetid://5028857084"; s.Volume=0.5
                s.Parent=SS; s:Play()
                task.delay(1,function() s:Destroy() end)
            end,1)
            mkBtn(g2,tr("sfxH"),function()
                local s=Instance.new("Sound")
                s.SoundId="rbxassetid://6042053626"; s.Volume=0.4
                s.Parent=SS; s:Play()
                task.delay(1,function() s:Destroy() end)
            end,2)
        elseif act=="sub" then
            mkSec(tr("subS"),1)
            if #subs==0 then
                local e=Instance.new("Frame")
                e.Size=UDim2.new(1,-10,0,110)
                e.BackgroundColor3=C.row; e.BorderSizePixel=0
                e.LayoutOrder=3; e.ZIndex=103; e.Parent=CS
                local ec=Instance.new("UICorner"); ec.CornerRadius=UDim.new(0,10); ec.Parent=e
                local l=Instance.new("TextLabel")
                l.Size=UDim2.new(1,-20,1,0); l.Position=UDim2.new(0,10,0,0)
                l.BackgroundTransparency=1; l.Text=tr("subN").."\n"..tr("subND")
                l.TextColor3=C.dim; l.Font=Enum.Font.Gotham
                l.TextSize=12; l.TextYAlignment=Enum.TextYAlignment.Center
                l.ZIndex=104; l.Parent=e
            else
                local ord=3
                for _,sub in ipairs(subs) do
                    local isL=sub.lifetime
                    local isExp=false
                    if not isL and sub.expiresAt and sub.expiresAt>0 then
                        isExp=sub.expiresAt<=os.time()
                    end
                    local isA=isL or not isExp
                    local card=Instance.new("Frame")
                    card.Size=UDim2.new(1,-10,0,160)
                    card.BackgroundColor3=C.row; card.BorderSizePixel=0
                    card.LayoutOrder=ord; card.ZIndex=103; card.Parent=CS
                    ord=ord+1
                    local cc=Instance.new("UICorner"); cc.CornerRadius=UDim.new(0,12); cc.Parent=card
                    local csx=Instance.new("UIStroke")
                    csx.Color=isA and (isL and C.warn or C.suc) or C.dan
                    csx.Thickness=1.5; csx.Transparency=0.5; csx.Parent=card
                    local pl=Instance.new("TextLabel")
                    pl.Size=UDim2.new(1,-170,0,22); pl.Position=UDim2.new(0,22,0,14)
                    pl.BackgroundTransparency=1; pl.Text=sub.product
                    pl.TextColor3=C.wh; pl.Font=Enum.Font.GothamBlack
                    pl.TextSize=16; pl.TextXAlignment=Enum.TextXAlignment.Left
                    pl.ZIndex=104; pl.Parent=card
                    local bb=Instance.new("Frame")
                    bb.Size=UDim2.new(0,110,0,24); bb.Position=UDim2.new(1,-124,0,14)
                    bb.BackgroundColor3=isA and (isL and C.warn or C.suc) or C.dan
                    bb.BackgroundTransparency=0.85; bb.BorderSizePixel=0
                    bb.ZIndex=104; bb.Parent=card
                    local bbc=Instance.new("UICorner"); bbc.CornerRadius=UDim.new(1,0); bbc.Parent=bb
                    local bt=Instance.new("TextLabel")
                    bt.Size=UDim2.new(1,0,1,0); bt.BackgroundTransparency=1
                    if isL then bt.Text="∞ "..tr("subL")
                    elseif isA then bt.Text="● "..tr("subA")
                    else bt.Text="● "..tr("subE") end
                    bt.TextColor3=isA and (isL and C.warn or C.suc) or C.dan
                    bt.Font=Enum.Font.GothamBold; bt.TextSize=9
                    bt.ZIndex=105; bt.Parent=bb
                    local kl=Instance.new("TextLabel")
                    kl.Size=UDim2.new(1,-40,0,14); kl.Position=UDim2.new(0,22,0,44)
                    kl.BackgroundTransparency=1; kl.Text=tr("subK")..": "..tostring(sub.key)
                    kl.TextColor3=C.dim2; kl.Font=Enum.Font.Gotham
                    kl.TextSize=10; kl.TextXAlignment=Enum.TextXAlignment.Left
                    kl.ZIndex=104; kl.Parent=card
                    local bl=Instance.new("TextLabel")
                    bl.Size=UDim2.new(1,-40,0,14); bl.Position=UDim2.new(0,22,0,66)
                    bl.BackgroundTransparency=1; bl.Text=tr("subB")..": "..fmtD(sub.activatedAt)
                    bl.TextColor3=C.dim; bl.Font=Enum.Font.Gotham
                    bl.TextSize=10; bl.TextXAlignment=Enum.TextXAlignment.Left
                    bl.ZIndex=104; bl.Parent=card
                    local el=Instance.new("TextLabel")
                    el.Size=UDim2.new(1,-40,0,14); el.Position=UDim2.new(0,22,0,84)
                    el.BackgroundTransparency=1
                    el.Text=tr("subX")..": "..(isL and "∞" or fmtD(sub.expiresAt))
                    el.TextColor3=C.dim; el.Font=Enum.Font.Gotham
                    el.TextSize=10; el.TextXAlignment=Enum.TextXAlignment.Left
                    el.ZIndex=104; el.Parent=card
                    local dl=Instance.new("TextLabel")
                    dl.Size=UDim2.new(1,-40,0,20); dl.Position=UDim2.new(0,22,0,110)
                    dl.BackgroundTransparency=1
                    if isL then
                        dl.Text="∞ "..tr("subF"); dl.TextColor3=C.warn
                    else
                        local diff=sub.expiresAt-os.time()
                        if diff<=0 then
                            dl.Text="● "..tr("subE"); dl.TextColor3=C.dan
                        else
                            dl.Text=tr("left")..math.floor(diff/86400)..tr("days")
                            dl.TextColor3=C.txt
                        end
                    end
                    dl.Font=Enum.Font.GothamBold; dl.TextSize=11
                    dl.TextXAlignment=Enum.TextXAlignment.Left
                    dl.ZIndex=104; dl.Parent=card
                end
            end
            task.defer(upd)
        elseif act=="settings" then
            mkSec(tr("sLan"),1)
            local g1=mkGrid(2)
            mkTog(g1,tr("langRu"),Lang=="ru",function(on)
                if on then
                    Lang="ru"
                    for _,b in ipairs(catBtn) do b.label.Text=tr(b.key) end
                    render(); notify("Язык: Русский")
                end
            end,1)
            mkTog(g1,tr("langEn"),Lang=="en",function(on)
                if on then
                    Lang="en"
                    for _,b in ipairs(catBtn) do b.label.Text=tr(b.key) end
                    render(); notify("Language: English")
                end
            end,2)
            mkSec(tr("sRes"),20)
            local g2=mkGrid(21)
            mkBtn(g2,tr("reset"),function()
                for _,v in ipairs(Lighting:GetChildren()) do
                    if v.Name:sub(1,3)=="Eon" then v:Destroy() end
                end
                if wFolder then wFolder:Destroy(); wFolder=nil end
                clrCFX()
                for k in pairs(st) do if type(st[k])=="boolean" then st[k]=false end end
                st.sky=nil; st.weather=nil
                st.head="normal"; st.body="normal"; st.bodyCol=nil
                for _,v in ipairs(HG:GetChildren()) do
                    if v:IsA("GuiObject") then v:Destroy() end
                end
                for k in pairs(hSt) do hSt[k]=false end
                hEl={}
                notify(tr("reset")); render()
            end,1)
            mkSec("EON VISUAL v15 · eon.website",40)
        end
    end

    local function renderSB()
        for _,b in ipairs(catBtn) do
            if b.id==act then
                TS:Create(b.row,TweenInfo.new(0.25),{BackgroundColor3=C.row}):Play()
                b.icon.TextColor3=C.wh
                b.label.TextColor3=C.wh
                b.bar.Visible=true
            else
                TS:Create(b.row,TweenInfo.new(0.25),{BackgroundColor3=C.bg2}):Play()
                b.icon.TextColor3=C.dim
                b.label.TextColor3=C.dim
                b.bar.Visible=false
            end
        end
    end

    local function selCat(id)
        act=id; renderSB(); render()
    end

    -- ЗАЩИТА ОТ ДУБЛИРОВАНИЯ: очищаем всё перед добавлением
    for _,c in ipairs(NSc:GetChildren()) do
        if c:IsA("GuiObject") then c:Destroy() end
    end

    for i,cat in ipairs(cats) do
        local row=Instance.new("Frame")
        row.Size=UDim2.new(1,-20,0,38); row.Position=UDim2.new(0,10,0,0)
        row.BackgroundColor3=C.bg2; row.BorderSizePixel=0
        row.LayoutOrder=i; row.ZIndex=103; row.Parent=NSc
        local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=row
        local bar=Instance.new("Frame")
        bar.Size=UDim2.new(0,3,0,18); bar.Position=UDim2.new(0,0,0.5,-9)
        bar.BackgroundColor3=C.ac; bar.BorderSizePixel=0
        bar.ZIndex=105; bar.Visible=false; bar.Parent=row
        local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(1,0); bc.Parent=bar
        local icon=Instance.new("TextLabel")
        icon.Size=UDim2.new(0,28,1,0); icon.Position=UDim2.new(0,12,0,0)
        icon.BackgroundTransparency=1; icon.Text=cat.icon
        icon.TextColor3=C.dim; icon.Font=Enum.Font.Gotham
        icon.TextSize=15; icon.ZIndex=104; icon.Parent=row
        local label=Instance.new("TextLabel")
        label.Size=UDim2.new(1,-50,1,0); label.Position=UDim2.new(0,46,0,0)
        label.BackgroundTransparency=1; label.Text=tr(cat.k)
        label.TextColor3=C.dim; label.Font=Enum.Font.Gotham
        label.TextSize=12; label.TextXAlignment=Enum.TextXAlignment.Left
        label.ZIndex=104; label.Parent=row
        local btn=Instance.new("TextButton")
        btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1
        btn.Text=""; btn.ZIndex=106; btn.Parent=row
        btn.MouseEnter:Connect(function()
            if act~=cat.id then TS:Create(row,TweenInfo.new(0.15),{BackgroundColor3=C.rowH}):Play() end
        end)
        btn.MouseLeave:Connect(function()
            if act~=cat.id then TS:Create(row,TweenInfo.new(0.15),{BackgroundColor3=C.bg2}):Play() end
        end)
        btn.MouseButton1Click:Connect(function() selCat(cat.id) end)
        table.insert(catBtn,{id=cat.id,row=row,icon=icon,label=label,bar=bar,key=cat.k})
    end

    renderSB()
    render()

    local opened=false
    local function doOpen()
        opened=true
        Main.Visible=true
        Main.Size=UDim2.new(0,0,0,0); Main.Position=UDim2.new(0.5,0,0.5,0)
        Main.BackgroundTransparency=1
        TS:Create(Main,TweenInfo.new(0.4,Enum.EasingStyle.Back),{
            Size=UDim2.new(0,MW,0,MH),
            Position=UDim2.new(0.5,-MW/2,0.5,-MH/2),
            BackgroundTransparency=0,
        }):Play()
    end
    local function doClose()
        opened=false
        TS:Create(Main,TweenInfo.new(0.25),{
            Size=UDim2.new(0,0,0,0), Position=UDim2.new(0.5,0,0.5,0),
            BackgroundTransparency=1
        }):Play()
        task.wait(0.26)
        Main.Visible=false
    end

    CB.MouseButton1Click:Connect(doClose)
    UIS.InputBegan:Connect(function(inp,gp)
        if gp then return end
        if inp.KeyCode==Enum.KeyCode.Insert or inp.KeyCode==Enum.KeyCode.RightShift then
            if opened then doClose() else doOpen() end
        end
    end)

    if isMob then
        local OB=Instance.new("TextButton")
        OB.Size=UDim2.new(0,64,0,64)
        OB.Position=UDim2.new(1,-90,1,-100)
        OB.BackgroundColor3=C.ac; OB.BorderSizePixel=0
        OB.Text="E"; OB.TextColor3=C.wh
        OB.Font=Enum.Font.GothamBlack; OB.TextSize=28
        OB.AutoButtonColor=false; OB.ZIndex=999991
        OB.Active=true; OB.Parent=LG
        local OBC=Instance.new("UICorner"); OBC.CornerRadius=UDim.new(1,0); OBC.Parent=OB
        local OBG=Instance.new("UIGradient")
        OBG.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,C.ac),
            ColorSequenceKeypoint.new(0.5,C.ac2),
            ColorSequenceKeypoint.new(1,C.ac3),
        })
        OBG.Rotation=45; OBG.Parent=OB
        local dg,ds2,sp2=false,nil,nil
        OB.InputBegan:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.Touch or inp.UserInputType==Enum.UserInputType.MouseButton1 then
                dg=true; ds2=inp.Position; sp2=OB.Position
            end
        end)
        UIS.InputChanged:Connect(function(inp)
            if dg and (inp.UserInputType==Enum.UserInputType.Touch or inp.UserInputType==Enum.UserInputType.MouseMovement) then
                local d=inp.Position-ds2
                OB.Position=UDim2.new(sp2.X.Scale,sp2.X.Offset+d.X,sp2.Y.Scale,sp2.Y.Offset+d.Y)
            end
        end)
        UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.Touch or inp.UserInputType==Enum.UserInputType.MouseButton1 then
                dg=false
            end
        end)
        OB.MouseButton1Click:Connect(function()
            if opened then doClose() else doOpen() end
        end)
    end

    task.wait(0.5)
    notify("EON VISUAL v15 загружен ✓")
    task.wait(0.4)
    doOpen()
    print("[EON v15] Loaded · "..dType)
end
