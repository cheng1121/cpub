import 'dart:io';

import 'package:args/args.dart';
import 'package:cpub/utils.dart';
import 'package:process_run/cmd_run.dart' as shell;

const get = 'get';
const upgrade = 'upgrade';

Future run(ArgResults argResults) async {
  final paths = argResults.rest;

  if (paths.isEmpty) {
    // await stdin.pipe(stdout);
    print('error, run cpub $get or cpub $upgrade');
  } else {
    final cmd = paths.first;
    final list = await Scanning().start(cmd);
    for (var name in list) {
      await shell.run('flutter', ['pub', cmd, name], verbose: true);
    }
  }
}

///扫描文件
class Scanning {
  ///声明set集合
  final modules = <String>{};

  Future<Set<String>> start(String cmd) async {
    final root = localePath();

    await scanning(root, cmd);
    var rootModule = getModuleName(root);
    modules.removeWhere((element) => element == rootModule);
    modules.add(rootModule);
    print('all packages =======$modules');
    return modules;
  }

  Future<void> scanning(String path, String cmd) async {
    final dir = Directory(path);
    if (dir.existsSync()) {
      for (var entity in dir.listSync()) {
        var path = entity.path;

        if (isYaml(path)) {
          ///执行，pub get or update
          final packageName = getModuleName(dir.path);

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
