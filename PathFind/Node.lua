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
