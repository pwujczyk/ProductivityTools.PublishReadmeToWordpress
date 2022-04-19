Write-Host "Find all Readme.md"
Write-Host "Copy readme to temporary directory"
Write-Host "Replace image address"
Write-Host "Perform conversion"
Write-Host "Push to blog/Update"
Write-Host "Update picture on CDN"


. $PSScriptRoot\ProductivityTools.PublishToWordpress.ps1

function ReplaceImageAddresses{

	[cmdletbinding()]
	param(
		[string]$TempDirectory,
		[string]$CdnImageAddress
	)
	
	Write-Verbose "Hello from ReplaceImageAddresses"
	
	$ReadmePath=GetReadmePath $tempDirectory
	Write-Verbose "Readme path: $ReadmePath"
	
	$temDirectoryhObj=Get-Item $TempDirectory
	$tempDirectoryWithotuSpaces=$temDirectoryhObj.Name -replace ' ',"%20"
	$DestinationImageAddress=$CdnImageAddress + $tempDirectoryWithotuSpaces+"/"
	Write-Verbose "Destination image address: $DestinationImageAddress"
	
	$content=Get-Content -path $ReadmePath -Raw
	$result=$content -replace 'Images/',"$DestinationImageAddress"
	Set-Content -Value $result -Path $ReadmePath
}

function GetURL{
	[cmdletbinding()]
	param(
		[string]$TempDirectory,
		[string]$Pattern
	)
	
	$ReadmePath=GetReadmePath -Path $TempDirectory
	$content=Get-Content -path $ReadmePath
	foreach($line in $content)
	{
		if($line -like "*$Pattern*")
		{
			$adressStart=$line.IndexOf('"')+1;
			$addressEnd=$line.IndexOf('"',$adressStart)
			
			$address=$line.SubString($adressStart,$addressEnd-$adressStart)
			return $address
		}
	}
	return ''
}

function GetTitle{
	
	[cmdletbinding()]
	param(
		[string]$TempDirectory
	)
	
	Write-Verbose "Hello from GetTitle"
	$ReadmePath=GetReadmePath -Path $TempDirectory
	$content=Get-Content -path $ReadmePath
	
	foreach($line in $content)
	{
		if($line -like "# *")
		{
			Write-Verbose "Title line: $line"
			$title=$line
			$title=$title.Trim('#').Trim(' ')
			Write-Verbose "Title: $title"
			return $title;
		}
	}
	
	throw "Sorry no title"
}

function GetCategory{
	
	[cmdletbinding()]
	param(
		[string]$TempDirectory
	)
	
	Write-Verbose "Hello from GetCategory"
	$ReadmePath=GetReadmePath -Path $TempDirectory
	$content=Get-Content -path $ReadmePath
	
	foreach($line in $content)
	{
		#if($line -like "<!--\\[Cagetory:*")
		if($line -like "<!--Category:*")
		{
			Write-Verbose "Category line: $line"
			
			$categoryStart=$line.IndexOf(':')+1;
			$categoryEnd=$line.IndexOf('-',$categoryStart)
			
			$categories=$line.Substring($categoryStart,$categoryEnd-$categoryStart)
			$categoriesArray=$categories.split(',');
			Write-Verbose "Categories: $categoriesArray"
			return $categoriesArray;
		}
	}
	
	throw "No categories please add categories"
}

function RemoveHeader{
	
	[cmdletbinding()]
	param(
		[string]$TempDirectory
	)
	
	Write-Verbose "Hello from GetTitle"
	$ReadmePath=GetReadmePath -Path $TempDirectory
	$content=Get-Content -path $ReadmePath
	
	foreach($line in $content)
	{
		if($line -like "# *")
		{
			$contentRaw=Get-Content -path $ReadmePath -Raw
			$titlePosition=$contentRaw.IndexOf($line)
			$titleLength=$line.Length
			$start=$titlePosition+$titleLength+2
			$end=$contentRaw.Length-$start;
			$result=$contentRaw.Substring($start,$end)
			Set-Content -Value $result -Path $ReadmePath
		}
	}
}

function CopyImagesToAzure{
	[cmdletbinding()]
	param(
		[string]$Prefix,
		[string]$ImagePath
	)
	
	Write-Verbose "Hello from CopyImagesToAzure"
	Write-Verbose "Path to images: $ImagePath"


	$images=Get-ChildItem $ImagePath
	foreach($image in $images)
	{
		$imageFullName=$image.FullName
		Write-Verbose "Pushing $imageFullName"
		Push-FileToAzureBlobStorage -Profile AzureProductivityTools -Path $imageFullName   -Prefix $Prefix
	}
}

function GetArticlePath{
	[cmdletbinding()]
	param(
		[string]$Path
	)
	
	Write-Verbose "Hello from GetArticlePath"
	Write-Verbose "Article directory path:$Path"
	
	$articleTempFullName=Join-Path $Path "article.html"
	
	return $articleTempFullName
}

