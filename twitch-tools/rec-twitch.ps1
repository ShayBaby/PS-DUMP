# I wrote this while high as hell on caffeine and nicotine. Fingers wont stop shaking.
# I tried to clean syntax and spelling as I wrote it, errors may occur.

# Expects Streamlink installed and added to the $PATH

$Target = Read-Host "Enter Twitch username to record: "
$RecTarget = Read-Host "Enter a name for the recording: "
$EndTime = Read-Host "Enter a local time to end (ex: 12:05 PM): "

Measure-Command {

    [Diagnostics.Process]::Start("streamlink.exe","https://www.twitch.tv/$Target best -o $RecTarget.mp4")

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

Write-Host "Process stopped. Stream captured. Recording should be located at: $RecTarget.mp4" # Return(1) message.
