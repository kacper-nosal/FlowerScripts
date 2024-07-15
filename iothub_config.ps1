param (
    [string]$iothubName,
    [string]$resourceGroupName
)

az extension add --name azure-iot

try{
    az iot hub create --resource-group $resourceGroupName --name $iothubName --sku B1
    Write-Host "IoT Hub created."
} catch{
    
}

$devices = @("TemperatureSensor", "HumiditySensor", "VelocitySensor", "FuelLevelSensor", "SensorSystem")

foreach($device in $devices){
    
    try{       
        az iot hub device-identity create --device-id $device --hub-name $iothubName 
        Write-Host "Device $device created."
    } catch{
    
    }
    
}


