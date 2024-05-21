pluginManagement {
    logger.warn(repositories.map(ArtifactRepository::getName).toString())
}
providers.gradleProperty("kotlinVersion").orNull
rootProject.name = "abc"

