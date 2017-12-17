$s = $PSScriptRoot
$MoogleStuff = $s.Substring(0, $s.IndexOf('MINIONAPP'))+'\MINIONAPP\Bots\FFXIVMinion64\LuaMods\MoogleStuff Files'
If(!(test-path $MoogleStuff))
{
md -Force $MoogleStuff
}
If(!(test-path $MoogleStuff'\MoogleUpdater.lua'))
{
(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleUpdater.lua',$MoogleStuff+'\MoogleUpdater.lua')
}
If(!(test-path $MoogleStuff'\module.def'))
{
(New-Object System.Net.WebClient).DownloadFile('https://github.com/KaliMinion/Moogle-Stuff/raw/master/MoogleStuffModule.def',$MoogleStuff+'\module.def')
}

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Files installed, press any key to close this window then Reload Lua..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}
