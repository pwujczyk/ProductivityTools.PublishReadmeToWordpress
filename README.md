<!--Category:react,firebase--> 
 <p align="right">
    <a href="http://productivitytools.tech/productivitytools-createsqlserverdatabase/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.Learning.ReactWithFirebaseAuthWithDb"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>


# Publish Readme to Wordpress

Module takes readme (md) file converts it to html and publish on Wordpress. The main idea is to have the same content in github and on the blog.

<!--more-->

Module pushes images to the azure blob storage
**To use it AZ module needs to be isntalled, AZ module cannot be added as dependency as AZ is not allowed name and manifest doesn't pass validation**
```
Install-Module AZ
Connect-AzAccount
```

Module exposes two functions - 
- Publish-ReadmeToBlog - takes readme file from the given directory and pushes it to wordpress
- Publish-ReadmesToBlog - Looks for a readme files inside subdirectories and invokes Publish-ReadmeToBlog for each 

Parameters
- Directory - Directory where md file is located. If not provided current directory is used
- DestinationTempPath - 
- CdnImageAddress
- PushImageToAzure
- Login - Login to Wordpress page. Taken from [MasterConfiguration](http://productivitytools.tech/powershell-master-configuration/) if not provided
- Password - Password to Wordpress page. Taken from [MasterConfiguration](http://productivitytools.tech/powershell-master-configuration/) if not provided
- Verbose
