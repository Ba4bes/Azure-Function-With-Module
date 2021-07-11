$ResourceGroupName = "AzFunctionWithModule"
$Location = "West Europe"
$StorageAccountName = "runningvmstatistics"
$TableName = "allvms"
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

$Parameters = @{
    ResourceGroupName = $ResourceGroupName
    Name              = $StorageAccountName
    Type              = "Standard_LRS"
    Location          = $Location
}

$StorageAccount = New-AzStorageAccount @Parameters

New-AzStorageTable -Name $TableName -Context $StorageAccount.Context
