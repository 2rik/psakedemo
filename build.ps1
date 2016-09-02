cls 

# [p]sake is the same as psake but $Error is not polluted
remove-module [p]sake

# find psake's path
$psakeModule = (Get-ChildItem (".\packages\psake*\tools\psake.psm1")).FullName | Sort-Object $_ | select -last 1

Import-Module $psakeModule

Invoke-psake -buildFile .\default.ps1 `
			 -taskList Test `
			 -properties @{ 
				 "buildConfiguration" = "Release" ` 
			     "buildPlatform" = "Any CPU" } `
			-parameters @{ 
				 "solutionFile" = ".\Build.sln" }

Write-Host "Build exit code:" $LastExitCode

exit $LastExitCode