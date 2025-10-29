import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    
    // --- ЭТАП 2: Named routes ---
    // Получаем данные, переданные через arguments
    final String data = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Это Экран 3'),
            const SizedBox(height: 20),
            
            // Отображаем полученные данные
            Text('Данные (Этап 2): $data'),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Возвращаемся назад
                Navigator.pop(context);
              },
              child: const Text('Вернуться назад'),
            ),
          ],
        ),
      ),
    );
  }
}