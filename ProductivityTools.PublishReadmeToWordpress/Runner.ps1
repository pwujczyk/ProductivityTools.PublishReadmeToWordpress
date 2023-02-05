Clear-Host
Set-Location $PSScriptRoot
#Install-Module ProductivityTools.NewTemporaryDirectory

Import-Module ProductivityTools.PublishReadmeToWordpress.psm1 -Force 

Import-Module d:\GitHub\ProductivityTools.ConvertDocuments\ProductivityTools.ConvertDocuments\ProductivityTools.ConvertDocuments.psm1 -Force
Clear-Host

[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\"
#[string]$ReadmeMasterDirectory="d:\GitHub-3.PublishedToLinkedIn\Test"
[string]$DestinationTempPath="D:\Trash\Readmes\"
#[string]$DestinationImageAddress="http://cdn.productivitytools.tech/pwujczykcontainer/"
[string]$CdnImageAddress="http://cdn.productivitytools.top/images/"

#Publish-ReadmesToBlog $ReadmeMasterDirectory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose

#Import-Module ProductivityTools.ConvertDocuments
#$Directory="d:\GitHub\ProductivityTools.Articles\2022.04.27 - Deploy Python App to CloudRun\"
#$Directory="D:\GitHub\ProductivityTools.Example.GCP.SecretManager\"
#$Directory="d:\GitHub\ProductivityTools.SQLServerColumnDescription\"

Import-Module ProductivityTools.ConvertDocuments
$Directories=@(
    "d:\GitHub\ProductivityTools.Articles\2022.04.27 - Deploy Python App to CloudRun\",
    "d:\GitHub\ProductivityTools.Example.FirebaseAuthenticationKept\",
    "d:\GitHub\ProductivityTools.Example.GCP.SecretManager\",
    "d:\GitHub\ProductivityTools.Articles\2022.09.23 - Setup Wordpress\",
    "d:\GitHub\ProductivityTools.GetServiceDescription\",
    "d:\GitHub\ProductivityTools.Example.FirebaseAuthentication\",
    "d:\GitHub\ProductivityTools.Articles\2022.04.27 - Deploy Python App to CloudRun\"
    "d:\GitHub\ProductivityTools.SQLServerColumnDescription\",
    "d:\GitHub\ProductivityTools.Articles\2022.04.19 - Deploy web app to azure\",
    "d:\GitHub\ProductivityTools.NewTemporaryDirectory\",
    "d:\GitHub\productivitytools.learning.reactwithfirebaseauthwithdb\",
    "d:\GitHub\productivitytools.learning.reactwithfirebaseauth\",
    "d:\GitHub\ProductivityTools.Transfers\",
    "d:\GitHub\ProductivityTools.CloudItems\",
    "d:\GitHub\ProductivityTools.Articles\2021.07.09 - OAuth\",
    "d:\GitHub\ProductivityTools.Examples.React.ContextMenu\",
    "d:\GitHub\ProductivityTools.GetBinaryModuleFileList\",
    "d:\GitHub\ProductivityTools.ConvertDocuments\",
    "d:\GitHub\ProductivityTools.ManageGitRepositories\",
    "d:\GitHub\ProductivityTools.CloneGitRepositories\",
    "d:\GitHub\ProductivityTools.SportsTracker.Cmdlet\",
    "d:\GitHub\ProductivityTools.SportsTracker.SDK\",
    "d:\GitHub\ProductivityTools.ConvertTcx2Gpx\",
    "d:\GitHub\ProductivityTools.Articles\2020.11.09 - My CV was rejected. Again!\",
    "d:\GitHub\ProductivityTools.GetExternalIP\",
    "d:\GitHub\EcoVadis.AzureDevOps\",
    "d:\GitHub\ProductivityTools.NetworkUtilities\",
    "d:\GitHub\ProductivityTools.Articles\2020.10.22 - Efficient development team\",
    "d:\GitHub\ProductivityTools.Articles\2020.10.08 - Slack\",
    "d:\GitHub\ProductivityTools.MasterConfiguration\"
    "d:\GitHub\ProductivityTools.UnmanagedDisplayWrapper\",
    "d:\GitHub\ProductivityTools.Articles\2020.09.09 - Estimator\"
    "d:\GitHub\ProductivityTools.GetCurrentWifiPassword\",
    "d:\GitHub\ProductivityTools.ConsoleColors\",
    "d:\GitHub\ProductivityTools.Articles\2020.06.16 - AWS Wordpress API\",
    "d:\GitHub\ProductivityTools.PSDisplayPosition\",
    "d:\GitHub\ProductivityTools.MoveDisplay\",
    "d:\GitHub\ProductivityTools.PSSetLockDisplayTimeout\",
    "d:\GitHub\ProductivityTools.Articles\2020.05.18 - Story points\",
    "d:\GitHub\ProductivityTools.DescriptionValue\",
    "d:\GitHub\ProductivityTools.SetLockScreen\",
    "d:\GitHub\ProductivityTools.Articles\2020.04.06 - The most expensive T-Shirts in the world\",
    "d:\GitHub\ProductivityTools.Articles\2020.03.15 - Grow carrots in Development team\",
    "d:\GitHub\ProductivityTools.Articles\2020.01.23 - IT War Rooms\",
    "d:\GitHub\ProductivityTools.Articles\2020.01.08 - Does the scrum team really exists\",
    "d:\GitHub\ProductivityTools.Articles\2019.12.30 - Setup the release schedule\",
    "d:\GitHub\ProductivityTools.CreateSQLServerDatabase\",
    "d:\GitHub\ProductivityTools.PSFlickr\"
    "d:\GitHub\ProductivityTools.PSDbUp\",
    "d:\GitHub\ProductivityTools.FindPictures\",
    "d:\GitHub\ProductivityTools.ImportModulesFromDirectory\",
    "d:\GitHub\ProductivityTools.PSImportExcelToSQL\",
    "d:\GitHub\ProductivityTools.MasterConfiguration.Cmdlet\",
    "d:\GitHub\ProductivityTools.FindModuleDependencies\",
    "d:\GitHub\ProductivityTools.PublishModuleTo\",
    "d:\GitHub\ProductivityTools.PSPublishModuleToPowershellGallery\",
    "d:\GitHub\ProductivityTools.GetDayInGivenWeek\",
    "d:\GitHub\ProductivityTools.PSCmdlet\",
    "d:\GitHub\ProductivityTools.SelectSQLView\",
    "d:\GitHub\ProductivityTools.SetPhotographNameAsDateTimeTaken\",
    "d:\GitHub\ProductivityTools.SQLCommands\",
    "d:\GitHub\ProductivityTools.ConnectionStringLight\",
    "d:\GitHub\ProductivityTools.DbUp\",
    "d:\GitHub\ProductivityTools.InstallService\",
    "d:\GitHub\ProductivityTools.NugetTools\",
    "d:\GitHub\ProductivityTools.BackupBookmarksChrome\",
    "d:\GitHub\ProductivityTools.BackupBitlockerKeys\",
    "d:\GitHub\ProductivityTools.CopyItemDirectoryRepeatable\",
    "d:\GitHub\ProductivityTools.BackupBookmarksIE\",
    "d:\GitHub\ProductivityTools.InstallModuleIfMissing\",
    "d:\GitHub\ProductivityTools.GetDateName\",
    "d:\GitHub\ProductivityTools.PSGetOneDriveDirectory\"
)
foreach ($item in $Directories)
{
#$Directory="d:\GitHub\ProductivityTools.Example.GCP.SecretManager\"
$Directory=$item
Publish-ReadmeToBlog -Directory $Directory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose
}

$Directory="d:\GitHub\ProductivityTools.Articles\2022.09.23 - Setup Wordpress\"
#Publish-ReadmeToBlog -Directory $Directory -DestinationTempPath $DestinationTempPath -CdnImageAddress $CdnImageAddress -PushImagesToAzure $true -verbose

