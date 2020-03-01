import 'dart:io';

class PubspecParser {
  var RootLevelBlock = RegExp(r'^\w*:');
  var FirstLevelDependencyName = RegExp(r'\w*(?=:.*\d+\.\d+\.\d+)');
  var currentYamlSection = '';

  String filename;
  List<String> _dependencies = [];
  List<String> _devDependencies = [];

  List<String> get allDependencies => _dependencies + _devDependencies;
  List<String> get dependencies => _dependencies;
  List<String> get devDependencies => _devDependencies;
  
  PubspecParser(this.filename){
    var f = File(filename);

    f.readAsLinesSync().forEach(_parseLine);
  }

  void _parseLine(String line) {
    if (RootLevelBlock.hasMatch(line)){
      currentYamlSection = line;
    }
    else if (currentYamlSection == 'dependencies:' && FirstLevelDependencyName.hasMatch(line)){
      _dependencies.add(FirstLevelDependencyName.firstMatch(line).group(0));
    }
    else if (currentYamlSection == 'dev_dependencies:' && FirstLevelDependencyName.hasMatch(line)){
      _devDependencies.add(FirstLevelDependencyName.firstMatch(line).group(0));
    }
  }
}