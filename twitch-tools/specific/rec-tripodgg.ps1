# This has been modified specifically for TripodGG's community. No other uses allowed.
# Will only capture his stream unless modified. I don't do support but join his discord
# https://discord.gg/NWJS2tg
# And bug RetroBecky about it.


# I wrote this while high as hell on caffeine and nicotine. Fingers wont stop shaking.
# I tried to clean syntax and spelling as I wrote it, errors may occur.
# Expects Streamlink installed and added to the $PATH

# If TripodGG is offline then it will capture anything he hosts. Go bug him to get his ass online on
# his discord.

$EndTime = Read-Host "Enter a local time to end capture (ex: 12:05 PM): "
$RND = [System.IO.Path]::GetRandomFileName()

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
