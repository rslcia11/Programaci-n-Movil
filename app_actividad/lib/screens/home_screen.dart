class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("App de Usuarios"),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              userService.addUser(User(
                id: Uuid().v4(),
                name: "Juan Pérez",
                email: "juan@example.com",
              ));
            },
            child: Text("Agregar Usuario"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userService.getUsers().length,
              itemBuilder: (ctx, i) {
                final user = userService.getUsers()[i];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}