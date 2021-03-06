import 'package:dart_dependency_builder/pubspecparser.dart';

void main(List<String> arguments) {
  print("Parsing dependencies...");

  var parser = PubspecParser('pubspec.yaml');

  print('');
  
  parser.allDependencies.forEach((dep) => print(dep.name));
}
