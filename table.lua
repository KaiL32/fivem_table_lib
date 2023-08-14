function table.GetKeys(tab)
    local keys = {}
    local id = 1

    for k, v in pairs(tab) do
        keys[id] = k
        id = id + 1
    end

    return keys
end

function table.Count(t)
    local i = 0

    for k in pairs(t) do
        i = i + 1
    end

    return i
end

function table.Random(t)
    local rk = math.random(1, table.Count(t))
    local i = 1

    for k, v in pairs(t) do
        if i == rk then return v, k end
        i = i + 1
    end
end

function table.copy(t)
    local u = {}

    for k, v in pairs(t) do
        u[k] = v
    end

    return setmetatable(u, getmetatable(t))
end

function istable(t)
    return type(t) == 'table'
end

function PrintTable(t, indent, done)
    local Msg = print
    done = done or {}
    indent = indent or 0
    local keys = table.GetKeys(t)

    table.sort(keys, function(a, b)
        if isnumber(a) and isnumber(b) then return a < b end

        return tostring(a) < tostring(b)
    end)

    done[t] = true

    for i = 1, #keys do
        local key = keys[i]
        local value = t[key]
        Msg(string.rep("\t", indent))

        if istable(value) and not done[value] then
            done[value] = true
            Msg(key, ":\n")
            PrintTable(value, indent + 2, done)
            done[value] = nil
        else
            Msg(key, "\t=\t", value, "\n")
        end
    end
end