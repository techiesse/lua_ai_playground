

function Graph()
    local graph = {}
    return graph
end


function addNode(g, node, ...)
    local neighbors = {...}
    if #neighbors > 0 then
        if type(neighbors[1]) == "table" then
            neighbors = neighbors[1]
        end
    end

    g[node] = {} -- Lista de adjacencia
    for i, neighbor in ipairs(neighbors) do
        addNeighbor(g, node, neighbor)
    end

    return g
end


function addNeighbor(g, node, neighbor, attr)
    if g[node] == nil then
        return nil
    end

    attr = attr or {}
    g[node][neighbor] = attr
    g[neighbor] = g[neighbor] or {}
    g[neighbor][node] = attr

    return g
end


function addEdge(g, node, neighbor, attr)
    if g[node] == nil or g[neighbor] == nil then
        return nil
    end

    attr = attr or {}
    g[node][neighbor] = attr
    g[neighbor][node] = attr

    return g
end


function deleteNode(g, node)
    g[node] = nil
    return g
end
