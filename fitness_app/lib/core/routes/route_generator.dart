import 'package:fitness_app/features/%20sign_up_page/sign_up_page.dart';
import 'package:fitness_app/features/exercise_details/exercises_details_page.dart';
import 'package:fitness_app/features/exercise_details/exercises_start_page.dart';
import 'package:fitness_app/features/exercises/model/exercise_model.dart';
import 'package:fitness_app/features/exercises/page/exercises_page.dart';
import 'package:fitness_app/features/initial_page/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/quotes/presentation/bloc/quotes_bloc.dart';
import 'package:fitness_app/features/quotes/presentation/bloc/quotes_event.dart';
import 'package:fitness_app/features/quotes/quotes_injection_container.dart'
    as quotes_sl;

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.exercisesDetailsPage:
        return MaterialPageRoute(builder: (_) {
          final Map arguments = settings.arguments as Map;
          final ExerciseModel exerciseModel = arguments['exerciseModel'];
          return ExercisesDetailsPage(exerciseModel: exerciseModel);
        });
      case AppRoutes.exercisesStartPage:
        return MaterialPageRoute(builder: (_) {
          final Map arguments = settings.arguments as Map;
          final ExerciseModel exerciseModel = arguments['exerciseModel'];
          return BlocProvider<QuotesBloc>(
              create: (context) =>
                  quotes_sl.quotesSl<QuotesBloc>()..add(SeriesEvent()),
              child: ExercisesStartPage(exerciseModel: exerciseModel));
        });
      case AppRoutes.initialPage:
        return MaterialPageRoute(builder: (_) {
          return const InitialPage();
        });
      case AppRoutes.signUpPage:
        return MaterialPageRoute(builder: (_) {
          return const SignUpPage();
        });
      case AppRoutes.exercisesPage:
        return MaterialPageRoute(builder: (_) {
          return ExercisesPage();
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
