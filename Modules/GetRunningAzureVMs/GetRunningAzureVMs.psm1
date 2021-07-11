function Get-RunningAzureVM {
    <#
    .SYNOPSIS
    Gets all running Azure VMs.
    .DESCRIPTION
    Gets all running Azure VMs in all subscriptions.
    if the -SubscriptionId parameter is specified, only VMs in that subscription are returned.
    .PARAMETER SubscriptionId
    The subscription ID. if not specified, all subscriptions are searched.
    .EXAMPLE
    Get-RunningAzureVM -SubscriptionId "00000000-0000-0000-0000-000000000000"
    .NOTES
    General notes
    #>
    param(
        [parameter()]
        [string]$SubscriptionId
    )
    #requires -Module Az.Accounts, Az.Compute
    $AllVMs = @()
    if ($Subscription) {
        $AllSubscriptions = Get-AzSubscription -SubscriptionId $SubscriptionId
    }
    else {
        $AllSubscriptions = Get-AzSubscription
    }
    foreach ($Subscription in $AllSubscriptions) {
        $Null = Set-AzContext $Subscription.Id
        Write-Host "Collecting VMs from $($Subscription.Name)"
        $AllVMs += Get-AzVM -Status | Where-Object { $_.PowerState -eq "VM running" }
    }
    $AllVMs
}