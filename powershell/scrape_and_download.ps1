# $error.clear()
# $ErrorActionPreference = 'silentlycontinue'
# $ErrorActionPreference = 'continue'

Write-Output "Starting"

$response = Invoke-WebRequest -URI https://sam.gov/SAM/pages/public/extracts/samPublicAccessData.jsf
[String]$parselink = $response.Links | select href | Select-String -Pattern 'SAM_PUBLIC_MONTHLY' | Select-String -Pattern 'extractfiledownload'
$sublink1 = $parselink.TrimStart("@{href=") 
$sublink2 = $sublink1.TrimEnd("}")
$downloadlink = "https://sam.gov"+$sublink2
$downloadlink

$url = "https://sam.gov/SAM/extractfiledownload?role=WW&amp;version=SAM&amp;filename=SAM_PUBLIC_MONTHLY_20200202.ZIP"
$output = "$PSScriptRoot\download\SAM_PUBLIC_MONTHLY.zip"
Invoke-WebRequest -URI $url -OutFile $output

# $url = "https://neals-s3-test.s3.amazonaws.com/SAM_PUBLIC_MONTHLY_20200106.zip"
# $url = "https://sam.gov/SAM/extractfiledownload?role=WW&amp;version=SAM&amp;filename=SAM_PUBLIC_MONTHLY_20200202.ZIP"
# $url = $downloadlink
# $output = "$PSScriptRoot\download\SAM_PUBLIC_MONTHLY.zip"
# $start_time = Get-Date
# Write-Output $start_time

# $wc = New-Object System.Net.WebClient
# $wc.DownloadFile($url, $output)
#OR
# (New-Object System.Net.WebClient).DownloadFile($url, $output)

# Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

# https://sam.gov/SAM/extractfiledownload?role=WW&version=SAM&filename=SAM_PUBLIC_MONTHLY_20191201.ZIP

# Write-Output $sublink

Write-Output "Done"
