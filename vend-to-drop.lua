id = 103 --item id
dropworld = "KODOKPLAT"
platworld = "THENIBBAPLAT"
doorid = "MENGGOKIL"
dropid = "KODOKCONTOL"

function take()
    for _, t in ipairs(getTiles()) do
        if findItem(id) == 0 then
            if t.fg == 2978 then
                findPath(t.x, t.y)
                sleep(300)
                wrench(0,0)
                sendPacket(2,"action|dialog_return\ndialog_name|vending\ntilex|".. t.x .."|\ntiley|".. t.y .."|\nbuttonClicked|pullstock")
                sleep(350)
                if findItem(id) > 20 then
                    break
                end
            end
        end
    end
end

function movedrop()
    sleep(200)
    sendPacket(3,"action|join_request\nname|" .. dropworld .. "|" .. dropid)
    sleep(2000)
    drop()
end

function moveplat()
    sendPacket(3,"action|join_request\nname|" .. platworld .. "|" .. doorid)
    sleep(2000)
end

function drop()
    for _, t in ipairs(getTiles()) do
        if findItem(id) >= 20 then
            if t.fg == 2978 then
                findPath(t.x-1, t.y)
                sleep(500)
                drop(id)
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