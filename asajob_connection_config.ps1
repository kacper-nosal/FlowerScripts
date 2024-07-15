param (
    [string]$iotHubName,
    [string]$resourceGroupName,
    [string]$asaJobName,
    [string]$databaseName,
    [string]$SQLPassword,
    [string]$SQLUsername,
    [string]$serverAddress
    
)

$primaryKey = az iot hub policy show --name iothubowner --hub-name $iothubName  --query primaryKey

az stream-analytics input create --resource-group $resourceGroupName --job-name $asaJobName --input-name "FlowerPower" --properties @"
{
    "type": "Stream",

    "datasource" : {
        "type": "Microsoft.Devices/IotHubs",

        "properties": {
            "iotHubNamespace": "$iothubName",
            "sharedAccessPolicyName": "iothubowner",
            "sharedAccessPolicyKey": $primaryKey,
            "endpoint": "messages/events"
        }

    },
    "serialization": {
                "type":"Json",
                "encoding":"UTF8"
            }    
}
"@



az stream-analytics output create `
    --job-name $asaJobName `
    --output-name   "NumericRealTimeData"`
    --resource-group $resourceGroupName `
    --datasource @"
{
    "type":"Microsoft.Sql/Server/Database",
    "properties":{
        "database":"$databaseName",
        "password":"$SQLPassword",
        "server": "$serverAddress",
        "table": "NRTDTable",
        "user" : "$SQLUsername"             
    }
}
"@ 

az stream-analytics output create `
    --job-name $asaJobName `
    --output-name   "BooleanRealTimeData"`
    --resource-group $resourceGroupName `
    --datasource @"
{
    "type":"Microsoft.Sql/Server/Database",
    "properties":{
        "database":"$databaseName",
        "password":"$SQLPassword",
        "server": "$serverAddress",
        "table": "BRTDTable",
        "user" : "$SQLUsername"             
    }
}
"@ 
    


