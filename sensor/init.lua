--[[
init.lua
Script connects to internet through NodeMCU wifi module.
Once connection is established dht module and temperature and humidity is retrieved.
--]]

-- Load global user-defined variables
dofile("config.lua")
dofile("dht2.lua")
-- Connect to the wifi network using wifi module

wifi.setmode(wifi.STATION)
wifi.sta.config(wifi_config)


sntp.sync(nil, nil, function(err, info) print(err) end, 1)
print( rtctime.get() )

mytimer = tmr.create()
-- runs function every 30 seconds, however device enter in sleep mode for 10 minutes after saving readings
mytimer:register(10000, tmr.ALARM_AUTO, function()
    print( rtctime.get() )
    local body = getReadings()
    if(body ~= false) then
        http.post(cloud_function_url,
            'Content-Type: application/json\r\n',
            body,
            function(code, data)
                if (code < 0) then
                    print("HTTP request failed")
                else
                    print(code, data)
                    rtctime.dsleep(60000000*10, 1)  -- 10 minutes
                end
            end)
    else
        print(body)
    end

end)
mytimer:interval(30000)
mytimer:start()





