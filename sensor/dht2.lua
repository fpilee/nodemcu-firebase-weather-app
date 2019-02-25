
function getReadings()
  local data = {}
  local status, temp, humi, temp_dec, humi_dec = dht.read(dht_pin)
  data["temp"] = temp
  data["humidity"] = humi
  data["updated"] = rtctime.get()
  if status == dht.OK then
    return sjson.encode(data)  
  elseif status == dht.ERROR_CHECKSUM then
    return false
  elseif status == dht.ERROR_TIMEOUT then
    return false
  end
end


