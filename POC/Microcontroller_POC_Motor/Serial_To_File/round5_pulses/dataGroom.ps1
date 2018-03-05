$tempData = Get-Content "data-fmt2.txt”
$timeData = Get-Content "data-fmt2.txt”

$status = 'start'
$index = 0
for($i = 0; $i -lt $tempData.Length; $i++)
{
    if($i -gt 5373){
            $timeData[$index] = $tempData[$i].Substring(0,6)
            $index++
        $tempData[$i] = $tempData[$i].Substring(6);
    }
    else{
        if($i -gt 4024){
            $timeData[$index] = $tempData[$i].Substring(0,5)
            $index++
            $tempData[$i] = $tempData[$i].Substring(5);
            }
    else{
        if($i -gt 3996){
            $tempData[$i] = $tempData[$i];
        }    
    else{
        if($i -gt 610){
            $timeData[$index] = $tempData[$i].Substring(0,5)
            $index++
            $tempData[$i] = $tempData[$i].Substring(5);
        }
    else{
        if($i -gt 95){
            $timeData[$index] = $tempData[$i].Substring(0,4)
            $index++
            $tempData[$i] = $tempData[$i].Substring(4);
            }
    else{
        if($i -gt 39){
            $timeData[$index] = $tempData[$i].Substring(0,3)
            $index++
            $tempData[$i] = $tempData[$i].Substring(3);
            }
    }}}}}
};

$tempData |  ? {$_.trim() -ne "" }  | Set-Content "temp.txt"
$timeData |  ? {$_.trim() -ne "" }  | Set-Content "time.txt"
#$tempData = Get-Content "temp.txt"  + "`r`n"
