<#
.SYNOPSIS
    Retrieve Moogle Master files.

.DESCRIPTION
    Retrieve Moogle Master files.

.Parameter RootDir
    Retrieves all logical volume letters.

.Parameter GitHubLink
    Master GitHub link to Moogle Master Files repository.

.Parameter WebObject
    Initialize WebClient object.

.Notes
    Author: KaliMinion
    Edited: AverageBear 3/27/2018
#>

param(

    [Parameter(DontShow)]
    [String[]]$RootDir = ((Get-Volume).DriveLetter | where {$_ -ne $null}),
    
    [Parameter(DontShow)]
    [String]$GitHubLink = "https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master",
    
    [Parameter(DontShow)]
    $WebObject = (New-Object System.Net.WebClient)
)

$Files = @(

    'Moogle Updater.lua',
    'module.def',
    'Main Window.lua',
    'MoogleScripts.lua',
    'MoogleScripts2.lua'
    'MoogleLib.lua'
)

foreach($Dir in $RootDir) {

    if(Test-Path ($Dir + ":\MinionApp")) {
    
        $MoogleStuff = $Dir + ':\MINIONAPP\Bots\FFXIVMinion64\LuaMods\MoogleStuff Files'
    }
}

If(!(Test-Path $MoogleStuff)) {

    New-Item -ItemType Directory -Path $MoogleStuff -Force | Out-Null
}

foreach($File in $Files) {

    If(!(Test-Path "$MoogleStuff\$File")) {

        Try {
        
            $WebObject.DownloadFile("$GitHubLink/$File","$MoogleStuff\$File")
        }

        Catch {
        
           Write-Error "Unable to download $MoogleStuff\$File from $GitHubLink/$File"
        }
    }
}
