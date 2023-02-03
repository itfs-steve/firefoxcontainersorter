### MOZILLA FIREFOX CONTAINERS SORTER ###

# Clear Console
Clear-Host

# Ask for method
$methodChoose = Read-Host -Prompt "Please enter mode (full,dryrun)"
if ($methodChoose -eq "full") {
    # Set output file (same name for overwrite)
    $outputFile = "containers.json"
} elseif ($methodChoose -eq "dryrun") {
    # Set output file (same name for overwrite)
    $outputFile = "containerstest.json"
} else {
    $errorstate = 1;
}

# Clear Console
Clear-Host

if ($errorstate -eq 1) {
    Write-Host "[FATAL] Method not recognised" -ForegroundColor Red
} else {

    # List Profile Folders
    Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles"
    Get-ChildItem

    # Ask which profile
    $containersLocation = Read-Host -Prompt "Which profile are you editing"
    Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles\$containersLocation"

    # Get containers file
    $containersFile = "containers.json"

    

    # Get data in JSON file and convert to powershell-readable arrays
    $containers = Get-Content $containersFile | ConvertFrom-Json

    # Look at the identities array and sort into alphabetical order, store as variable
    $sortedContainers = $containers.identities | Sort-Object -Property name

    # Take the sorted containers variable and overwrite the unsorted variable with it
    $containers.identities = $sortedContainers

    # Convert back to JSON and save to file
    $containers | ConvertTo-Json | Set-Content $outputFile

    # Clear Console
    Clear-Host

    # Final Message
    if ($methodChoose -eq "full") {
        Write-Host "[SUCCESS] Sorting Completed" -ForegroundColor Green
    } else {
        Write-Host "[SUCCESS] Dry Run Complete, please navigate to your profile folder and open the containertest.json file to confirm all looks ok." -ForegroundColor Green
    }
    

}

Pause