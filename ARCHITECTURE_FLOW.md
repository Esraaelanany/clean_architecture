# تدفق البيانات في Clean Architecture

## 📊 مخطط تدفق البيانات

```
User Interaction (UI)
        ↓
   CounterEvent
        ↓
    CounterBloc
        ↓
   Use Cases
        ↓
   Repository Interface
        ↓
   Repository Implementation
        ↓
   Data Source
        ↓
   Local Storage (SharedPreferences)
```

## 🔄 تفصيل التدفق

### 1. بداية التفاعل
- المستخدم يضغط على زر (مثل زر الزيادة)
- يتم إرسال `IncrementCounter` event إلى BLoC

### 2. معالجة الحدث في BLoC
```dart
// في CounterBloc
on<IncrementCounter>(_onIncrementCounter);
```

### 3. استدعاء Use Case
```dart
// في _onIncrementCounter
final counter = await _incrementCounter();
```

### 4. تنفيذ Use Case
```dart
// في IncrementCounter Use Case
Future<Counter> call() async {
  return await _repository.incrementCounter();
}
```

### 5. استدعاء Repository
```dart
// في CounterRepositoryImpl
Future<Counter> incrementCounter() async {
  final currentCounter = await _localDataSource.getCounter();
  final newCounter = currentCounter.copyWith(value: currentCounter.value + 1);
  await _localDataSource.saveCounter(newCounter);
  return newCounter;
}
```

### 6. الوصول إلى Data Source
```dart
// في CounterLocalDataSourceImpl
Future<void> saveCounter(Counter counter) async {
  final counterMap = {'value': counter.value};
  final counterJson = json.encode(counterMap);
  await _prefs.setString(_counterKey, counterJson);
}
```

### 7. حفظ البيانات
- البيانات تُحفظ في SharedPreferences
- يتم إرجاع النتيجة عبر الطبقات

### 8. تحديث الواجهة
- BLoC يرسل `CounterLoaded` state جديد
- UI يتم تحديثه تلقائياً

## 🎯 فوائد هذا التدفق

1. **فصل الاهتمامات**: كل طبقة لها مسؤولية محددة
2. **سهولة الاختبار**: يمكن اختبار كل طبقة منفصلة
3. **المرونة**: يمكن تغيير مصدر البيانات دون تأثير على الطبقات الأخرى
4. **القابلية للصيانة**: كود منظم وواضح

## 🔧 مثال عملي

عندما يضغط المستخدم على زر الزيادة:

1. **UI** → يرسل `IncrementCounter` event
2. **BLoC** → يستدعي `IncrementCounter` use case
3. **Use Case** → يستدعي `incrementCounter()` في repository
4. **Repository** → يحصل على القيمة الحالية، يزيدها، يحفظها
5. **Data Source** → يحفظ البيانات في SharedPreferences
6. **BLoC** → يرسل `CounterLoaded` state جديد
7. **UI** → يعرض القيمة الجديدة

هذا التدفق يضمن أن كل طبقة تعمل بشكل مستقل ويمكن اختبارها وتطويرها بشكل منفصل.
