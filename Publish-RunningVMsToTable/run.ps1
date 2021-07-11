# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$CurrentUTCtime = Get-Date -Format FileDateTimeUniversal

$Result = Get-RunningAzureVM

foreach ($ResultEntry in $Result) {
    Write-Host "VM found: $($ResultEntry.Name)"
    Push-OutputBinding -Name TableBinding -Value @{
        PartitionKey      = $CurrentUTCtime
        rowkey            = ($ResultEntry.Name + $currentUTCtime)
        Name              = $ResultEntry.Name
        ResourceGroupName = $ResultEntry.ResourceGroupName
        SubscriptionId    = $ResultEntry.Id.Split('/')[2]
        PowerState        = $ResultEntry.PowerState
    }
}