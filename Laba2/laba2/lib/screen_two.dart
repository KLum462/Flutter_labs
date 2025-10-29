import 'package:flutter/material.dart';
// <-- МОДИФИКАЦИЯ: Импортируем go_router для context.pop()
import 'package:go_router/go_router.dart';

class ScreenTwo extends StatelessWidget {
  
  // --- Старый конструктор (Этап 1) закомментирован ---
  // final String? data;
  // const ScreenTwo({super.key, this.data});
  
  // --- ЭТАП 3: GoRouter ---
  // <-- МОДИФИКАЦИЯ: Новый конструктор
  final String id;
  final String? searchQuery;

  const ScreenTwo({
    super.key,
    required this.id, // 'id' теперь обязательный
    this.searchQuery, // 'searchQuery' опциональный
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 2 (GoRouter)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Это Экран 2'),
            const SizedBox(height: 20),
            
            // --- Отображение данных из Этапа 1 (Закомментировано) ---
            // if (data != null) Text('Данные (Этап 1): $data'),

            // <-- МОДИФИКАЦИЯ: Отображаем данные, полученные из GoRouter
            const Text(
              'Данные (Этап 3: GoRouter)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Параметр пути (id): $id'),
            Text('Параметр запроса (search): ${searchQuery ?? "не найден"}'),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // <-- МОДИФИКАЦИЯ: Используем context.pop()
                context.pop();
              },
              child: const Text('Вернуться назад'),
            ),
          ],
        ),
      ),
    );
  }
}