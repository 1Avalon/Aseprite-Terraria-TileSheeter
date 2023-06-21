local dlg = Dialog{ title = "Terraria Tile Sheeter" }


dlg:number  {
    id =  "x",
    label = "Tile Widht: ",
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

    local yData = tonumber(data.y)



    --app.command.CanvasSize { ui = false, right = xData, bottom = yData } -- resizing canvas

    local sprite = app.activeSprite
    local currentImage = app.activeImage

    local newSprite = Sprite(sprite.width + xData, sprite.height + yData)
    local cel = newSprite:newCel(app.activeLayer, app.activeFrame)



    local image = cel.image:clone()
    for y = 0, sprite.height do

        local xOffset = 0

        local sliced = 0
        for x = 0, sprite.width do
            --print(y .." " .. x)

            if x % 8 == 0 and x > 0 and sliced < xData then  --TODO fix this mess 
                xOffset = xOffset + 1
            end
            local pixel = currentImage:getPixel(x - xOffset, y)
            if sliced < xData and x % 8 == 0 and x > 0 then
                pixel = 0
                sliced = sliced + 1
            end
            image:drawPixel(x, y, pixel)
            print("Drawing " .. pixel .. "at " .. x .. " " .. y)
            print("Pixel taken from " .. x - xOffset )
        end
    end

    cel.image = image
    app.refresh()

end