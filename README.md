# cpub的使用方法

> 2021年12月24日，support null-safety

### 使用方法
##### 添加引用到需要使用注解packages的dev_dependencies中
使用pub

```
cpub: ^0.0.5
```
##### 激活cpub命令行工具
仅使用dart，未使用flutter可以把flutter 前缀改为dart
```
///本地源码激活方式
flutter pub global activate --source path <cpub path>

///激活git仓库中的package
flutter pub global activate --source git <git url>
//or
flutter pub global activate --source -sgit <git url>
///上传到pub.dev后，使用此命令
flutter pub global activate cpub

```

##### 执行命令运行脚本

在项目根目录下执行命令
1. cpub get
2. cpub update

- 如果激活后不能直接运行脚本,可以尝试以下方法
```shell
 flutter pub global run cpub get
```
- 提示.pub-cache/bin未添加到PATH中时，需要添加如下内容到环境变量（mac 下）
```shell
  export PATH="$PATH":"$HOME/flutter/sdk/flutter/.pub-cache/bin"
```

- 配置脚本从命令行直接运行; `pubspec.yaml` 中添加如下内容：
```yaml
name: cpub

executables:
  cpub:

```
##### 停用package
```shell
flutter pub global deactivate <package>
```

##### 列出激活的package
```shell
flutter pub global list
```

