$tempData = Get-Content "data.txt”

$status = 'start'
for($i = 0; $i -lt $tempData.Length; $i++)
{
    #
    if($status -eq 'bad'){
        $tempData[$i-1] = $tempData[$i-1] + $tempData[$i];
        $tempData[$i] = ''
        $status = 'good'
    }else{

        #Here we assume the line is bad and check if it is
        #in the right format
        $status = 'bad';
        for($j = 0; $j -lt $tempData[$i][$j]; $j++)
        {
            if($tempData[$i][$j] -eq '.'){
                if(($tempData[$i].Length - $j) -eq 3){
                    $status = 'good'
                }
            }
        }
    }
};

$tempData |  ? {$_.trim() -ne "" }  | Set-Content "temp.txt"
$tempData = Get-Content "temp.txt"

$status = 'REC'
$j = 0;
$Index = 0;
$pulse = 0;
for($i= 1; $i -lt $tempData.Length; $i++){
    if($status -eq 'REC'){
        if($tempData[$i] -eq $tempData[$i-1]){
            $j++;
            if($j -eq 5){
                $pulse++;
                $j = 0;
                $filename = "pulse" + $pulse + ".txt"
                $tempData[$index..$i] | Set-Content $filename
                $status = 'SKIP'
            }
        }
    
    }else{
        if($tempData[$i] -ne $tempData[$i-1]){
            $status = 'REC'
            $Index = $i-3
        }
    }
} 