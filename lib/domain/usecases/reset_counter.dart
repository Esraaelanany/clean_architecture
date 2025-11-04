import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// حالة الاستخدام لإعادة تعيين العداد
class ResetCounter {
  final CounterRepository _repository;

  ResetCounter(this._repository);

  /// تنفيذ حالة الاستخدام لإعادة تعيين العداد
  Future<Counter> call() async {
    return await _repository.resetCounter();
  }
}
