// Импортируем базовую библиотеку Flutter
import 'package:flutter/material.dart';

// Главная функция, с которой начинается выполнение приложения
void main() {
  // Запускаем наше приложение, передавая ему главный виджет (MyApp)
  runApp(const MyApp());
}

// Главный виджет приложения (корневой)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab 1',
      // Убираем баннер "Debug"
      debugShowCheckedModeBanner: false,
   
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

// Наш главный экран - Профиль пользователя
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold - это основа для экрана, дает нам AppBar, Body и т.д.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
          child: Column(
    
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
        
            const CircleAvatar(
         
              radius: 80.0,
         
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwQgPyp5-xEMhwOw144qRlzJ5Am4QbgTccJw&s',
              ),
     
              backgroundColor: Colors.white24,
            ),
            
            // Добавим отступ
            const SizedBox(height: 20.0),
            const Text(
              'Клим Санько',
              style: TextStyle(
              
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            // Отступ
            const SizedBox(height: 8.0),

        
            Text(
              'Директор-Flutterа',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[400],
              ),
            ),
            
            // Отступ
            const SizedBox(height: 24.0),

      
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
                // border - ОБЯЗАТЕЛЬНЫЙ ЭЛЕМЕНТ
                border: Border.all(
                  color: Colors.grey[800]!,
                  width: 1.0,
                ),
              ),
              child: const Row(
                // Равномерно распределяем статистику
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Вспомогательный виджет для статистики
                  _StatColumn(title: 'Проекты', value: '15'),
                  _StatColumn(title: 'Подписчики', value: '1.2M'),
                  _StatColumn(title: 'Рейтинг', value: '4.8'),
                ],
              ),
            ),

            // Отступ
            const SizedBox(height: 24.0),
            
            // 6. Row с кнопками - ОБЯЗАТЕЛЬНЫЙ ЭЛЕМЕНТ
            // Горизонтальное расположение кнопок
            Row(
 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                // 7. Кнопка с onPressed - ОБЯЗАТЕЛЬНЫЙ ЭЛЕМЕНT
                ElevatedButton(
                  // onPressed - ОБЯЗАТЕЛЬНЫЙ ЭЛЕМЕНТ
                  onPressed: () {
                    // Вывод в консоль по нажатию
                    print('Нажата кнопка "Подписаться"');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Подписаться'),
                ),

                // Вторая кнопка для примера
                OutlinedButton(
                  onPressed: () {
                    print('Нажата кнопка "Сообщение"');
                  },
                  child: const Text('Сообщение'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class _StatColumn extends StatelessWidget {
  final String title;
  final String value;

  const _StatColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      // Выравниваем текст по центру
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}