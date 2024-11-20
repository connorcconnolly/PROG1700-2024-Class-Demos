param(
    $Name
)
$emojis = @{'happy'="`u{1F604}"; 'sunglasses'="`u{1F576}"; 'hammer'="`u{1F528}"}

Write-Host $emojis[$Name]

#A script is like a function that accepts parameters from the comand line. 
#add a parameter list at the top of the script, and those parameters become script level variables. 
