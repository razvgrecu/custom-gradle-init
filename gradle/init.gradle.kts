
class EnterpriseRepositoryPlugin : Plugin<Gradle> {

    override fun apply(gradle: Gradle) {
        gradle.beforeSettings {
            pluginManagement {
                repositories {
                    when (providers.gradleProperty("abcUser1").orNull) {
                        "external" -> mavenCentral()
                        "1" -> gradlePluginPortal()
                        else -> google()
                    }
                }
            }
        }
    }
}

apply<EnterpriseRepositoryPlugin>()
