import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// حالة الاستخدام للحصول على قيمة العداد
class GetCounter {
  final CounterRepository _repository;

  GetCounter(this._repository);

  /// تنفيذ حالة الاستخدام للحصول على العداد
  Future<Counter> call() async {
    return await _repository.getCounter();
  }
}
