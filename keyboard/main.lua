local colors_hex = { --> #ревизия 18-05-2025
    "#140c1c",
    "#442434",
    "#30346d",
    "#4e4a4e",
    "#854c30",
    "#346524",
    "#d04648",
    "#757161",
    "#597dce",
    "#d27d2c",
    "#8595a1",
    "#6daa2c",
    "#d2aa99",
    "#6dc2ca",
    "#dad45e",
    "#deeed6"
}

local colors_name={ --> #ревизия 18-05-2025
    "black",
    "brown1",
    "blue1",
    "gray1",
    "brown2",
    "green1",
    "red",
    "gray2",
    "blue2",
    "orange",
    "white",
    "green2",
    "pink",
    "blue3",
    "yellow",
    "green3"
}

local colors_rgb={} --> #ревизия 18-05-2025

local l={} --> #ревизия 18-05-2025
l.split=string.gmatch --> for path in l.split(package.path, "[^;]+") do io.write(path) end
l.match=string.match
l.coolf=string.format
l.int=tonumber
l.str=tostring
l.sub=string.sub
l.w2w=string.gsub  --> str,count=l.w2w(package.path,";","\n") io.write(str)

local bd = {} --> #ревизия 16-05-2025
-- bd.date=os.date()

-- for word in string.gmatch(bd.date, "%S+") do
--     table.insert(bd, word)
-- end

bd.d=display
bd.w, bd.h= bd.d.contentWidth, bd.d.contentHeight
bd.l="RUSSIAN"
bd.pathp="assets/images/"
bd.zoom=math.pi+math.exp(1)

-- local t={} --> #ревизия 16-05-2025
-- t.d1=bd[1]
-- t.m=bd[2]
-- t.d2=bd[3]
-- t.t=bd[4]
-- t.y=bd[5]



local tf={} --> #ревизия 18-05-2025
tf.f="assets/font/mf.ttf"
tf.s=16*bd.zoom

local tt={} --> #ревизия 18-05-2025
tt.o={text="",x=tf.s,y=tf.s,width = tf.s * 16 * bd.zoom,font=tf.f,fontSize=tf.s}
tt.s=""
tt.t=bd.d.newText( tt.o )
tt.c=""

local pt={} --> #ревизия 18-05-2025
pt.x=0
pt.y=0
pt.sx=32
pt.sy=32

pt.h2n=function(hex) hex = hex:gsub("#", "") local r,g,b = l.int(hex:sub(1, 2), 16),l.int(hex:sub(3, 4), 16),l.int(hex:sub(5, 6), 16) return {r, g, b} end --> pt.h2n("#140c1c")

for i,v in pairs(colors_hex) do
    colors_rgb[colors_name[i]] = pt.h2n(v)
end

pt.n1=function(t) return t[1], t[2], t[3] end
pt.n2=function(t) return {t[1]/256, t[2]/256, t[3]/256} end
pt.color=function(t) return pt.n1(pt.n2(t)) end --> tt.t:setFillColor(pt.color(colors_rgb.red))

pt.t=function(text) tt.c=colors_rgb.red  tt.t:setFillColor(pt.color(tt.c)) tt.t.anchorY = 0 tt.t.anchorX = 0 tt.s=l.coolf("%s \n%s",text,tt.s) tt.t.text = tt.s end --> pt.t(1)

pt.p=function() for i,v in ipairs(colors_name) do local r = bd.d.newRect(pt.x, pt.y, pt.sx,pt.sy) r:setFillColor(pt.color(colors_rgb[v])) r.anchorX=0 r.anchorY=0 pt.x=pt.x+pt.sx end end --> pt.p()

-- pt.t("Шу‌тка, кстати, это фраза или небольшой текст юмористического содержания. Она может быть в различных формах, таких, как вопрос/ответ или короткая байка. Для достижения своей юмористической цели шутка может использовать иронию, сарказм, игру слов и другие методы. Шутка, как правило, имеет концовку (кульминацию), которая заканчивает повествование и делает его смешным.")

bd.d.setDefault( "fillColor", pt.color(colors_rgb.red))
bd.d.setDefault( "background", pt.color(colors_rgb.black))

