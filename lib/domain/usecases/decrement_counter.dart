import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// حالة الاستخدام لتقليل قيمة العداد
class DecrementCounter {
  final CounterRepository _repository;

  DecrementCounter(this._repository);

  /// تنفيذ حالة الاستخدام لتقليل العداد
  Future<Counter> call() async {
    return await _repository.decrementCounter();
  }
}
