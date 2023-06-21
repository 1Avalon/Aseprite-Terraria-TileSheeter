local dlg = Dialog{ title = "Terraria Tile Sheeter" }

local sprite = app.activeSprite

local x = sprite.width / 8
local y = sprite.height / 8

if x % 1 ~= 0 or y % 1 ~= 0 then 
    app.alert("Cant convert the sprite into a Tilesheet. Please check your Sprite size.")
    return
end

dlg:number  {
    id =  "x",
    label = "Tile Width: ",
    text = tostring(x),
    decimals = 0
}

dlg:number  {
    id =  "y",
    label = "Tile Height: ",
    text = tostring(y),
    decimals = 0
}

dlg:button  {
    id = "ok",
    text = "OK",
    focus = true,
    onClick = function ()

        local xData = tonumber(dlg.data.x)

        local yData = tonumber(dlg.data.y)

        app.alert("asdsad")

        app.command.CanvasSize = { ui = false, right = xData, bottom = yData } 
    end
}

dlg:show()
local data = dlg.data
if data.ok then
    local xData = tonumber(data.x) - 1

    local yData = tonumber(data.y) - 1



    --app.command.CanvasSize { ui = false, right = xData, bottom = yData } -- resizing canvas

    local sprite = app.activeSprite
    local currentImage = app.activeImage

    local newSprite = Sprite(sprite.width + xData, sprite.height + yData)
    local cel = newSprite:newCel(app.activeLayer, app.activeFrame)


    local multiplierY = 1

    local restY = 0

    local image = cel.image:clone()

    for y = 0, sprite.height + yData do

        local multiplierX = 1

        local restX = 0

        local drawVertical = false

        if y == 8 * multiplierY + restY then
            image:drawPixel(x, y, 0)
            multiplierY = multiplierY + 1
            restY = restY + 1
            drawVertical = true
        end

        for x = 0, sprite.width + xData do


            local pixel = currentImage:getPixel(x - restX, y - restY)
            image:drawPixel(x, y, pixel)

            if drawVertical then
                image:drawPixel(x, y, 0)
            end

            if x == 8 * multiplierX + restX then
                image:drawPixel(8 * multiplierX + restX, y, 0)
                multiplierX = multiplierX + 1
                restX = restX + 1
            end
        end
    end

    cel.image = image
    app.refresh()

end