local k={}

    k.layouts = {
        {
            {"1","2","3","4","5","6","7","8","9","0"},
            {"q","w","e","r","t","y","u","i","o","p"},
            {"a","s","d","f","g","h","j","k","l"},
            {"SHIFT","z","x","c","v","b","n","m","BACK"},
            {",","GLOBE","SPACE",".","ENTER"}
        },
        {
            {"1","2","3","4","5","6","7","8","9","0"},
            {"й","ц","у","к","е","н","г","ш","щ","з"},
            {"ф","ы","в","а","п","р","о","л","д"},
            {"SHIFT","я","ч","с","м","и","т","ь","BACK"},
            {",","GLOBE","SPACE",".","ENTER"}
        },
            {
            {"1","2","3","4","5","6","7","8","9","0"},
            {"Q","W","E","R","T","Y","U","I","O","P"},
            {"A","S","D","F","G","H","J","K","L"},
            {"SHIFT","Z","X","C","V","B","N","M","BACK"},
            {",","GLOBE","SPACE",".","ENTER"}
        },
        {
            {"1","2","3","4","5","6","7","8","9","0"},
            {"Й","Ц","У","К","Е","Н","Г","Ш","Щ","З"},
            {"Ф","Ы","В","А","П","Р","О","Л","Д"},
            {"SHIFT","Я","Ч","С","М","И","Т","Ь","BACK"},
            {",","GLOBE","SPACE",".","ENTER"}
        }
    }

k.currentLayoutIndex = 1
k.r = k.layouts[k.currentLayoutIndex]

k.w = 8*bd.zoom
k.h = 8*bd.zoom
k.sx = 2*bd.zoom
k.sy = 2*bd.zoom
k.s = bd.h - (k.h + k.sy) * 4 - 50

k.sb = false
k.t = ""
k.textTable = {}

k.g = bd.d.newGroup()

k.b = bd.d.newText{
    text = "",
    x = bd.w/2,
    y = bd.w/4,
    width = bd.w - 40,
    height = 100,
    font = tf.f,
    fontSize = math.pi*bd.zoom,
    align = "left"
}
k.b:setFillColor(pt.color(colors_rgb.white))
k.b.anchorX = 0
k.b.x = 20

