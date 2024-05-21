#!/bin/bash

# Define the path to the user's gradle.properties file
GRADLE_PROPERTIES="$HOME/.gradle/gradle.properties"

# Check if the gradle.properties file exists
if [ -f "$GRADLE_PROPERTIES" ]; then
    echo "Found gradle.properties at $GRADLE_PROPERTIES"

    # Check if the property "project.usage" exists
    if grep -q "^project.usage=" "$GRADLE_PROPERTIES"; then
        echo "Property 'project.usage' exists. Checking value..."

        # Get the value of project.usage
        USAGE_VALUE=$(grep "^project.usage=" "$GRADLE_PROPERTIES" | cut -d'=' -f2)

        if [ "$USAGE_VALUE" == "internal" ]; then
            sed -i 's/^project.usage=internal/project.usage=external/' "$GRADLE_PROPERTIES"
        elif [ "$USAGE_VALUE" == "external" ]; then
            sed -i 's/^project.usage=external/project.usage=internal/' "$GRADLE_PROPERTIES"
        else
            echo "Property 'project.usage' has an unexpected value. Setting it to 'external'..."
            sed -i 's/^project.usage=.*/project.usage=external/' "$GRADLE_PROPERTIES"
        fi

    else
        echo "Property 'project.usage' does not exist. Adding property with value 'external'..."
        echo "project.usage=external" >> "$GRADLE_PROPERTIES"
    fi

else
    echo "gradle.properties not found. Creating file and adding property 'project.usage' with value 'external'..."

    # Create the gradle.properties file and add the property
    mkdir -p "$HOME/.gradle"
    echo "project.usage=external" > "$GRADLE_PROPERTIES"
fi

echo "Operation completed."
