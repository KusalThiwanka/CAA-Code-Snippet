# Retrieve and set storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName assignment1 -Name kusalassignment1)[0].Value
# Set storage account name
$storageAccountName = "kusalassignment1"
# Create Container name 'cont1' inside 'kusalassignment1' Storage Account
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

Write-Output ""
Write-Output ""
Write-Output "Task 2.1"
# Change the access tier of one of your blob files to 'cool'
# Set-AzStorageBlobTier -Container cont1 -Blob "sample1.txt" -Tier Cool -Context $ctx
$blob = Get-AzStorageBlob -Container cont1 -Context $ctx -Blob "sample1.txt"
$blob.ICloudBlob.SetStandardBlobTier('cool')
Write-Output "Task 2.1 - Done"

Write-Output ""
Write-Output ""
Write-Output "Task 2.2"
# Download a blob from Azure Storage to your local computer
Get-AzStorageBlobContent -Container cont1 -Blob "sample1.txt" -Destination "downloaded_sample1.txt" -Context $ctx

Write-Output ""
Write-Output ""
Write-Output "Task 2.3"
# Remove a blob file
Remove-AzStorageBlob -Container cont1 -Blob "sample1.txt" -Context $ctx
Write-Output "Task 2.3 - Done"