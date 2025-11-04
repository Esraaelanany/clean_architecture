import 'package:equatable/equatable.dart';

/// أحداث العداد - تحدد جميع الأحداث التي يمكن أن تحدث في العداد
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

/// حدث تحميل العداد
class LoadCounter extends CounterEvent {
  const LoadCounter();
}

/// حدث زيادة العداد
class IncrementCounter extends CounterEvent {
  const IncrementCounter();
}

/// حدث تقليل العداد
class DecrementCounter extends CounterEvent {
  const DecrementCounter();
}

/// حدث إعادة تعيين العداد
class ResetCounter extends CounterEvent {
  const ResetCounter();
}
