plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")   // Firebase plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.message_board_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.message_board_app"   // MUST match Firebase app id
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Keep debug signing for now (until you add your own)
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}