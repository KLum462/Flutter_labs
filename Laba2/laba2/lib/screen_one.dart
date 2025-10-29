// <-- МОДИФИКАЦИЯ: Импортируем go_router
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
// Импорты для screen_two и screen_three больше не нужны для навигации
// import 'package:flutter_labs/screen_three.dart';
// import 'package:flutter_labs/screen_two.dart';


class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 1 (GoRouter)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Это главный экран'),
            const SizedBox(height: 20),
            
            // --- ЭТАП 1: Базовая навигация (Закомментировано) ---
            // Этот метод не будет работать, т.к. GoRouter управляет навигацией
            /*
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenTwo(
                      data: 'Привет из Экрана 1',
                    ),
                  ),
                );
              },
              child: const Text('Перейти на Экран 2 (Базовая)'),
            ),
            */
            
            // const SizedBox(height: 20),

            // --- ЭТАП 2: Named routes (Закомментировано) ---
            // Этот метод также не будет работать с GoRouter
            /*
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/screen3', // Имя маршрута
                  arguments: 'Данные из Экрана 1 (Named)',
                );
              },
              child: const Text('Перейти на Экран 3 (Named)'),
            ),
            */
            
            const SizedBox(height: 20),
            
            // --- ЭТАП 3: GoRouter ---
            // <-- МОДИФИКАЦИЯ: Кнопка раскомментирована
            ElevatedButton(
              onPressed: () {
                // <-- МОДИФИКАЦИЯ: Используем context.push()
                // Передаем параметр пути (id: '123')
                // и параметр запроса (search: 'flutter')
                context.push('/screen2/123?search=flutter');
              },
              child: const Text('Перейти на Экран 2 (GoRouter)'),
            ),
          ],
        ),
      ),
    );
  }
}