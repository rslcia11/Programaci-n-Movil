import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/user.dart';
import 'services/api_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Practice',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> futureUsers;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService.getUsers();
  }

  void _refreshData() {
    setState(() {
      futureUsers = ApiService.getUsers();
    });
  }

  Future<void> _createUser() async {
    try {
      await ApiService.createUser(
        nameController.text,
        emailController.text,
      );
      nameController.clear();
      emailController.clear();
      _refreshData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario creado exitosamente!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica API'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserForm(),
            const SizedBox(height: 20),
            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createUser,
              child: const Text('Crear Usuario'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay datos'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final user = snapshot.data![index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(user.id.toString())),
                title: Text(user.name),
                subtitle: Text(user.email),
              ),
            );
          },
        );
      },
    );
  }
}