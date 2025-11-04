import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_state.dart';

/// ويدجت عرض قيمة العداد
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        if (state is CounterLoading) {
          return const CircularProgressIndicator();
        } else if (state is CounterLoaded) {
          return Column(
            children: [
              const Text(
                'قيمة العداد الحالية:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Text(
                  '${state.counter.value}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          );
        } else if (state is CounterError) {
          return Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'حدث خطأ:',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return const Text(
            'اضغط على "تحميل العداد" للبدء',
            style: TextStyle(fontSize: 16),
          );
        }
      },
    );
  }
}
