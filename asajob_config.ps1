param (
    [string]$resourceGroupName,
    [string]$ASAJobName,
    [string]$ASATransformationName
)

az extension add --name stream-analytics



try{
    az stream-analytics job create `
        --resource-group $resourceGroupName `
        --name $ASAJobName `
        --output-error-policy Stop
} catch{
 
}

try{
    az stream-analytics transformation create `
        --resource-group $resourceGroupName `
        --job-name $ASAJobName `
        --transformation-name $ASATransformationName `
        --streaming-units 1 `
        --saql "@query.sql"
} catch{

}