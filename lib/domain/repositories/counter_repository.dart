import '../entities/counter.dart';

/// واجهة مستودع العداد - تحدد العمليات المطلوبة للتعامل مع بيانات العداد
abstract class CounterRepository {
  /// الحصول على قيمة العداد الحالية
  Future<Counter> getCounter();

  /// حفظ قيمة العداد
  Future<void> saveCounter(Counter counter);

  /// زيادة قيمة العداد بمقدار 1
  Future<Counter> incrementCounter();

  /// تقليل قيمة العداد بمقدار 1
  Future<Counter> decrementCounter();

  /// إعادة تعيين العداد إلى الصفر
  Future<Counter> resetCounter();
}
