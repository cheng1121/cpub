import 'package:args/args.dart';
import 'package:cpub/cpub.dart' as cpub;


void main(List<String> arguments) {
  try{
    final parser = ArgParser()
      ..addFlag(cpub.get, negatable: false)
      ..addFlag(cpub.upgrade, negatable: false);
    var argResults = parser.parse(arguments);
    cpub.run(argResults);
  }catch(e){
    print('error, run cpub ${cpub.get} or cpub ${cpub.upgrade}');
  }
}
