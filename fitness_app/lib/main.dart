import 'dart:io';
import 'package:fitness_app/core/local_hive/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'features/quotes/quotes_injection_container.dart' as quotes_sl;
import 'package:hive_flutter/adapters.dart';
import 'package:fitness_app/core/injection_dir/injection.dart' as di;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await quotes_sl.init();

  HttpOverrides.global = MyHttpOverrides();
  // Initialize hive
  await Hive.initFlutter();
  await di.configureDependencies();
  Hive.registerAdapter(UserDetailsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String getInitialPage() => AppRoutes.initialPage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App Project',
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialPage(),
      onGenerateRoute: (setting) {
        return RouteGenerator.generateRoutes(setting);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}