function GetReadmePath{
	[cmdletbinding()]
	param(
		[string]$Path
	)
	
	$readmeTempFullName=Join-Path $Path "README.md"
	return $readmeTempFullName
}


function ConvertToHtml{
	
	[cmdletbinding()]
	param(
		[string]$TempFullPath
	)
	
	Write-Verbose "Hello from ConvertToHtml"
	$readmeTempFullName=GetReadmePath $TempFullPath
	#ConvertFrom-Markdown -Path $readmeTempFullName -TargetFormat Html -OutputDirectory $TempFullPath -OutputFileName article.html -Verbose
	$markdownObject=ConvertFrom-Markdown -Path $readmeTempFullName
	$targetFileName=Join-Path $TempFullPath "article.html"
	$markdownObject.Html |Out-File $targetFileName
	$articleTempFullName=GetArticlePath $TempFullPath
	Write-Verbose "Temp article full path: $articleTempFullName"
	return $articleTempFullName

}


function GetCategoriesId{
	[cmdletbinding()]
	param(
		[string[]]$Categories
	)
	
	Write-Verbose "Hello from GetCategoriesId"
	[String[]]$result=@()
	foreach($category in $Categories)
	{
		$r=GetCategoryId $category
		$result+=$r;
	}
	Write-Verbose "Category Ids: $result"
	return $result;
}

function GetCategoryId{

	[cmdletbinding()]
	param(
		[string]$Category
	)
	
	#http://productivitytools.tech/wp-json/wp/v2/categories
	$result=switch($Category){
   		"C#" {4; break;}
   		"Powershell" {3; break;}
   		"SQL" {7;break;}
		"WinApp" {10;break;}
		"Article" {11;break;}
		"React" {12;break;}
		
	}
	return $result;
}

function InsertHeader{
	[cmdletbinding()]
	param(
		[string]$TempFullPath,
		 
		[string]$PowershellGalleryUrl,
		[string]$ProductivityToolsUrl,
		[string]$GithubUrl,
		[string]$NugetUrl,
		[string]$MicrosoftStore
	)
	[string]$header='<div class="article-external-links">'
	
	if ($PowershellGalleryUrl -ne '')
	{
		$header=$header+'<a title="Powershell Gallery" href="'+$PowershellGalleryUrl+'" target="_blank" rel="noopener noreferrer"><img src="http://cdn.productivitytools.tech/images/General/Powershell40px.png"></a>'		
	}	
	
	if ($NugetUrl -ne '')
	{
		$header=$header+'<a title="Nuget" href="'+$NugetUrl+'" target="_blank" rel="noopener noreferrer"><img src="http://cdn.productivitytools.tech/images/General/Nuget40px.png"></a>'		
	}
	
	if ($MicrosoftStore -ne '')
	{
		$header=$header+'<a title="MicrosoftStore" href="'+$MicrosoftStore+'" target="_blank" rel="noopener noreferrer"><img src="http://cdn.productivitytools.tech/images/General/WindowsStore40px.png"></a>'	
	}
	
	if ($GithubUrl -ne '')
	{
		$header=$header+'<a title="Github" href="'+$GithubUrl+'" target="_blank" rel="noopener noreferrer"><img src="http://cdn.productivitytools.tech/images/General/Github40px.png"></a>'	
	}	
	
	$header=$header+'</div>'
	$articleResultFullName=GetArticlePath $TempFullPath
	$result=$header
	Start-Sleep -Milliseconds 500
	$result=$header + (Get-Content $articleResultFullName -Raw)
	Set-Content -Value $result -Path $articleResultFullName
}

