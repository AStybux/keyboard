local bd={} --> #ревизия 11.05.2025
bd.d=0 --> bd.d=os.date("!*t")
bd.w, bd.h= display.contentWidth, display.contentHeight
bd.l="RUSSIAN"
bd.pathp="assets/images/"

local tf={} --> #ревизия 11.05.2025
tf.f="assets/font/mf.ttf"
tf.s=16

local t={} --> #ревизия 11.05.2025
t.sx=24
t.sy=4
t.x=0
t.y=bd.h-t.sx
t.d=8
t.i={"railroad1.png", "railroad2.png"}
t.n=math.ceil(bd.w/t.sx/t.d)


local f={} --> #ревизия 11.05.2025
f.q=64*4 --> trtdnt[5]="STARS: "..f.q
f.h={170/255,185/256,194/255,0.4}
f.z={210/255, 125/255, 44/255}
f.s=""

local s={} --> #ревизия 11.05.2025
s.w=false

local trtdnt={} --> #ревизия 11.05.2025
trtdnt[1]=""
trtdnt[2]="HEIGHT: "..display.actualContentHeight
trtdnt[3]="WIDTH: "..display.actualContentWidth
trtdnt[4]=""
trtdnt[5]="STARS: "..f.q
trtdnt[6]="LANGUAGE: "..bd.l
trtdnt.f=""
trtdnt.w=true
trtdnt.m={}

local function toggleFunction() --> #ревизия 11.05.2025
    s.w = not s.w
    trtdnt.w = not trtdnt.w
end

local function createSkyGradient(horizonColor, zenithColor) --> #ревизия 11.05.2025
    local skyRect = display.newRect(bd.w * 0.5, bd.h * 0.5, bd.w, bd.h)
    local paint = {
        type = "gradient",
        color1 = horizonColor,
        color2 = zenithColor,
        direction = "down"
    }
    skyRect.fill = paint
    return skyRect
end

local function createStars(numStars) --> #ревизия 11.05.2025
    local starsGroup = display.newGroup()
    for i = 1, numStars do
        local x = math.random(0, bd.w)
        local y = math.random(0, bd.h * 0.7) --upper 70%
        local starSize = math.random(2,4)
        local alpha = 0.3 + math.random() * 0.7
        local star = display.newCircle(starsGroup, x, y, starSize)
        -- star.fill.effect = "filter.pixelate"
        -- star.fill.effect.numPixels = 8
        star:setFillColor(1, 1, 1, alpha)
    end
    return starsGroup
end

local function twinkleStars() --> #ревизия 11.05.2025
    for i = 1, f.s.numChildren do
        local star = f.s[i]
        star.alpha = 0.3 + math.abs(math.sin(system.getTimer() * 0.002 + i)) * 0.7
    end
end

local function trt_main() --> #ревизия 11.05.2025
    local toprighttext = display.newText(trtdnt.f, 0, 0, tf.f, tf.s) 
    toprighttext.anchorX = 0
    toprighttext.anchorY = 0
    return toprighttext
end

local function onEnterFrame() --> #ревизия 11.05.2025
    if not trtdnt.w then
        trtdnt.m:setFillColor(20/255,12/256,28/255)
        bd.d=os.date("!*t")
        trtdnt[1]="FPS: "..display.fps
        trtdnt[4]="TIME:"..(bd.d.hour+3)..":"..bd.d.min..":"..bd.d.sec
        for i = 1, #trtdnt do trtdnt.f=trtdnt[i] .."\n".. trtdnt.f end
        trtdnt.m.text = trtdnt.f
        trtdnt.f=""
    else trtdnt.m:setFillColor(0,0,0,0) end
end

local function frame_main() --> #ревизия 11.05.2025
    twinkleStars()
    onEnterFrame()
end

local function track() --> #ревизия 11.05.2025
        local trackGroup = display.newGroup()

    for i = 1, t.n do
        local tileImage = t.i[(i % 2) + 1]
        local tile = display.newImageRect(trackGroup, bd.pathp..tileImage, 24*t.d, 4*t.d)
        tile.fill.effect = "filter.pixelate"
        tile.fill.effect.numPixels = 1
        tile.x = t.x + (i - 1) * 24 *t.d
        tile.y = t.y
    end
end

local function button_settings() --> #ревизия 11.05.2025
    local settingsButton = display.newImageRect("assets/images/settings_s_1.png", 64, 64)
    settingsButton.fill.effect = "filter.pixelate"
    settingsButton.fill.effect.numPixels = 1
    local margin = 20
    settingsButton.x = bd.w - margin - settingsButton.width / 2
    settingsButton.y = bd.h - margin - settingsButton.height / 2 -t.sx

    settingsButton:addEventListener("tap", function()
        toggleFunction()
        if s.w then
            settingsButton.alpha = 1
        else
            settingsButton.alpha = 0.5
        end
    end)
    settingsButton.alpha = 0.5
end 

createSkyGradient(f.h, f.z)
f.s = createStars(f.q)
trtdnt.m=trt_main()
track()
button_settings()
Runtime:addEventListener("enterFrame", frame_main)