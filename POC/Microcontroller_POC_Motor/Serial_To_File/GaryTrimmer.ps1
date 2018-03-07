$tempData = Get-Content "temp.txt”
$timeData = Get-Content "temp.txt”
$velocityData = Get-Content "temp.txt"

$index = 0
for($i = 0; $i -lt $tempData.Length; $i++)
{
    
    $timeData[$index] = $tempData[$i];
    $velocityData[$index] = $tempData[$i+1];
    $index++;
    $i++;
};

$velocityData |  ? {$_.trim() -ne "" }  | Set-Content "velocity.txt"
$timeData |  ? {$_.trim() -ne "" }  | Set-Content "timesec.txt"
$tempData = Get-Content "temp.txt"