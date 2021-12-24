import 'dart:io';

import 'package:args/args.dart';
import 'package:cpub/utils.dart';
import 'package:process_run/cmd_run.dart' as shell;

const String get = 'get';
const String upgrade = 'upgrade';

Future<void> run(ArgResults argResults) async {
  final paths = argResults.rest;

  if (paths.isEmpty) {
    // await stdin.pipe(stdout);
    print('error, run cpub $get or cpub $upgrade');
  } else {
    final cmd = paths.first;
    final Set<String> list = await Scanning().start(cmd);
    for (String name in list) {
      await shell.runExecutableArguments('flutter', ['pub', cmd, name],
          verbose: true);
    }
  }
}

///扫描文件
class Scanning {
  ///声明set集合
  final Set<String> modules = <String>{};

  Future<Set<String>> start(String cmd) async {
    final String root = localePath();

    await scanning(root, cmd);
    var rootModule = getModuleName(root);
    modules.removeWhere((element) => element == rootModule);
    modules.add(rootModule);
    print('all packages =======$modules');
    return modules;
  }

  Future<void> scanning(String path, String cmd) async {
    final Directory dir = Directory(path);
    if (dir.existsSync()) {
      for (FileSystemEntity entity in dir.listSync()) {
        var path = entity.path;

        if (isYaml(path)) {
          ///执行，pub get or update
          final String packageName = getModuleName(dir.path);

          modules.add(packageName);
        } else {
          ///目录
          if (!path.contains('.')) {
            await scanning(path, cmd);
          }
        }
      }
    }
  }
}
