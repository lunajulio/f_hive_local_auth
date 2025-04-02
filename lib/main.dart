import 'package:f_local_auth_hive_template/data/models/user_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'data/datasources/i_local_auth_source.dart';
import 'data/repositories/auth_repo.dart';
import 'domain/repositories/i_auth_repo.dart';
import 'domain/use_case/auth_use_case.dart';
import 'ui/controllers/auth_controller.dart';
import 'ui/my_app.dart';
import 'data/datasources/hive/hive_source.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _openBox() async {
  Hive.init('./');
  await Hive.initFlutter();
  Hive.registerAdapter(UserDbAdapter());
  await Hive.openBox('userDb');
  logInfo("Box opened userDb ${await Hive.boxExists('userDb')}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));
  await _openBox();
  //TODO: change the ILocalAuthSource to one using HIVE
  // Get.put<ILocalAuthSource>(SharedPrefLocalAuthSource());
  Get.put<ILocalAuthSource>(HiveSource());
  Get.put<IAuthRepo>(AuthRepo(Get.find()));
  Get.put(AuthUseCase(Get.find()));
  Get.put(AuthController(Get.find()));
  runApp(const MyApp());
}
