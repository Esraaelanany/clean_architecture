import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_datasource.dart';

/// تنفيذ مستودع العداد - يربط بين Domain Layer و Data Layer
class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource _localDataSource;

  CounterRepositoryImpl(this._localDataSource);

  @override
  Future<Counter> getCounter() async {
    try {
      return await _localDataSource.getCounter();
    } catch (e) {
      throw Exception('فشل في الحصول على قيمة العداد: $e');
    }
  }

  @override
  Future<void> saveCounter(Counter counter) async {
    try {
      await _localDataSource.saveCounter(counter);
    } catch (e) {
      throw Exception('فشل في حفظ قيمة العداد: $e');
    }
  }

  @override
  Future<Counter> incrementCounter() async {
    try {
      final currentCounter = await _localDataSource.getCounter();
      final newCounter = currentCounter.copyWith(value: currentCounter.value + 1);
      await _localDataSource.saveCounter(newCounter);
      return newCounter;
    } catch (e) {
      throw Exception('فشل في زيادة قيمة العداد: $e');
    }
  }

  @override
  Future<Counter> decrementCounter() async {
    try {
      final currentCounter = await _localDataSource.getCounter();
      final newCounter = currentCounter.copyWith(value: currentCounter.value - 1);
      await _localDataSource.saveCounter(newCounter);
      return newCounter;
    } catch (e) {
      throw Exception('فشل في تقليل قيمة العداد: $e');
    }
  }

  @override
  Future<Counter> resetCounter() async {
    try {
      final resetCounter = Counter.zero();
      await _localDataSource.saveCounter(resetCounter);
      return resetCounter;
    } catch (e) {
      throw Exception('فشل في إعادة تعيين العداد: $e');
    }
  }
}
