$URL="http://docker.hackthebox.eu:31209"
$safari=([Microsoft.PowerShell.Commands.PSUserAgent]::Safari)

$r=Invoke-WebRequest -uri $URL  -UserAgent $safari
$pattern =  '(?i)<h3[^>]*>(.*)</h3>' 
$result = [Regex]::Matches($r.Content, $pattern)
#$result.groups.value[1]


$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($result.groups.value[1])))
$MD5=$hash.Replace('-','')
#$md5

$input = @{
    
     'hash' = $md5
    

 } | ConvertTo-Json

#$json=$input | ConvertTo-Json


$d=Invoke-WebRequest  -uri  $URL  -Method post -body $input  -UserAgent $safari
$d.Content

#$d.Content
#$dupa

