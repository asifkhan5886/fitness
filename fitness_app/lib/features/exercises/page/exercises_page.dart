import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/common_widgets/common_circular_progress_indicator.dart';
import 'package:fitness_app/core/local_hive/pref_box.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/exercise_model.dart';

class ExercisesPage extends StatefulWidget {
  ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<ExerciseModel> exercises = [
    ExerciseModel(
        id: "1",
        time: 200,
        img: "https://homeworkouts.org/wp-content/uploads/anim-push-ups.gif",
        title: "Push up",
        desc: """
        Begin in a high plank position on your hands and feet. Your palms should be flat on the ground about shoulder-width apart. You should be on your toes with the feet hip-distance apart. Your gaze should be down at the ground in order to keep the neck in a neutral position.

Draw your belly button toward your spine to engage the core muscles and maintain a straight line from head-to-toe.

Now lower your body toward the floor while keeping the neck and low back in a neutral position. The elbows will bend as the upper arms flare out to about a 45-degree angle away from the torso. Lower down until your chest touches the floor.

Then, press back up as you straighten your arms completely and return to the high plank position.

Repeat for the desired repetitions.
        
  """),
    ExerciseModel(
        id: "2",
        time: 30,
        img:
            "https://homeworkouts.org/wp-content/uploads/anim-dumbbell-fly.gif",
        title: "Dumbbell fly",
        desc: """
        Begin lying down on your back on a bench with the legs bent and feet planted firmly on the ground. (Note: If your feet don’t touch the ground, place a plate underneath each foot).

Hold dumbbells in your hands near your chest with a neutral grip (palms facing each other). Your shoulder blades should be down and back, squeezing together the entire time.

Press the dumbbells up toward the ceiling as you straighten both arms while keeping the palms facing each other. The dumbbells can be touching at the top. This is the start position.

Lower the dumbbells out to the side in a “T” away from each other. Keep lowering them down toward the ground until you feel a stretch in the chest.

Then, raise the dumbbells back up toward each other to the start position.

Repeat for the desired repetitions.
  """),
    ExerciseModel(
        id: "3",
        time: 300,
        img:
            "https://www.inspireusafoundation.org/wp-content/uploads/2022/11/pull-up.gif",
        title: "Pull up",
        desc: """
        Begin hanging from a pull-up bar with an overhand grip. The body should be in a straight line from head-to-toe with the spine and hips in neutral and the legs straight. You may cross the legs, if desired.

Draw your shoulder blades down away from your ears to engage the lats first.

Now pull your entire body straight up toward the ceiling until your chin is above the bar. The arms will bend as you draw your elbows down toward your rib cage on either side.

Then, slowly lower your body back down to a dead hang as you straighten the arms overhead.

Repeat for the desired repetitions.
  """),
  ];

  @override
  void initState() {
    List<String> tempList=GetIt.I.get<PrefBox>().getItemIds;
    for (var element in exercises) {
      if(tempList.contains(element.id)){
        element.isDone=true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace20,
            Text(
              GetIt.I.get<PrefBox>().userPayload.name ?? '',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Text(
              GetIt.I.get<PrefBox>().userPayload.emailAddress ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            verticalSpaceSmall,
            Text(
              GetIt.I.get<PrefBox>().userPayload.contactPhone ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            verticalSpace20,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Other details',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        "Age: ${GetIt.I.get<PrefBox>().userPayload.age ?? ''}"),
                    Text(
                        "Height: ${GetIt.I.get<PrefBox>().userPayload.height ?? ''}"),
                    Text(
                        "Weight: ${GetIt.I.get<PrefBox>().userPayload.weight ?? ''}"),
                  ],
                ),
              ),
            ),
            verticalSpace20,
            exerciseListWidget(),
          ],
        ),
      ),
    );
  }

  Widget exerciseListWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.exercisesDetailsPage, arguments: {
                'exerciseModel': exercises[index],
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: exercises[index].img ?? '',
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(15),
                        child: CommonCircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 80,
                      width: 80,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Text(exercises[index].title ?? '')),
                            if(exercises[index].isDone==true)
                            Icon(Icons.check_circle,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
