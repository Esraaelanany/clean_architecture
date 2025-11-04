import 'package:equatable/equatable.dart';
import '../../domain/entities/counter.dart';

/// حالات العداد - تحدد جميع الحالات الممكنة للعداد
abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية
class CounterInitial extends CounterState {
  const CounterInitial();
}

/// حالة التحميل
class CounterLoading extends CounterState {
  const CounterLoading();
}

/// حالة النجاح مع بيانات العداد
class CounterLoaded extends CounterState {
  final Counter counter;

  const CounterLoaded(this.counter);

  @override
  List<Object?> get props => [counter];
}

/// حالة الخطأ
class CounterError extends CounterState {
  final String message;

  const CounterError(this.message);

  @override
  List<Object?> get props => [message];
}
