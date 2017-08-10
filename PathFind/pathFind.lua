require "Node"
require "util"
require "luno"
luno.functional.exposeAll()


function showPath(path)
    local names = map(function (x) return x.name end, path)
    return "Path: " .. table.concat(names, ", ")
end


function findPath(from, to, path, lookup)
    lookup = lookup or {}
    lookup[from] = true
    path = path or {}
    local ok = false
    for i, neighbor in ipairs(from.neighbors) do
        if lookup[neighbor] == nil then
            if neighbor == to then
                table.insert(path, from)
                table.insert(path, to)
                ok = true
                break
            else
                local p
                p, ok = findPath(neighbor, to, path, lookup)
                if ok then
                    table.insert(p, 1, from)
                    ok = true
                    break
                end
            end
        end
    end

    -- Acho que a sessao abaixo é opcional (mas deve melhorar a performance)
    if not ok then
        lookup[from] = nil
    end
    
    return path, ok
end


function pTable(tb)
    for i, v in ipairs(tb) do
        print(i, v)
    end
end



a = Node("A")
b = Node("B")
c = Node("C")
d = Node("D")
e = Node("E")
addNeighbor(a, b)
addNeighbor(a, c)
addNeighbor(b, d)
addNeighbor(c, d)
addNeighbor(d, e)
addNeighbor(c, "F")
--print(showNode(a))

p = findPath(a, e)
map(print, (map(showNode, p)))
--pTable(p)
