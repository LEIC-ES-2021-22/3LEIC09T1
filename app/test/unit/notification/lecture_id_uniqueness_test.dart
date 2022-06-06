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
    test('Different Subject changes ID', () {
      final Lecture lecture2WithDiferentSubject =
      Lecture('COMP', 'TP', 2, 2, 'B204', 'HLC', '3LEIC08', 8, 30, 10, 30);
      expect(lecture2.id, isNot(equals(lecture2WithDiferentSubject)));
    });
    test('Different TypeClass changes ID', () {
      final Lecture lecture2TypeClassChangesId =
      Lecture('IA', 'T', 2, 2, 'B204', 'HLC', '3LEIC08', 8, 30, 10, 30);
      expect(lecture2.id, isNot(equals(lecture2TypeClassChangesId)));
    });
    test('Different Day changes ID', () {
      final Lecture lecture2DayChangesId =
      Lecture('IA', 'TP', 3, 2, 'B204', 'HLC', '3LEIC08', 8, 30, 10, 30);
      expect(lecture2.id, isNot(equals(lecture2DayChangesId)));
    });
    test('Different Start Time changes ID', () {
      final Lecture lecture2StartTimeChangesId =
      Lecture('IA', 'TP', 2, 2, 'B204', 'HLC', '3LEIC08', 9, 30, 10, 30);
      expect(lecture2.id, isNot(equals(lecture2StartTimeChangesId)));
    });
    test('Different Room changes ID', () {
      final Lecture lecture2RoomChangesId =
      Lecture('IA', 'TP', 2, 2, 'B205', 'HLC', '3LEIC08', 8, 30, 10, 30);
      expect(lecture2.id, isNot(equals(lecture2RoomChangesId)));
    });
  });
}
