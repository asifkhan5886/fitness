import 'package:fitness_app/core/local_hive/pref_box.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (GetIt.I.get<PrefBox>().userPayload.name == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.signUpPage, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.exercisesPage, (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Center(
            child: FlutterLogo(
          size: 200,
        )),
      ),
    );
  }
}
