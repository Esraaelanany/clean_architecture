import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart' as increment_use_case;
import '../../domain/usecases/decrement_counter.dart' as decrement_use_case;
import '../../domain/usecases/reset_counter.dart' as reset_use_case;
import 'counter_event.dart';
import 'counter_state.dart';

/// BLoC للعداد - يدير منطق التطبيق والحالة
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter _getCounter;
  final increment_use_case.IncrementCounter _incrementCounter;
  final decrement_use_case.DecrementCounter _decrementCounter;
  final reset_use_case.ResetCounter _resetCounter;

  CounterBloc({
    required GetCounter getCounter,
    required increment_use_case.IncrementCounter incrementCounter,
    required decrement_use_case.DecrementCounter decrementCounter,
    required reset_use_case.ResetCounter resetCounter,
  })  : _getCounter = getCounter,
        _incrementCounter = incrementCounter,
        _decrementCounter = decrementCounter,
        _resetCounter = resetCounter,
        super(const CounterInitial()) {
    on<LoadCounter>(_onLoadCounter);
    on<IncrementCounter>(_onIncrementCounter);
    on<DecrementCounter>(_onDecrementCounter);
    on<ResetCounter>(_onResetCounter);
  }

  /// معالج حدث تحميل العداد
  Future<void> _onLoadCounter(LoadCounter event, Emitter<CounterState> emit) async {
    try {
      emit(const CounterLoading());
      final counter = await _getCounter();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError('فشل في تحميل العداد: $e'));
    }
  }

  /// معالج حدث زيادة العداد
  Future<void> _onIncrementCounter(IncrementCounter event, Emitter<CounterState> emit) async {
    try {
      if (state is CounterLoaded) {
        emit(const CounterLoading());
        final counter = await _incrementCounter();
        emit(CounterLoaded(counter));
      }
    } catch (e) {
      emit(CounterError('فشل في زيادة العداد: $e'));
    }
  }

  /// معالج حدث تقليل العداد
  Future<void> _onDecrementCounter(DecrementCounter event, Emitter<CounterState> emit) async {
    try {
      if (state is CounterLoaded) {
        emit(const CounterLoading());
        final counter = await _decrementCounter();
        emit(CounterLoaded(counter));
      }
    } catch (e) {
      emit(CounterError('فشل في تقليل العداد: $e'));
    }
  }

  /// معالج حدث إعادة تعيين العداد
  Future<void> _onResetCounter(ResetCounter event, Emitter<CounterState> emit) async {
    try {
      emit(const CounterLoading());
      final counter = await _resetCounter();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError('فشل في إعادة تعيين العداد: $e'));
    }
  }
}
