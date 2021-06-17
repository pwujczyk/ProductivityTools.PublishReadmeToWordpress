Clear-Host
Set-Location $PSScriptRoot
Import-Module .\ProductivityTools.PublishReadmeToWordpress.psm1 -Force 


Clear-Host

[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\"
#[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\Test"
[string]$DestinationTempPath="D:\Trash\Readmes\"
#[string]$DestinationImageAddress="http://cdn.productivitytools.tech/pwujczykcontainer/"
[string]$CdnImageAddress="http://cdn.productivitytools.tech/images/"

#Publish-ReadmesToBlog $ReadmeMasterDirectory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose

$Directory="d:\GitHub-3.PublishedToLinkedIn\ProductivityTools.InstallService\"
Publish-ReadmeToBlog -Directory $Directory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose
