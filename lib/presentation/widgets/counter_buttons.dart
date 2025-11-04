import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

/// ويدجت أزرار التحكم في العداد
class CounterButtons extends StatelessWidget {
  const CounterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        final isLoading = state is CounterLoading;
        
        return Column(
          children: [
            // صف الأزرار الرئيسية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر التحميل
                ElevatedButton.icon(
                  onPressed: isLoading ? null : () {
                    context.read<CounterBloc>().add(const LoadCounter());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('تحميل العداد'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                
                // زر إعادة التعيين
                ElevatedButton.icon(
                  onPressed: isLoading ? null : () {
                    context.read<CounterBloc>().add(const ResetCounter());
                  },
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('إعادة تعيين'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // صف أزرار الزيادة والنقصان
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر النقصان
                FloatingActionButton(
                  onPressed: isLoading ? null : () {
                    context.read<CounterBloc>().add(const DecrementCounter());
                  },
                  heroTag: "decrement",
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                
                // زر الزيادة
                FloatingActionButton(
                  onPressed: isLoading ? null : () {
                    context.read<CounterBloc>().add(const IncrementCounter());
                  },
                  heroTag: "increment",
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            
            if (isLoading) ...[
              const SizedBox(height: 20),
              const Text(
                'جاري التحميل...',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ],
          ],
        );
      },
    );
  }
}