k.m=function()
    table.insert(k.textTable, "\n") --> HTML5 TODO:
    local function updateInputBox()
        k.t = table.concat(k.textTable)
        k.b.text = k.t
    end

    local function createKey(label, x, y, width, height)
        local keyGroup = bd.d.newGroup()

        local rect = bd.d.newRoundedRect(keyGroup, 0, 0, width, height, 8)
        if label == "SHIFT" then
            if k.sb then
                rect:setFillColor(pt.color(colors_rgb.orange))
            else
                rect:setFillColor(pt.color(colors_rgb.white))
            end
        elseif label == "BACK" or label == ","  or label == "." then
            rect:setFillColor(pt.color(colors_rgb.white))
        elseif label == "ENTER" or label == "enter" or label == "SPACE" then
            rect:setFillColor(pt.color(colors_rgb.green2))
        else
            rect:setFillColor(pt.color(colors_rgb.green3))
        end
        rect.strokeWidth = bd.zoom
        rect:setStrokeColor(0.7)

        local text = bd.d.newText{
            parent = keyGroup,
            text = label,
            x = bd.zoom/2,
            y = bd.zoom,
            font = tf.f,
            fontSize = math.pi*bd.zoom
        }
        text:setFillColor(0)
        if label == "SHIFT" then
            text.text = "⇧"
        elseif label == "BACK" then
            text.text = "⌫"
        elseif label == "SPACE" then
            text.text = " "
        elseif label == "ENTER" then
            text.text = "⏎"
        -- elseif label == "123" then
        --     text.text = "123"
        elseif label == "GLOBE" then
            text.text = "🌐"
        -- elseif label == "MIC" then
        --     text.text = "🎤"
        end

        text.text=l.coolf("\n%s",text.text) --> HTML5 TODO:

        keyGroup.x = x 
        keyGroup.y = y

        -- Touch handler for key press
        function keyGroup:touch(event)
            if event.phase == "began" then
                -- Change color and move key down on press
                rect:setFillColor(0.5, 0.5, 0.5) -- pressed color (gray)
                keyGroup.y = keyGroup.y + 4
            elseif event.phase == "ended" or event.phase == "cancelled" then
                -- Revert color and position on release
                if label == "SHIFT" then
                    if k.sb then
                        rect:setFillColor(pt.color(colors_rgb.orange))
                    else
                        rect:setFillColor(pt.color(colors_rgb.white))
                    end
                elseif label == "BACK" or label == ","  or label == "." then
                    rect:setFillColor(pt.color(colors_rgb.white))
                elseif label == "ENTER" or label == "SPACE" then
                    rect:setFillColor(pt.color(colors_rgb.green2))
                else
                    rect:setFillColor(pt.color(colors_rgb.green3))
                end
                keyGroup.y = keyGroup.y - 4

                local keyLabel = label
                print(keyLabel)
                if keyLabel == "SHIFT" then
                    k.sb = not k.sb
                    -- Switch between uppercase and lowercase layouts
                    if k.currentLayoutIndex == 1 then
                        k.currentLayoutIndex = 3
                    elseif k.currentLayoutIndex == 2 then
                        k.currentLayoutIndex = 4
                    elseif k.currentLayoutIndex == 3 then
                        k.currentLayoutIndex = 1
                    elseif k.currentLayoutIndex == 4 then
                        k.currentLayoutIndex = 2
                    end
                    k.r = k.layouts[k.currentLayoutIndex]
                    -- Remove old keys
                    for i = k.g.numChildren, 1, -1 do
                        k.g[i]:removeSelf()
                    end
                    -- Recreate keys with new layout
                    k.m()
                elseif keyLabel == "BACK" then
                    if #k.textTable > 0 then
                        table.remove(k.textTable)
                        updateInputBox()
                    end
                elseif keyLabel == "SPACE" then
                    table.insert(k.textTable, " ")
                    updateInputBox()
                elseif keyLabel == "ENTER" then
                    table.insert(k.textTable, "\n")
                    updateInputBox()
                elseif keyLabel == "123" then
                    -- Could implement switching to numeric keyboard here
                    -- For now, do nothing
                elseif keyLabel == "GLOBE" then
                    -- Switch keyboard layout only between uppercase English (1) and uppercase Russian (2)
                    if k.currentLayoutIndex == 1 or k.currentLayoutIndex == 3 then
                        k.currentLayoutIndex = 2
                    else
                        k.currentLayoutIndex = 1
                    end
                    -- Reset shift state to off and set layout to uppercase variant
                    k.sb = false
                    k.r = k.layouts[k.currentLayoutIndex]
                    -- Remove old keys
                    for i = k.g.numChildren, 1, -1 do
                        k.g[i]:removeSelf()
                    end
                    -- Recreate keys with new layout
                    k.m()
                elseif keyLabel == "MIC" then
                    -- Could implement voice input here
                    -- For now, do nothing
                else
                    local char = keyLabel
                    table.insert(k.textTable, char)
                    updateInputBox()
                end
            end
            return true
        end

        keyGroup:addEventListener("touch")

        return keyGroup
    end

    for rowIndex, row in ipairs(k.r) do
        -- Calculate total width of the row considering SPACE key width
        local totalRowWidth = 0
        for _, label in ipairs(row) do
            if label == "SPACE" then
                totalRowWidth = totalRowWidth + (k.w * 3) + (k.sx * 3)
            else
                totalRowWidth = totalRowWidth + k.w + k.sx
            end
        end
        totalRowWidth = totalRowWidth - k.sx -- remove last extra spacing

        local rowStartX = (bd.w - totalRowWidth + k.w) / 2
        local y = (rowIndex - 1) * (k.h + k.sx)

        local x = rowStartX
        for keyIndex, keyLabel in ipairs(row) do
            local width = k.w
            local a = 0
            if keyLabel == "SPACE" then
                width = (k.w * 3) + (k.sx * 2)
                x=x+ k.w + k.sx
                a=k.w + k.sx
            end
            local key = createKey(keyLabel, x, y, width, k.h)
            print(key.x,x)
            k.g:insert(key)

            x = x + width - a + k.sx
        end
    end
end
k.g.y=bd.w-5*(k.w + k.sx)
k.m()