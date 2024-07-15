param (
    [string]$resourceGroupName,
    [string]$serverName,
    [string]$databaseName,
    [string]$adminUserName,
    [String]$adminPassword,
    [string]$serverAddress
)

$tables = @("BRTDTable.sql", "FDTable.sql", "NRTDTable.sql")

# Install-Module -Name SqlServer -AllowClobber -Force

try {
    az sql server create --name $serverName --resource-group $resourceGroupName --admin-user $adminUserName --admin-password $adminPassword
}
catch {
    
}

try {
    az sql db create --resource-group $resourceGroupName --server $serverName --name $databaseName --service-objective S0
}
catch {
   
}

$my_ip= (Invoke-WebRequest -Uri "http://ifconfig.me/ip").Content.Trim()

az sql server firewall-rule create --resource-group $resourceGroupName --server $serverName --name AllowMyIP --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255





foreach($sqlFilePath in $tables){

    $sqlScript = Get-Content -Path $sqlFilePath -Raw

    try{       
        Invoke-Sqlcmd -ServerInstance $serverAddress -Username $adminUserName -Password $adminPassword -Database $databaseName -query $sqlScript
        Write-Host "Device $table created."
    } catch{
    
    }
    
}





