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

    app.alert(xData .. yData)

    app.command.CanvasSize { ui = false, right = xData, bottom = yData } -- resizing canvas
end