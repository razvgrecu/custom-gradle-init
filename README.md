# Things to read

## Setup

This demo uses a specialized setup consisting of an initialisation script, a settings script and a project script.

The locations are as follows:
- initialisation script: `PROJECT_DIR/gradle/init.gradle.kts`
- settings script: `PROJECT_DIR/settings.gradle.kts`
- build script `PROJECT_DIR/build.gradle.kts`

The initialisation script sets up repositories for plugins based on 
the existence of a property in the project/system `gradle.properties` file

The settings file then prints out the selected repositories based on that. Since the script can use kotlin, 
it's possible to create different conditions, however it doesn't seem to be needed.

The contents of the initialisation script are defined as a plugin class and applied 
before evaluating the settings script. The script has access to the `gradle.properties` file and to the
environment variables for setting up respository credentials.

## Other scripts
Additionally, this repository contains 2 scripts for `Windows`/`Linux`/`MacOS` such that it becomes easy to switch
whether the build is used in an internal or external network. The main principle is that it will use the
`gradle.properties` file of the user, not of the project, to set up this key.

- If `gradle.properties`
    - exists, update
    - does not exist, create

- If our property does not exist, add it and set to `external`
- If our property exists:
  - if value is `external`, set to `internal`
  - if value is `internal`, set to `external`
  - if value is empty or set to something else, set to `external`

