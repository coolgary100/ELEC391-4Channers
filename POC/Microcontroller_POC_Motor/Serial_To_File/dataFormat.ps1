$tempData = Get-Content "data.txt”

$index = 0
for($i = 1; $i -lt $tempData.Length; $i++)
{
    #
    $n = $tempData[$index].length;

    if(($tempData[$index][$n-3] -eq '.')){
        $index++;
        $i--;
        }
    else{
        
    $tempData[$index] = $tempData[$index] + $tempData[$i];
    $tempData[$i] = ''
    }
};

$tempData |  ? {$_.trim() -ne "" }  | Set-Content "temp.txt"
$tempData = Get-Content "temp.txt"