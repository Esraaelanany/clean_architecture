import 'package:equatable/equatable.dart';

/// كيان العداد - يمثل البيانات الأساسية للعداد
class Counter extends Equatable {
  final int value;

  const Counter({
    required this.value,
  });

  /// إنشاء عداد جديد بقيمة محددة
  Counter copyWith({
    int? value,
  }) {
    return Counter(
      value: value ?? this.value,
    );
  }

  /// إنشاء عداد بقيمة صفر
  factory Counter.zero() {
    return const Counter(value: 0);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Counter(value: $value)';
}
