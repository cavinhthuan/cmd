# Set the path to the local directory containing your Bash scripts
$localDirectory = ".\"
$url = "http://localhost:3000/Bash"

# Send a request to get the file names
$response = Invoke-RestMethod -Uri $url 

# Get all files in the local directory (excluding hidden files)
#$files = Get-ChildItem -Path $localDirectory -File | Where-Object { -not $_.Name.StartsWith(".") -and $_.Name.EndsWith(".ps1") }
 
# Extract the file names from the JSON response
$files = $response.files

# Clear the screen
Clear-Host

# Display the menu
Write-Host "----- Menu -----"

# Loop through each file and display as a menu option
for ($i = 0; $i -lt $files.Count; $i++) {
    $fileName = ($files[$i].Name -split '\.')[0]
    Write-Host "$($i + 1). Run $fileName"
}

Write-Host "----------------"

# Prompt user for choice
$choice = Read-Host "Choose an option (1 to $($files.Count)):"
if ($choice -ge 1 -and $choice -le $files.Count) {
    # Construct the URL with the selected file name
    $selectedFileName = ($files[$choice - 1].Name -split '\.')[0]
    $selectedFileUrl = $url + "?run=" + $selectedFileName

    Invoke-RestMethod -Uri $selectedFileUrl | Invoke-Expression
} else {
    Write-Host "Invalid choice."
}

