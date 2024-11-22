function Write-Hello{
    Write-Host "Hello World"
}

function Get-DBFileName {
    return "$PSScriptRoot\crappy_db.txt"
}


#public functions
function Add-Data{
    #add some records
    $records=@(
        @("w100", "John", "Smith"),
        @("w101", "Jane", "Jones"),
        @("w102", "Mork", "From Ork")
    )
    Set-Content -Path (Get-DBFileName) -Value "" -NoNewline #Clears the contents of the file before adding data
    foreach ($r in $records){
        $row=$("$($r[0]),$($r[1]),$($r[2])") 
        Add-Content -Path (Get-DBFileName) -Value $row
        
    }
    

}
function Add-Data2{
    #add some records
    $records=@(
        @("w100", "John", "Smith"),
        @("w101", "Jane", "Jones"),
        @("w102", "Mork", "From Ork")
    )
    $fs = [System.IO.StreamWriter]::new((Get-DBFileName)) #opening file using .NET Functions
    foreach ($r in $records){
        $row=$("$($r[0]),$($r[1]),$($r[2])") 
        #Add-Content -Path (Get-DBFileName) -Value $row
        $fs.WriteLine($row)
    }
    $fs.Close()

}

function Select-Data{
    param(
        $Search
    )
    #Get-Content - reads from a file and puts each line in an array.
    Write-Host "Looking for $Search"
    $table=Get-Content -Path (Get-DBFileName)
    if($Search){
        foreach ($row in $table){
            $fields =$row.Split(",")
            if($Search -in $fields){
                Write-Host $row}
    }
    }
    else{
        foreach ($row in $table){
            $id, $first, $last =$row.Split(",")
            Write-Host $row
        }
    }
    

}

function Update-Data{
    
    $table=Get-Content -Path (Get-DBFileName)
    Set-Content -Path (Get-DBFileName) -Value "" -NoNewline #Clears the contents of the file
        foreach($row in $table){
            $id, $first, $last =$row.Split(",")
            if($id -eq "w102"){
                $id="w666"
            }
            "$id,$first,$last" | Add-Content -Path (Get-DBFileName)
        }

}

function Remove-Data{
    $table=Get-Content -Path (Get-DBFileName)
    Set-Content -Path (Get-DBFileName) -Value "" -NoNewline #Clears the contents of the file
        foreach($row in $table){
            $id, $first, $last =$row.Split(",")
            if(-not ($id -eq "w102")){
                "$id,$first,$last" | Add-Content -Path (Get-DBFileName)
            }
            
        }

}

Export-ModuleMember -Function Add-Data, Select-Data, Update-Data, Remove-Data