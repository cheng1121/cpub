import 'dart:io';

///获取当前所在目录
String localePath() {
  final envVarMap = Platform.environment;
  return envVarMap['PWD'];
}


bool isYaml(String path) {
  return path.endsWith('.yaml');
}

String getModuleName(String path){
  return path.split('/').last;
}


