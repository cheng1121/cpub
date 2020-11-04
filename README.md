# cpub的使用方法

### 使用方法
##### 添加引用到需要使用注解packages的dev_dependencies中
使用pub

```
cpub: ^0.0.2
```
##### 激活cpub命令行工具
```
///github 使用方式  执行完pub get 后，github上的项目存放在 flutter sdk -> .pub-cache ->git -> cpub
pub global activate --source path <cpub path>

///上传到pub.dev后，使用此命令
pub global activate cpub

```
##### 执行命令
在项目根目录下执行命令
1. cpub get
2. cpub update
