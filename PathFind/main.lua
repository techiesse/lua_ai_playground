require"loveColor"
require"util"
require"luno"
luno.functional.exposeAll()
luno.useAliases()

DEFAULT_RADIUS = 10

--##############################################################################
function rawDrawPoint(x, y, radius, isSelected)
    isSelected = isSelected or false
    love.graphics.circle("fill", x, y, radius)
    if isSelected then
        love.graphics.circle("line", x, y, radius + 2)
    end
end


function drawPoint(p)
    local isSelected = contains(selectedObjects, p)
    return rawDrawPoint(p[1], p[2], p.r, isSelected)
end


function euclidianDistance(p1, p2)
    return math.sqrt((p1[1]-p2[1])^2 + (p1[2]-p2[2])^2 )
end


function getPointAt(x, y)
    local point = nil
    for i, p in ipairs(points) do
        if euclidianDistance(p, {x, y}) < p.r then
            point = p
            break
        end
    end

    return point
end


function selectPointAt(x, y)
    local selection = getPointAt(x, y)
    if selection then
        selection.mousePos = {x, y}
    end
    select(selection)
    return selection
end


function select(obj)
    table.insert(selectedObjects, obj)
end


function clearSelections()
    selectedObjects = {}
end

--##############################################################################
-- Callbacks

function love.load()
    points = {}
    selectedObjects = {}
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(COLOR.WHITE)
    nodeNames = lstring.split("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z", " ")
end


function love.draw()
    love.graphics.setColor(COLOR.BLACK)

    if #points > 0 then
        for i, point in ipairs(points) do
            drawPoint(point)
        end
    end

    if love.mouse.isDown(2) and lastSelection ~= nil then
        local mx = love.mouse.getX()
        local my = love.mouse.getY()
        love.graphics.line(lastSelection[1], lastSelection[2], mx, my)
    end

end


function love.update(dt)
    if love.mouse.isDown(1) and lastSelection ~= nil then
        dx = lastSelection[1] - lastSelection.mousePos[1]
        dy = lastSelection[2] - lastSelection.mousePos[2]
        lastSelection[1] = love.mouse.getX() + dx
        lastSelection[2] = love.mouse.getY() + dy
        lastSelection.mousePos[1] = love.mouse.getX()
        lastSelection.mousePos[2] = love.mouse.getY()
    end

end


function love.keypressed(key, isRepeat)

end


function love.mousepressed(x, y, button)
    if button == 1 then -- primary
        if love.keyboard.isDown('lctrl', 'rctrl') then
            table.insert(points,  Point(x, y, DEFAULT_RADIUS))
        elseif love.keyboard.isDown('lshift', 'rshift') then
            lastSelection = selectPointAt(x, y)
            if lastSelection == nil then
                clearSelections()
            end
        else
            lastSelection = selectPointAt(x, y)
            clearSelections()
            select(lastSelection)
        end


    elseif button == 2 then
    end

end


function love.mousereleased(x, y, button)
    if button == 1 then -- primary
        if lastSelection ~= nil then
            local point = getPointAt(x, y)
            if point ~= nil then
                love.graphics.line(lastSelection[1], lastSelection[2], point[1], point[2])
            end
        end
    elseif button == 2 then
    end

end
