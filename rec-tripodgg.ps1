﻿# I wrote this while high as hell on caffeine and nicotine. Fingers wont stop shaking.
# I tried to clean syntax and spelling as I wrote it, errors may occur.

# Expects Streamlink installed and added to the $PATH

$EndTime = Read-Host "Enter a local time to end capture (ex: 12:05 PM): "
$RND = [System.IO.Path]::GetRandomFileName()

# If TripodGG is offline then it will capture anything he hosts. Go bug him to get his ass online on
# his discord: https://discord.gg/NWJS2tg

Measure-Command {

[Diagnostics.Process]::Start("streamlink.exe","https://www.twitch.tv/TripodGG best -o TripodGG_$RND.mp4")

$ps = new-object System.Diagnostics.Process
$ps.StartInfo.Filename = "streamlink.exe"
$ps.StartInfo.Arguments = " /all"
$ps.StartInfo.RedirectStandardOutput = $True
$ps.StartInfo.UseShellExecute = $true

Sleep -Seconds (New-TimeSpan -End "$EndTime").TotalSeconds

# HALT Python and Streamlink

$pyid = (Get-Process python).id # Get and store Python's proc ID
$steid = (Get-Process streamlink).id # Get and store streamlink's proc ID

Stop-Process -Id $steid # HALT streamlink
Stop-Process -Id $pyid # HALT Python
Wait-Process -Id $pyid # Wait for clean exit()

}

Write-Host "Process stopped. Stream captured. Recording should be located at: TripodGG_$RND.mp4" # Return(1) (yes I'm a C hacker) message.

# ~/.Trash - Didn't need any of the below lines, so just dropped them here.

#$LogTarget = Read-Host "Enter name for log file: "
#$args = "https://www.twitch.tv/$Target best -o $RecTarget.mp4"
#$Proc = streamlink -LoadUserProfile -ArgumentList "https://www.twitch.tv/$Target best -o $RecTarget.mp4" -PassThru
# Wait-Process -Id $steid # Wait for clean exit()
#iex $Proc