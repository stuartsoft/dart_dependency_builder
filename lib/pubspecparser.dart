import 'dart:io';

import 'package:dart_dependency_builder/dependency.dart';

class PubspecParser {
  static RegExp RootLevelBlock = RegExp(r'^\w*:');
  static RegExp FirstLevelDependencyName = RegExp(r'\w*(?=:.*\d+\.\d+\.\d+)');
  static RegExp FirstLevelDependencyVersion = RegExp(r'\^*\d+\.\d+\.\d+');
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
      _dependencies.add(extractDependencyFromLine(line));
    }
    else if (currentYamlSection == 'dev_dependencies:' && FirstLevelDependencyName.hasMatch(line)){
      _devDependencies.add(extractDependencyFromLine(line));
    }
  }

  static Dependency extractDependencyFromLine(String line) {
    String name = FirstLevelDependencyName.firstMatch(line).group(0);
    String version = FirstLevelDependencyVersion.firstMatch(line).group(0);
    return Dependency(name, version: version);
  }
}