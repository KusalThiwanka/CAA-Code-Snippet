New-AzResourceGroup -Name assignment1 -Location 'East US'

# Create Storage Account name 'kusalassignment1'
New-AzStorageAccount -ResourceGroupName assignment1 -Name kusalassignment1 -SkuName Standard_LRS -Location 'East US' -Kind StorageV2 -AccessTier Hot

Write-Output "Task 1.1"
# Retrieve and set storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName assignment1 -Name kusalassignment1)[0].Value
# Set storage account name
$storageAccountName = "kusalassignment1"
# Create Container name 'cont1' inside 'kusalassignment1' Storage Account
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
New-AzStorageContainer -Name cont1 -Context $ctx

Write-Output "Task 1.2"
# Create some sample text files
New-Item -Path "sample1.txt" -ItemType "file" -Value "Sample File 1"
New-Item -Path "sample2.txt" -ItemType "file" -Value "Sample File 2"

# Upload files to the 'cont1' container
Set-AzStorageBlobContent -File "sample1.txt" -Container cont1 -Blob "sample1.txt" -Context $ctx
Set-AzStorageBlobContent -File "sample2.txt" -Container cont1 -Blob "sample2.txt" -Context $ctx

Write-Output "Task 1.3"
# Create 'cont2' container
New-AzStorageContainer -Name cont2 -Context $ctx

# Copy files from 'cont1' to 'cont2'
$blobs = Get-AzStorageBlob -Container cont1 -Context $ctx
foreach ($blob in $blobs) {
    Start-AzStorageBlobCopy -Context $ctx -SrcContainer cont1 -SrcBlob $blob.Name -DestContainer cont2 -DestBlob $blob.Name
}

Write-Output "Task 1.4"
# List the Blobs inside the cont2
Get-AzStorageBlob -Container cont2 -Context $ctx