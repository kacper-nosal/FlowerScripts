$resourceGroupName = "FlowerT3"
$location = "northeurope"

#IoT Hub
$iothubName = "FlowerHubT3"

#Stream Analitics
$asaJobName = "DataStream"
$ASATransformationName = "DataStream"

#SQL
$SQLServerName = "flowerpowert3"
$SQLDatabaseName = "FlowerBase"
$SQLUsername = "TheFlorist"
$SQLAdminPassword = "w#gwPDT}ZvpwMnu~T+kR"
$serverAddress = $($SQLserverName + ".database.windows.net")


try{
    az group create --name $resourceGroupName --location $location
    Write-Host "Resource Group Created."
} catch{

}

# ./iothub_config.ps1 `
#     -iothubName $iothubName `
#     -resourceGroupName $resourceGroupName

# Write-Host "IoT Hub configured."

# ./asajob_config.ps1 `
#     -resourceGroupName $resourceGroupName `
#     -ASAJobName $asaJobName `
#     -ASATransformationName $ASATransformationName

# ./SQL_config.ps1 `
#     -resourceGroupName $resourceGroupName `
#     -serverName $SQLServerName `
#     -databaseName $SQLDatabaseName `
#     -adminUserName $SQLAdminLogin `
#     -adminPassword $SQLAdminPassword `
#     -serverAddress $serverAddress
#     -tables $tables

# Write-Host "SQL configured."

./asajob_connection_config.ps1 `
    -iotHubName $iothubName `
    -resourceGroupName $resourceGroupName `
    -asaJobName $asaJobName `
    -databaseName $SQLDatabaseName `
    -SQLPassword $SQLAdminPassword `
    -SQLUsername $SQLUsername `
    -SQLTables $tables `
    -serverAddress $serverAddress

Write-Host "Stream Analitics Job configured."