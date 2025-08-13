plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ reemplaza "kotlin-android"
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.notificaciones_app"

    // ✅ Mantén compile/target desde Flutter; actualiza Java a 17 (recomendado por AGP recientes)
    compileSdk = flutter.compileSdkVersion

    ndkVersion = "27.0.12077973" // ✅ NDK actualizado según lo requerido

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17 // ✅ sube a 17
        targetCompatibility = JavaVersion.VERSION_17 // ✅ sube a 17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString() // ✅ sube a 17
    }

    defaultConfig {
        applicationId = "com.example.notificaciones_app" // ✅ Asegúrate que coincida con Firebase

        // ✅ Min SDK 21 es requisito para google_maps_flutter
        minSdk = maxOf(21, flutter.minSdkVersion)

        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // ✅ Placeholder para la API key de Google Maps (se usa en AndroidManifest.xml como ${MAPS_API_KEY})
        val mapsApiKey = (project.findProperty("MAPS_API_KEY") as String?)
            ?: System.getenv("MAPS_API_KEY")
            ?: ""
        manifestPlaceholders["MAPS_API_KEY"] = mapsApiKey
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ❗ No hace falta agregar manualmente dependencias de Maps/Location:
    // los plugins de Flutter (google_maps_flutter, geolocator) traen lo necesario en Android.
}
