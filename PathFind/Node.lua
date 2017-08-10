function Node(name)
    local node = {}
    node.name = name
    node.neighbors = {}

    return node
end


function addNeighbor(node, neighbor)
    if type(neighbor) == "string" then
        neighbor = Node(neighbor)
    end

    table.insert(node.neighbors, neighbor)
    table.insert(neighbor.neighbors, node)

    return node
end


function showNode(node)
    local names = map(function(x) return x.name end, node.neighbors)
    local ret = string.format("Node %s: {%s}", node.name, table.concat(names, ", "))
    return ret
end


--[[ Testando a implementação

function showPath(path)
    local names = map(function (x) return x.name end, path)
    return "Path: " .. table.concat(names, ", ")
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
addNeighbor(g, c, "F")
--print(showNode(a))
--map(print, (map(showNode, p)))
--pTable(p)
]]
