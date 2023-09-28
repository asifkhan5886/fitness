import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/common_widgets/common_circular_progress_indicator.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_ui_helper.dart';
import 'package:fitness_app/features/exercises/model/exercise_model.dart';
import 'package:flutter/material.dart';

class ExercisesDetailsPage extends StatefulWidget {
  final ExerciseModel exerciseModel;

  const ExercisesDetailsPage({super.key, required this.exerciseModel});

  @override
  State<ExercisesDetailsPage> createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends State<ExercisesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar:    Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.exercisesStartPage, arguments: {
                'exerciseModel': widget.exerciseModel,
              }),
              child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                'Start ',
                style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
              ),
                  )),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(widget.exerciseModel.title ?? ''),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace20,
              CachedNetworkImage(
                imageUrl: widget.exerciseModel.img ?? '',
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(15),
                  child: CommonCircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.exerciseModel.desc ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              verticalSpace20,
            ],
          ),
        ),
      ),
    );
  }
}
