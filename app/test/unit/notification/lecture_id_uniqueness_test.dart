import 'package:flutter_test/flutter_test.dart';
import 'package:uni/model/entities/lecture.dart';

void main() {
  final Lecture lecture1 =
      Lecture('ESOF', 'TP', 1, 2, 'B204', 'AOR', '3LEIC08', 10, 30, 12, 30);
  final Lecture lecture2 =
      Lecture('IA', 'TP', 2, 2, 'B204', 'HLC', '3LEIC08', 8, 30, 10, 30);
  group('Lecture ID Uniqueness', () {
    test('Equal Lecture ID', () {
      expect(lecture1.id, lecture1.id);
    });
    test('Different Lecture ID', () {
      expect(lecture1.id, isNot(equals(lecture2.id)));
    });
  });
}
