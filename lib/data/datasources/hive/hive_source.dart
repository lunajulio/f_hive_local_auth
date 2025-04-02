import 'package:hive/hive.dart';
import '../../models/user_db.dart';
import '../../../domain/entities/user.dart';
import '../i_local_auth_source.dart';
import '../shared_prefs/local_preferences.dart';

class HiveSource implements ILocalAuthSource {
  final _sharedPreferences = LocalPreferences();
  final Box _userBox = Hive.box('userDb');

  @override
  Future<String> getLoggedUser() async {
    //TODO: implement getLoggedUser with shared preferences
    return await _sharedPreferences.retrieveData<String>('user') ?? "noUser";
  }

  @override
  Future<User> getUserFromEmail(email) async {
    //TODO: implement getUserFromEmail with HIVE
    final userDb = _userBox.get(email) as UserDb?;
    
    if (userDb != null) {
      return User(email: userDb.email, password: userDb.password);
    }
    
    throw "Usuario no encontrado";
  }

  @override
  Future<bool> isLogged() async {
    //TODO: implement getLoggedUser with shared preferences
     return await _sharedPreferences.retrieveData<bool>('logged') ?? false;
  }

  @override
  Future<void> logout() async {
    //TODO: implement getLoggedUser with shared preferences
    await _sharedPreferences.storeData('logged', false);
  }

  @override
  Future<void> setLoggedIn() async {
    //TODO: implement getLoggedUser with shared preferences
    await _sharedPreferences.storeData('logged', false);
  }

  @override
  Future<void> signup(email, password) async {
    //TODO: implement getLoggedUser with HIVE
    final userDb = UserDb(email: email, password: password);
    await _userBox.put(email, userDb);
  }
}
