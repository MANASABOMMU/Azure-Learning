﻿## Using functions Write a Fizz-Buzz program which takes start number, stop number, number of numbers to be displayed on a line.
## Every number divisible by 3 must be printed as "Fizz", divisible by 5 must be printed as "Buzz" and divisible by 15 must be "FizzBuzz"


## Run the program using below command
## Day2-Assignment.ps1 startnumber endnumber countofnumstodisplayinline

Function DisplayNumbers () 
{
Write-Host "Your Input Start Number" $StartNumber and "End Number" $EndNumber

$j = 0
   
For ( $i=$StartNumber; $i -le $EndNumber ; $i++)
{
        
$j++;
if ( $i % 3 -eq 0)
{
    Write-Host -NoNewline "FIZZ"  `t
} 
elseif ($i % 5 -eq 0)
{
    Write-Host -NoNewline "BUZZ" `t
} 
elseif ($i % 15 -eq 0)
{
    Write-Host -NoNewline "FIZZBUZZ" `t

} else {
    Write-Host -NoNewline $i  `t
}
if ( $j -eq $NoNToBeDisplay)
{
    $j = 0;
    Write-Host `n
            
}
    
}
}



# Call DisplayNumbers()
try {

$StartNumber = $args[0];
$EndNumber = $args[1];
$NoNToBeDisplay = $args[2];

DisplayNumbers;

}
catch [System.Exception] {
Write-Host $_.Exception.ToString()
exit 1
}






