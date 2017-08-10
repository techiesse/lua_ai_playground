require"luno"
luno.functional.exposeAll()


function Point(x, y, r)
    return {x, y, r = r}
end


function contains(list, val)
    return any(function (v) return v == val end, list)
end
