import 'dart:io';

import 'package:dart_dependency_builder/pubspecparser.dart';
import 'package:test/test.dart';

void main() {
  test('Can read file', () {

    var parser = PubspecParser('pubspec.yaml');

    expect(parser.allDependencies.length, greaterThan(0));
  });

  test ('Only keeps dependencies', () {
    var parser = PubspecParser('pubspec.yaml');

    expect(parser.allDependencies[0], 'pedantic');
    expect(parser.allDependencies[1], 'test');
  });

  test ('Parse regular dependencies separate from dev dependencies', () {
    var parser = PubspecParser('pubspec.yaml');

    expect(parser.dependencies[0],          'intl');
    expect(parser.devDependencies[0],       'pedantic');
    expect(parser.devDependencies[1],       'test');
    expect(parser.allDependencies,          ['intl', 'pedantic', 'test']);
  });

}
