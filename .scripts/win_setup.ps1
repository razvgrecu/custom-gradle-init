# Define the path to the user's gradle.properties file
$gradleProperties = "$env:USERPROFILE\.gradle\gradle.properties"

# Function to update or create the gradle.properties file
function Update-GradleProperties {
    if (Test-Path -Path $gradleProperties) {
        Write-Output "Found gradle.properties at $gradleProperties"

        # Read the file content
        $content = Get-Content -Path $gradleProperties

        # Check if the property "project.usage" exists
        if ($content -match "^project.usage=") {
            Write-Output "Property 'project.usage' exists. Checking value..."

            # Get the value of project.usage
            $usageValue = $content -match "^project.usage=(.*)" | Out-Null
            $usageValue = $Matches[1].Trim()

            if ($usageValue -eq "internal") {
                $content = $content -replace "^project.usage=internal", "project.usage=external"
            } elseif ($usageValue -eq "external") {
                $content = $content -replace "^project.usage=external", "project.usage=internal"
            } else {
                Write-Output "Property 'project.usage' has an unexpected value. Setting it to 'external'..."
                $content = $content -replace "^project.usage=.*", "project.usage=external"
            }

            # Write updated content back to the file
            Set-Content -Path $gradleProperties -Value $content
        } else {
            Write-Output "Property 'project.usage' does not exist. Adding property with value 'external'..."
            Add-Content -Path $gradleProperties -Value "project.usage=external"
        }
    } else {
        Write-Output "gradle.properties not found. Creating file and adding property 'project.usage' with value 'external'..."

        # Create the .gradle directory if it does not exist
        $gradleDir = Split-Path -Path $gradleProperties -Parent
        if (-not (Test-Path -Path $gradleDir)) {
            New-Item -ItemType Directory -Path $gradleDir | Out-Null
        }

        # Create the gradle.properties file and add the property
        Set-Content -Path $gradleProperties -Value "project.usage=external"
    }
    Write-Output "Operation completed."
}

# Execute the function
Update-GradleProperties
