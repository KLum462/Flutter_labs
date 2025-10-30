import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Ваши учетные данные Supabase
const String supabaseUrl = 'https://auumafsbamxveeifgtst.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF1dW1hZnNiYW14dmVlaWZndHN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE4MDE1MTIsImV4cCI6MjA3NzM3NzUxMn0.0jzn--P9Ybqw2DnJ1hT8vrgwGZX8sMc8z1LMTDw-z2Y';

Future<void> main() async {
  // Обеспечиваем инициализацию биндингов Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация клиента Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());  
}

// Хелпер для быстрого доступа к клиенту
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Lab 3',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProfilesPage(),
    );
  }
}

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  // Контроллеры для полей ввода
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  // Переменная для хранения Future, которое загружает данные
  Future<List<dynamic>>? _profilesFuture;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Метод для выполнения запроса SELECT
  Future<List<dynamic>> _fetchProfiles() async {
    final response = await supabase
        .from('profiles')
        .select()
        .order('created_at', ascending: false); // Сортировка по дате создания
    return response as List<dynamic>;
  }

  // Метод, который инициирует загрузку данных и обновляет состояние
  void _loadProfiles() {
    setState(() {
      _profilesFuture = _fetchProfiles();
    });
  }

  // Метод для выполнения запроса INSERT
  Future<void> _addProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
      return;
    }

    try {
      await supabase.from('profiles').insert({
        'name': name,
        'email': email,
        // 'id' и 'created_at' генерируются базой данных автоматически
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Профиль успешно добавлен!')),
        );
        // Очищаем поля ввода
        _nameController.clear();
        _emailController.clear();
        // Обновляем список после добавления
        _loadProfiles();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при добавлении: $error'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Работа с Supabase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Блок ввода данных ---
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addProfile,
                  child: const Text('Добавить'),
                ),
                ElevatedButton(
                  // Эта кнопка вызывает _loadProfiles для инициации загрузки
                  onPressed: _loadProfiles,
                  child: const Text('Загрузить'),
                ),
              ],
            ),
            const Divider(height: 30),
            
            // --- Блок отображения данных ---
            Expanded(
              child: _buildProfilesList(),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для отображения списка профилей
  Widget _buildProfilesList() {
    // Если Future еще не было инициализировано (кнопка "Загрузить" не нажималась)
    if (_profilesFuture == null) {
      return const Center(
        child: Text('Нажмите "Загрузить", чтобы увидеть данные'),
      );
    }

    // Используем FutureBuilder для обработки асинхронной загрузки
    return FutureBuilder<List<dynamic>>(
      future: _profilesFuture,
      builder: (context, snapshot) {
        // Состояние загрузки
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Состояние ошибки
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        // Состояние успешной загрузки, но список пуст
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Список профилей пуст'));
        }

        // Отображение данных
        final profiles = snapshot.data!;

        return ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profile = profiles[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(profile['name']?.toString() ?? 'N/A'),
                subtitle: Text(profile['email']?.toString() ?? 'N/A'),
              ),
            );
          },
        );
      },
    );
  }
}