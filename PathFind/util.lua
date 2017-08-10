require"luno"
luno.functional.exposeAll()


function Point(x, y, r, name)
    return {x, y, r = r, name = name}
end


function contains(list, val)
    return any(function (v) return v == val end, list)
end


function pTable(tb)
    for i, v in ipairs(tb) do
        print(i, v)
    end
end