function ReplaceHeader{
	
	[cmdletbinding()]
	param(
		[string]$tempDirectory,
		[string]$imagesFullPath,
		[bool]$PushImagesToAzure
	)
	
	$powershellGalleryUrl=GetURL -TempDirectory $tempDirectory -Pattern "www.powershellgallery.com"
	$productivityToolsUrl=GetURL -TempDirectory $tempDirectory -Pattern "productivitytools.tech"
	$githubUrl=GetURL -TempDirectory $tempDirectory -Pattern "github.com"
	$nugetUrl=GetURL -TempDirectory $tempDirectory -Pattern "www.nuget.org"
	$MicrosoftStore=GetURL -TempDirectory $tempDirectory -Pattern "https://www.microsoft.com/store/"
	
	
	$DirectoryObject=Get-Item $tempDirectory
	$DirectoryBaseName=$DirectoryObject.BaseName

	RemoveHeader -TempDirectory $tempDirectory
	if($PushImagesToAzure)
	{
		CopyImagesToAzure -Prefix  $DirectoryBaseName -ImagePath $imagesFullPath -Verbose
	}

	ConvertToHtml -TempFullPath $tempDirectory 
	
	InsertHeader -TempFullPath $tempDirectory `
	-PowershellGalleryUrl $powershellGalleryUrl `
	-ProductivityToolsUrl $productivityToolsUrl `
	-GithubUrl $githubUrl `
	-NugetUrl $nugetUrl `
	-MicrosoftStore $MicrosoftStore
}

function CopyMdFileToTempDirectory{
	[cmdletbinding()]
	param(
		[string]$Directory,
		[string]$DestinationTempPath
	)
	
	Write-Verbose "Destination Temporary path: $DestinationTempPath"
	$DirectoryObject=Get-Item $Directory
	$DirectoryBaseName=$DirectoryObject.BaseName
	
	$tempDirectory=Join-Path $DestinationTempPath $($DirectoryObject.BaseName)
	Write-Verbose "Temporary directory full path: $tempDirectory"
	
	New-Item -ItemType Directory -Force -Path $tempDirectory |Out-Null

	$readmeFullPath=$(Get-ChildItem $Directory -filter "Readme.md").FullName
	Write-Verbose "Readme full path: $readmeFullPath"
	
	Copy-Item $readmeFullPath $tempDirectory
	return $tempDirectory
	#$readmeTempFullName=GetReadmePath $tempDirectory
}

function ReplaceImagesToCdnPath{
	[cmdletbinding()]
	param(
		[string]$Directory,
		[string]$tempDirectory,
		[string]$imagesFullPath,
		[string]$CdnImageAddress
	)
	
	if(Test-Path $imagesFullPath)
	{
		Write-Verbose "Images full path: $imagesFullPath"
		Copy-Item "$imagesFullPath" $tempDirectory -Recurse -Force		
		ReplaceImageAddresses $tempDirectory $CdnImageAddress
	}
	else
	{
		Write-Verbose "Images directory doesn't exists"
	}
}

function Publish-ReadmeToBlog{
	
	[cmdletbinding()]
	param(
		[string]$Directory=$(Get-Location),
		[string]$DestinationTempPath,
		[string]$CdnImageAddress,
		[bool]$PushImagesToAzure,
		[string]$Login,
		[String]$Password
	)
	
	Write-Verbose "Hello from ProcessReadmeDirectory"
	Write-Verbose "Directory analysed: $Directory"
	
	if($Login -eq "")
	{
		$Login=Get-MasterConfiguration "WordpressLogin"
	}

	if($Password -eq "")
	{
		$Password=Get-MasterConfiguration "WordpressPassword"
	}

	if($DestinationTempPath -eq "")
	{
		
		$Folder=New-TemporaryDirectory
		Write-Verbose "Temporary folder name $Folder"
		$DestinationTempPath=$Folder;
	}


	
	$tempDirectory=CopyMdFileToTempDirectory $Directory $DestinationTempPath
	$imagesFullPath=Join-Path $Directory "Images"
	ReplaceImagesToCdnPath $Directory $tempDirectory $imagesFullPath $CdnImageAddress
	
	
	$title=GetTitle -TempDirectory $tempDirectory 
	$Categories=GetCategory -TempDirectory $TempDirectory
	$CategoriesId=GetCategoriesId -Categories $Categories
	
	ReplaceHeader -tempDirectory $tempDirectory -ImagesFullPath $imagesFullPath $PushImagesToAzure

	$articleTempFullName=GetArticlePath $tempDirectory
	Write-Verbose "Path to temp article: $articleTempFullName"

	$Content=Get-Content $articleTempFullName
	PublishToWordpress -Title $title -Categories $CategoriesId -Content $Content -login $Login -password $Password
}

function FindReadmeFiles{

	[cmdletbinding()]
	param(
		[string]$Directory
	)
	
	Write-Verbose "Hello from FindReadmeFiles"
	Write-Verbose "Looking for Readme.md in directory $Directory"
	
	$Directories=Get-ChildItem -Path $Directory | ?{ $_.PSIsContainer } 
	$readmes=$Directories | % {Get-ChildItem $_.FullName -filter "Readme.md" -Recurse }
	Write-Verbose "Found $($readmes.Count) readme files"
	return $readmes;
}

function Publish-ReadmesToBlog{

	[cmdletbinding()]
	param(
		[string]$Directory=$(Get-Location),
		[string]$DestinationTempPath,
		[string]$CdnImageAddress,
		[bool]$PushImagesToAzure=$true
	)

	$readmes=FindReadmeFiles $Directory 
	
	foreach($readme in $readmes)
	{
		Publish-ReadmeToBlog $readme.Directory $DestinationTempPath $CdnImageAddress $PushImagesToAzure
		#ProcessReadmeDirectory "D:\GitHub-3.PublishedToLinkedIn\ProductivityTools.PSImportExcelToSQL" $DestinationTempPath $CdnImageAddress $PushImagesToAzure
	}
}
