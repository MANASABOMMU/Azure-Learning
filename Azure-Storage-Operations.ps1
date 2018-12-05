<#
Script to create Resource group, Storage Account, Container, uplaod blob file and download it
#>

$publicsettingfile = "C:\Users\aisadmin\Downloads\manasa.publishsettings"
$storageaccountname = "manasatestacct"
$resourcegroupname = "mynewresourcegrp"
$serviceLocation = "westus"
$subscription = "Free Trial"
$containerName = "mynewcontainer"
$file = "C:\Users\aisadmin\Downloads\newjoinee1.png"
$blob = "file"
$destinationfolder = "D:\"


Function ImportPublishSettings()
{
    Import-AzurePublishSettingsFile $publicsettingfile -ErrorAction Stop;
}

Function CreateResourceGroup()
{
    Write-Host "********* Create New Resource group *************" 

    #create resource group
    New-AzureRmResourceGroup -Name $resourcegroupname -Location $serviceLocation -ErrorAction Stop
}

Function CreateStorageAccount()
{
    Write-Host "********* Create New Storage Account *********"
    #create storage account
    $storageaccount = New-AzureRmStorageAccount -ResourceGroupName $resourcegroupname -Name $storageaccountname -Location $serviceLocation -SkuName Standard_LRS -Kind StorageV2 -ErrorAction stop

    #Get storage account context
    $ctx =  $storageaccount.Context

    $ctx

}

Function CreateContainer($ctx)
{
    Write-Host "********* Create New Container *********" 

    #Create Storage container
    New-AzureStorageContainer -Name $containerName -Context $ctx -ErrorAction Stop
}
Function UplaodBlob($ctx)
{
    #upload a file
    Write-Host "********* Uplaod File *********"
    Set-AzureStorageBlobContent -File $file -Container $containerName -Blob $blob -Context $ctx -ErrorAction Stop
}

Function DownloadBlob($ctx)
{
    # download blob
    Write-Host "********* Download File *********"
    Get-AzureStorageBlobContent -Blob $blob -Container $containerName -Destination $destinationfolder -Context $ctx -ErrorAction Stop
}



Function Delete_Resources()
{

    # Delete Resource group which inturn delete all the resorueces inside the resource group
    Remove-AzureRmResourceGroup -Name $resourcegroupname -ErrorAction Stop

}

# Main
try {

    #Import publish setting file
    ImportPublishSettings

    #Add new resource group
    CreateResourceGroup

    #Add new Storage account
    $ctx = CreateStorageAccount

    #Add container
    CreateContainer ($ctx)

    #Add files
    UplaodBlob($ctx)

    #Download file
    DownloadBlob($ctx)

    #Delete The resources
    Delete_Resources

}
catch [System.Exception] {
    Write-Host $_.Exception.ToString()
    exit 1
}
