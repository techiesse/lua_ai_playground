require "Graph"
require "util"
require "luno"
luno.functional.exposeAll()


function findPath(g, from, to, path, lookup)
    lookup = lookup or {}
    lookup[from] = true
    path = path or {}
    local ok = false
    for neighbor in pairs(g[from]) do
        if lookup[neighbor] == nil then
            if neighbor == to then
                table.insert(path, from)
                table.insert(path, to)
                ok = true
                break
            else
                local p
                p, ok = findPath(g, neighbor, to, path, lookup)
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

function printPath(path)
    print(table.concat(map(tostring, p), " -> "))
end


g = Graph()
addNode(g, "A")
addNode(g, "A", "B", "C")
addNode(g, "B", "D")
addNode(g, "C", "D")
addNode(g, "D", "E")
addNode(g, "D", "F")
addNode(g, "E", "F")

p = findPath(g, "A", "F")
--map(print, p)
printPath(p)
