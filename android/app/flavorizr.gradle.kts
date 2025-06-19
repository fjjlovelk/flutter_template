import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("env_development") {
            dimension = "flavor-type"
            applicationId = "com.stxx.flutter_template.development"
            resValue(type = "string", name = "app_name", value = "flutter_template（开发）")
        }
        create("env_test") {
            dimension = "flavor-type"
            applicationId = "com.stxx.flutter_template.test"
            resValue(type = "string", name = "app_name", value = "flutter_template（测试）")
        }
        create("env_production") {
            dimension = "flavor-type"
            applicationId = "com.stxx.flutter_template"
            resValue(type = "string", name = "app_name", value = "flutter_template")
        }
    }
}