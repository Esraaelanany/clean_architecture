import 'package:flutter/material.dart';
import '../widgets/counter_display.dart';
import '../widgets/counter_buttons.dart';

/// صفحة العداد الرئيسية
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عداد Clean Architecture'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اضغط على الأزرار لتغيير قيمة العداد',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CounterDisplay(),
            SizedBox(height: 30),
            CounterButtons(),
          ],
        ),
      ),
    );
  }
}
