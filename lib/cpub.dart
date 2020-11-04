import 'dart:io';

import 'package:args/args.dart';
import 'package:cpub/utils.dart';
import 'package:process_run/cmd_run.dart' as shell;

const get = 'get';
const update = 'update';

Future run(ArgResults argResults) async {
  final paths = argResults.rest;

  if (paths.isEmpty) {
    // await stdin.pipe(stdout);
    print('input cpub get or cpub update');
  } else {
    final cmd = paths.first;
    Scanning()..start(cmd);
  }
}

///扫描文件
class Scanning {
  var root;

  void start(String cmd) async {
    root = localePath();

    await scanning(root, cmd);
  }

  Future<void> scanning(String path, String cmd) async {
    final dir = Directory(path);
    if (dir.existsSync()) {
      for (var entity in dir.listSync()) {
        var path = entity.path;

        if (isYaml(path)) {
          print('scanning ===$path');
          ///cd到 dir
          await shell.run('cd', [dir.path], verbose: true);

          ///执行，pub get or update
          await shell.run('flutter', ['pub', cmd], verbose: true);

          ///回到root
          await shell.run('cd', [root], verbose: true);
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
