using namespace System.Net

# Input bindings are passed in via param block.
param($Request)

$Result = Get-RunningAzureVM  | Select-Object Name, ResourceGroupName, @{label = "SubscriptionId"; expression = { $_.Id.Split('/')[2] } }, PowerState

Push-OutputBinding -Name Response -Value (@{
        StatusCode = [HttpStatusCode]::OK
        Body       = $Result
    })

