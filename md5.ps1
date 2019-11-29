$URL="http://xxxx.xx.xxx:xxx"

$safari=([Microsoft.PowerShell.Commands.PSUserAgent]::Safari)


$r=Invoke-WebRequest -uri $URL  -UserAgent $agent  -SessionVariable session
$pattern =  '(?i)<h3[^>]*>(.*)</h3>' 
$result = [Regex]::Matches($r.Content, $pattern)
#$result.groups.value[1]


$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($result.groups.value[1])))
$MD5=$hash.Replace('-','').ToLower()
$md5
$input = @{
    
     'hash' = $md5
    

 } 
 
 


$d=Invoke-WebRequest  -uri  $URL -UserAgent $safari -Method post -body $input -WebSession $session 

$d.headers
$d.Content



