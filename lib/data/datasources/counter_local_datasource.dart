import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/counter.dart';

/// مصدر البيانات المحلي للعداد - يستخدم SharedPreferences لحفظ البيانات
abstract class CounterLocalDataSource {
  Future<Counter> getCounter();
  Future<void> saveCounter(Counter counter);
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences _prefs;
  static const String _counterKey = 'counter_value';

  CounterLocalDataSourceImpl(this._prefs);

  @override
  Future<Counter> getCounter() async {
    try {
      final counterJson = _prefs.getString(_counterKey);
      if (counterJson != null) {
        final counterMap = json.decode(counterJson);
        return Counter(value: counterMap['value'] ?? 0);
      }
      return Counter.zero();
    } catch (e) {
      // في حالة حدوث خطأ، نعيد عداد بقيمة صفر
      return Counter.zero();
    }
  }

  @override
  Future<void> saveCounter(Counter counter) async {
    try {
      final counterMap = {'value': counter.value};
      final counterJson = json.encode(counterMap);
      await _prefs.setString(_counterKey, counterJson);
    } catch (e) {
      throw Exception('فشل في حفظ قيمة العداد: $e');
    }
  }
}
