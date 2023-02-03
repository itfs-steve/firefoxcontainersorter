## Firefox Container Sorter by CallMeSteve

Clear-Host

function SortFirefoxContainers {
    param (
        [Parameter(Mandatory=$false)][string] $ProfileDirectory,
        [Parameter(Mandatory=$false)][string] $OutFile,
        [switch]$TestRun
    )

    if ($PSBoundParameters.ContainsKey('TestRun') -eq $true) {
        Write-Host "[INFO] Test Run requested. Original file will not be affected" -ForegroundColor Cyan
        if ($PSBoundParameters.ContainsKey('OutFile') -eq $true) {
            Write-Host "[INFO] Output file specified, default will be ignored" -ForegroundColor Cyan
            $scptOutputFile = $OutFile
        } else {
            Write-Host "[WARN] No output file specified. File will be saved as containerstest.json in the profile directory" -ForegroundColor Yellow
            $scptOutputFile = "containerstest.json"
        }

    } else {
        Write-Host "[INFO] Live run in progress" -ForegroundColor Cyan
        if ($PSBoundParameters.ContainsKey('OutFile') -eq $true) {
            Write-Host "[FATAL] Output file specified, you must be in Test Run mode to do this" -ForegroundColor Red
            $scptError = 1;
        } else {
            $scptOutputFile = "containers.json"
        }

        
    }

    if ($scptError -eq 1) {
       
    } else {

        if ($PSBoundParameters.ContainsKey('ProfileDirectory') -eq $true) {
            Write-Host "[INFO] Profile Directory Specified, default process will be skipped" -ForegroundColor Cyan
            Set-Location "$ProfileDirectory"
        } else {
            Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles"
            Write-Host ""
            Write-Host "Detected Profiles:" -ForegroundColor DarkGray
            Get-ChildItem -Name
            Write-Host ""
            $containersLocation = Read-Host -Prompt "Which profile are you editing"
            Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles\$containersLocation"
        }

        $scptInputFile = "containers.json"

        # Get data in JSON file and convert to powershell-readable arrays
        $containers = Get-Content $scptInputFile | ConvertFrom-Json

        # Look at the identities array and sort into alphabetical order, store as variable
        $sortedContainers = $containers.identities | Sort-Object -Property name

        # Take the sorted containers variable and overwrite the unsorted variable with it
        $containers.identities = $sortedContainers

        # Convert back to JSON and save to file
        $containers | ConvertTo-Json | Set-Content "$scptOutputFile"

        Write-Host "[SUCCESS] Sorting Completed" -ForegroundColor Green
    }

    Pause
}

Write-Host "Welcome to the Firefox Container Sorter utility!" -ForegroundColor DarkMagenta
Write-Host ""
Write-Host "Just run 'SortFirefoxContainers' to sort your containers" -ForegroundColor Green
Write-Host ""
Write-Host "To run a Test Run, use the '-TestRun' parameter"  -ForegroundColor Magenta
Write-Host "When testing, you can specify a custom output file using the '-OutFile' parameter - make sure you make the output file a .json file"  -ForegroundColor Magenta
Write-Host ""
Write-Host "You can bypass the profile selection process by manually specifying the profile directory with the '-ProfileDirectory' parameter"  -ForegroundColor DarkYellow
Write-Host ""