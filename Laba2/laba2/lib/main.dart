import 'package:flutter/material.dart';
import 'package:laba2/screen_one.dart';
import 'package:laba2/screen_three.dart';
import 'package:laba2/screen_two.dart';
// Импортируем GoRouter
import 'package:go_router/go_router.dart';

// --- ЭТАП 3: GoRouter ---
// 1. Определяем конфигурацию маршрутизатора
final GoRouter _router = GoRouter(
  // initialLocation: '/', // Стартовый маршрут
  routes: <RouteBase>[
    // Маршрут для ScreenOne
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ScreenOne();
      },
      routes: <RouteBase>[
        // Вложенный маршрут для ScreenTwo
        // Используем параметры пути :id
        GoRoute(
          path: 'screen2/:id', // например, /screen2/123
          builder: (BuildContext context, GoRouterState state) {
            // Получаем параметр :id
            final String id = state.pathParameters['id']!;
            // Получаем параметр запроса ?search=...
            final String? searchQuery = state.uri.queryParameters['search'];
            
            // Раскомментируй конструктор в screen_two.dart
            return ScreenTwo(id: id, searchQuery: searchQuery);
          },
        ),
        // Маршрут для ScreenThree
        GoRoute(
          path: 'screen3',
          builder: (BuildContext context, GoRouterState state) {
            // Получаем данные через 'extra' (безопаснее, чем arguments)
            final String data = state.extra as String;
            
            // Тебе нужно будет модифицировать screen_three.dart,
            // чтобы он принимал 'data' через конструктор, а не ModalRoute
            return const ScreenThree(); // Упрощенный пример
          },
        ),
      ],
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Используем MaterialApp.router
    return MaterialApp.router(
      title: 'Flutter Lab 2 (GoRouter)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // 3. Подключаем конфигурацию роутера
      routerConfig: _router,
    );
  }
}