$s = $PSScriptRoot
$MoogleStuff = $s.Substring(0, $s.IndexOf('MINIONAPP'))+'\MINIONAPP\Bots\FFXIVMinion64\LuaMods\MoogleStuff Files'
If(!(test-path $MoogleStuff))
{
md -Force $MoogleStuff
}
If(!(test-path $MoogleStuff'\Moogle Updater.lua'))
{
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleUpdater.lua',$MoogleStuff+'\Moogle Updater.lua')
}
If(!(test-path $MoogleStuff'\module.def'))
{
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleStuffModule.def',$MoogleStuff+'\module.def')
}
If(!(test-path $MoogleStuff'\Main Window.lua'))
{
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MainWindow.lua',$MoogleStuff+'\Main Window.lua')
}
If(!(test-path $MoogleStuff'\Moogle Scripts.lua'))
{
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleScripts.lua',$MoogleStuff+'\Moogle Scripts.lua')
}
If(!(test-path $MoogleStuff'\MoogleLib.lua'))
{
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/KaliMinion/Moogle-Stuff/master/MoogleLib.lua',$MoogleStuff+'\MoogleLib.lua')
}

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Files installed, press any key to close this window then Reload Lua..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}