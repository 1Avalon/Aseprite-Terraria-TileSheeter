local dlg = Dialog{ title = "Terraria Tile Sheeter" }


dlg:number  {
    id =  "x",
    label = "Tile Width: ",
    text = "2",
    decimals = 0
}

dlg:number  {
    id =  "y",
    label = "Tile Height: ",
    text = "2",
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




    local image = cel.image:clone()

    for y = 0, sprite.height do

        local multiplier = 1

        local rest = 0

        for x = 0, sprite.width + xData do

            print(x - rest)
            local pixel = currentImage:getPixel(x - rest, y)
            image:drawPixel(x, y, pixel)

            if x == 8 * multiplier + rest then
                image:drawPixel(8 * multiplier + rest, y, 0)
                multiplier = multiplier + 1
                rest = rest + 1
            end
        end
    end

    cel.image = image
    app.refresh()

end