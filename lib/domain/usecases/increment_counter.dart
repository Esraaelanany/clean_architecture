import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// حالة الاستخدام لزيادة قيمة العداد
class IncrementCounter {
  final CounterRepository _repository;

  IncrementCounter(this._repository);

  /// تنفيذ حالة الاستخدام لزيادة العداد
  Future<Counter> call() async {
    return await _repository.incrementCounter();
  }
}
