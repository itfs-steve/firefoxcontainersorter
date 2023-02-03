### MOZILLA FIREFOX CONTAINERS SORTER ###

# Clear Console
Clear-Host

# List Profile Folders
Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles"
Get-ChildItem

# Ask which profile
$containersLocation = Read-Host -Prompt "Which profile are you editing"
Set-Location "$env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles\$containersLocation"

# Get containers file
$containersFile = "containers.json"

# Set output file (same name for overwrite)
$outputFile = "containerstest.json"

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
Write-Host "Dry Run Complete, please navigate to your profile folder and open the containertest.json file to confirm all looks ok."