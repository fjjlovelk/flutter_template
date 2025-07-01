# com.stxx.flutter_template

flutter项目模板

### 1.使用前请先按照 [官网-安装和配置环境](https://docs.flutter.cn/get-started/install)

- 推荐使用 AndroidStudio 作为开发工具
- 同时安装 flutter、getx、FlutterAssetsGenerator插件
- 配置清华大学镜像 [flutter 镜像](https://docs.flutter.cn/community/china/)
- 将下面的命令添加到你的 AndroidStudio 启动配置中

### 2.命令

- 本项目使用 [fvm](https://fvm.app/) 管理 `flutter` 版本，安装依赖前请先安装 `fvm`，所有 `flutter` 相关命令都被 `fvm flutter` 替代

```shell
# 注意运行后的warning提示：设置环境变量！
dart pub global activate fvm
```

- 安装 `flutter` 对应版本

```shell
fvm install
```

- 安装依赖，其他 `flutter` 命令请看 [官网-Flutter 命令行文档](https://docs.flutter.cn/reference/flutter-cli)

```shell
fvm flutter pub get
```

- debug 模式

```shell
# 替换 env_development 为你想要运行的环境，支持的环境请见 flavorizr.yaml
fvm flutter run --flavor env_development -t lib/main.dart
```

- release 模式

```shell
# 替换 env_development 为你想要运行的环境，支持的环境请见 flavorizr.yaml
fvm flutter run --release --flavor env_development -t lib/main.dart
```

- android
  打包，打包配置（图标、签名等）请看 [官网-构建和发布为 Android 应用](https://docs.flutter.cn/deployment/android)

```shell
# 替换 env_test 为你想要运行的环境，支持的环境请见 flavorizr.yaml
fvm flutter build apk --flavor env_test -t lib/main.dart
```

- ios
  打包，打包配置（图标、签名等）请看 [官网-构建和发布为 iOS 应用](https://docs.flutter.cn/deployment/ios)

```shell
# 替换 env_test 为你想要运行的环境，支持的环境请见 flavorizr.yaml
fvm flutter build ipa --flavor env_test -t lib/main.dart
```

- 清除缓存

```shell
fvm flutter clean
```

### 3.依赖

- 多环境配置 [flutter_flavorizr](https://pub-web.flutter-io.cn/packages/flutter_flavorizr)
- 组件库 [tdesign_flutter](https://tdesign.tencent.com/flutter/)
- 路由、状态管理 [getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md)
- 网络请求 [dio](https://github.com/cfug/dio/blob/main/dio/README-ZH.md)
- model生成器 [freezed](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md)
- 其他依赖详见 [pubspec.yaml](pubspec.yaml)

### 4.注意点

- 修改 [flavorizr.yaml](flavorizr.yaml) 文件后，请重新运行以下命令，否则修改不生效，同时请备份 main.dart、app.dart 以防被覆盖

```shell
fvm flutter pub run flutter_flavorizr
```

- 添加或修改model后，请运行以下命令

```shell
fvm dart run build_runner build
```

- 推荐使用 AndroidStudio 插件 [FlutterAssetsGenerator](https://juejin.cn/post/6898542896274735117) 来自动生成assets静态资源，插件配置
    - file path 为 `config`
    - file name 为 `assets_config`
    - class name 为 `AssetsConfig`
- json to dart model 推荐使用这个 [网站](https://dartj.web.app/)
- 类、方法引入时，全部使用相对路径，避免出现项目名称