id = 103 --item id
dropworld = "KODOKPLAT"
platworld = "THENIBBAPLAT"
doorid = "MENGGOKIL"
dropid = "KODOKCONTOL"

function take()
    for _, obj in pairs(getObjects()) do
        if obj.id == id then
            local x = math.floor(obj.x/32)
            local y = math.floor(obj.y/32)
            findPath(x, y)
            sleep(150)
            collect(3)
            sleep(200)
            if findItem(id) >= 50 then
                break
            end
        end
    end
end

function movedrop()
    sleep(200)
    sendPacket(3,"action|join_request\nname|" .. dropworld .. "|" .. dropid)
    sleep(2000)
    vend()
end

function moveplat()
    sendPacket(3,"action|join_request\nname|" .. platworld .. "|" .. doorid)
    sleep(2000)
end

function vend()
    for _, t in ipairs(getTiles()) do
        if findItem(id) >= 20 then
            if t.fg == 2978 then
                findPath(t.x, t.y)
                sleep(500)
                wrench(0,0)
                sendPacket(2, "action|dialog_return\ndialog_name|vending\ntilex|" .. t.x .. "|\ntiley|" .. t.y .. "|\nbuttonClicked|addstock")
                sleep(250)
                if findItem(id) == 0 then
                    break
                end
            end
        end
    end
end

function jalan()
    if findItem(id) == 0 then
        moveplat()
    end
    take()
    movedrop()
end

while true do
    jalan()
end