class UserService {
  final Box<User> _userBox = Hive.box<User>('users');

  void addUser(User user) {
    _userBox.put(user.id, user);
  }

  List<User> getUsers() {
    return _userBox.values.toList();
  }

  void updateUser(String id, User updatedUser) {
    _userBox.put(id, updatedUser);
  }

  void deleteUser(String id) {
    _userBox.delete(id);
  }
}