Clear-Host
Set-Location $PSScriptRoot
#Install-Module ProductivityTools.NewTemporaryDirectory

Import-Module ProductivityTools.PublishReadmeToWordpress.psm1 -Force 


Clear-Host

[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\"
#[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\Test"
[string]$DestinationTempPath="D:\Trash\Readmes\"
#[string]$DestinationImageAddress="http://cdn.productivitytools.tech/pwujczykcontainer/"
[string]$CdnImageAddress="http://cdn.productivitytools.top/images/"

#Publish-ReadmesToBlog $ReadmeMasterDirectory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose
#Import-Module ProductivityTools.ConvertDocuments
#$Directory="d:\GitHub\ProductivityTools.Articles\2022.04.27 - Deploy Python App to CloudRun\"
$Directory="D:\GitHub\ProductivityTools.Example.GCP.SecretManager\"
#$Directory="d:\GitHub\ProductivityTools.SQLServerColumnDescription\"

#Publish-ReadmeToBlog -Directory $Directory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose
Publish-ReadmeToBlog -Directory $Directory -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose
