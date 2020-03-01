import 'dart:io';

import 'package:dart_dependency_builder/dependency.dart';

class PubspecParser {
  var RootLevelBlock = RegExp(r'^\w*:');
  var FirstLevelDependencyName = RegExp(r'\w*(?=:.*\d+\.\d+\.\d+)');
  var currentYamlSection = '';

  String filename;
  final List<Dependency> _dependencies = [];
  final List<Dependency> _devDependencies = [];

  List<Dependency> get allDependencies => _dependencies + _devDependencies;
  List<Dependency> get dependencies => _dependencies;
  List<Dependency> get devDependencies => _devDependencies;
  
  PubspecParser(this.filename){
    var f = File(filename);

    f.readAsLinesSync().forEach(_parseLine);
  }

  void _parseLine(String line) {
    if (RootLevelBlock.hasMatch(line)){
      currentYamlSection = line;
    }
    else if (currentYamlSection == 'dependencies:' && FirstLevelDependencyName.hasMatch(line)){
      String name = FirstLevelDependencyName.firstMatch(line).group(0);
      _dependencies.add(Dependency(name));
    }
    else if (currentYamlSection == 'dev_dependencies:' && FirstLevelDependencyName.hasMatch(line)){
      String name = FirstLevelDependencyName.firstMatch(line).group(0);
      _devDependencies.add(Dependency(name));
    }
  }
}