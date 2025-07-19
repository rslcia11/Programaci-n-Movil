import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mi_app_almacenamiento/models/user.dart';

class DatabaseService {
  static const USERS_BOX = 'users_box';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>(USERS_BOX);
  }

  Future<void> saveUser(User user) async {
    final box = Hive.box<User>(USERS_BOX);
    await box.put(user.id, user);
  }

  Future<List<User>> getUsers() async {
    final box = Hive.box<User>(USERS_BOX);
    return box.values.toList();
  }

  Future<void> deleteUser(String id) async {
    final box = Hive.box<User>(USERS_BOX);
    await box.delete(id);
  }
}