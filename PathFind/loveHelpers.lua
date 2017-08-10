function rawDrawPoint(x, y, radius, isSelected)
    isSelected = isSelected or false
    love.graphics.circle("fill", x, y, radius)
    if isSelected then
        love.graphics.circle("line", x, y, radius + 2)
    end
end
