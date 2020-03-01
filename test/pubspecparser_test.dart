import 'package:dart_dependency_builder/pubspecparser.dart';
import 'package:test/test.dart';

void main() {
  test('Can read file', () {

    var parser = PubspecParser('pubspec.yaml');

    expect(parser.allDependencies.length, greaterThan(0));
  });

  test ('Only keeps dependencies', () {
    var parser = PubspecParser('pubspec.yaml');

    expect(parser.allDependencies[1].name, 'pedantic');
    expect(parser.allDependencies[2].name, 'test');
  });

  test ('Parse regular dependencies separate from dev dependencies', () {
    var parser = PubspecParser('pubspec.yaml');

    expect(parser.dependencies[0].name,               'intl');
    expect(parser.devDependencies[0].name,            'pedantic');
    expect(parser.devDependencies[1].name,            'test');
    expect(parser.allDependencies.map((d) => d.name), ['intl', 'pedantic', 'test']);
  });

}
