function ApiHeader{

	[cmdletbinding()]
	param(
		[string]$login,
		[string]$password
	)

	$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$login"+":"+"$password"))
	$header = @{
		Authorization=("Basic {0}" -f $base64AuthInfo)
	}
	return $header;
}
#
#function ApiHeader{
#	
#	$header = @{
#		Authorization=("Bearer pL3n30TVqdaZeP7LL1YE2JG6a8zZCcwm")
#	}
#	return $header;
#}

function GetArticlePostUrl{
	[cmdletbinding()]
	param(
		[string]$Title,
		[string]$login,
		[string]$password
	)
	
	$header=ApiHeader $login $password
	$posts=Invoke-RestMethod -Method GET -Uri http://productivitytools.top/wp-json/wp/v2/posts?per_page=100 -ContentType "application/json" -Headers $header 
	foreach($post in $posts){
	
		$siteTitle=$post.title.rendered
		Write-Verbose "Title $siteTitle"
		if ($siteTitle -eq $Title)
		{
			$id=$post.Id
			$urlId="http://productivitytools.top/wp-json/wp/v2/posts/$id"
			return $urlId
		}
	}
	#if no post return we are post to the general post it will create new post
	return "http://productivitytools.top/wp-json/wp/v2/posts"
}

function PublishToWordpress{
	[cmdletbinding()]
	param(
		[string]$Title,
		[string[]]$Categories,
		[object[]]$Content,
		[string]$login,
		[string]$password
	)
	
	Write-Verbose "Welcome from PublishToWordpress"
	[string]$Address= GetArticlePostUrl -Title $title -login $login -password $password

	$Content2=$Content |Out-String
	$params = @{
	    title = $Title
	    content = $Content2
	    status = 'publish'
	    categories=$Categories
	    }
	$header=ApiHeader $login $password
	$params1=$params|ConvertTo-Json
	try
	{
		$response=Invoke-RestMethod -Method post -Uri $address -ContentType "application/json" -Headers $header -Body $params1
	}
	catch [System.Net.WebException],[System.IO.IOException]
	{
		Write-Host $_
		Write-Host "Document cannot have double quotes"
		Write-Host "Document fails if you use D:\GitHub\ProductivityTools.ConnectionString\ to make it work use ``"
		Write-Host "Document fails if you will write won't"

		break
	}
}

Export-ModuleMember PublishToWordpress