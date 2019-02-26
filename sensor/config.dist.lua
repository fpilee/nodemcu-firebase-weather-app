--[[
config.lua

Global variables definitions for usage across various lua scripts
--]]

--wifi module
wifi_config = {}
wifi_config['ssid'] = "SSID"
wifi_config['pwd'] = "pw"

--dht module
dht_pin = 2  -- Pin for DHT22 sensor (GPIO4)
dht_temp_calc = 0  -- Calculated temperature
dht_humi_calc = 0  -- Calculated humidity

--sensor reading interval
dsleep_time = 60000 --sleep time in microseconds (us) 

-- Firebase Cloud Function URL
cloud_function_url = "http://us-central1-app-id.cloudfunctions.net/saveClimate"

-- Status Message
print("Global variables loaded")
