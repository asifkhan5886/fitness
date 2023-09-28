import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:fitness_app/core/common_widgets/countdown_progress_indicator.dart';
import 'package:fitness_app/core/local_hive/pref_box.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_ui_helper.dart';
import 'package:fitness_app/core/utils/strings.dart';
import 'package:fitness_app/features/exercises/model/exercise_model.dart';
import 'package:fitness_app/features/quotes/presentation/pages/quotes_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ExercisesStartPage extends StatefulWidget {
  final ExerciseModel exerciseModel;
  const ExercisesStartPage({super.key,required this.exerciseModel});

  @override
  State<ExercisesStartPage> createState() => _ExercisesStartPageState();
}

class _ExercisesStartPageState extends State<ExercisesStartPage> {

  final _controller = CountDownController();
  final _assetsAudioPlayer = AssetsAudioPlayer();
  bool isAudioPlay=true;

  @override
  void initState() {
   // _controller.pause();
    isAudioPlay=GetIt.I.get<PrefBox>().isAudioPlay;
    playMusic();
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void playMusic() async {
    _assetsAudioPlayer.open(
      Audio(Strings.backgroundMusic),
      autoStart: false,
      showNotification: false, loopMode: LoopMode.single
    ).then((value) {
      if(isAudioPlay==true){
        _assetsAudioPlayer.play();
      }
    });


    //_assetsAudioPlayer.play();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:  Text(widget.exerciseModel.title??''),
          actions:  [
            IconButton(onPressed: (){

              setState(() {
                isAudioPlay=!isAudioPlay;
                if(isAudioPlay){
                  _assetsAudioPlayer.play();
                }else{
                  _assetsAudioPlayer.pause();
                }
                GetIt.I.get<PrefBox>().isAudioPlay=isAudioPlay;
              });
            }, icon: Icon(isAudioPlay==false?Icons.music_off_outlined:Icons.music_note_outlined,color: Colors.white,))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace20,
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              child: Center(
                child: CountDownProgressIndicator(
                  controller: _controller,
                  valueColor: Colors.red,
                  backgroundColor: Colors.blue,
                  initialPosition: 0,
                  duration: widget.exerciseModel.time??0,
                  timeFormatter: (seconds) {
                    return Duration(seconds: seconds)
                        .toString()
                        .split('.')[0]
                        .padLeft(8, '0');
                  },
                  text: 'hh:mm:ss',
                  onComplete: (){
                    _assetsAudioPlayer.stop();
                    GetIt.I.get<PrefBox>().setItemIds=["${widget.exerciseModel.id}"];
                    print( GetIt.I.get<PrefBox>().getItemIds);
                    List<String> tempList=GetIt.I.get<PrefBox>().getItemIds;
                    final result = tempList.toSet().toList();
                    GetIt.I.get<PrefBox>().setItemIds=result;
                    print( GetIt.I.get<PrefBox>().getItemIds);
                    showDialog();
                  },
                ),
              ),
            ),
            verticalSpace20,
             Container(
               alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Quotes",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.black,
                ),
              ),
            ),
            verticalSpaceSmall,
            Expanded(child: quotesListWidget()),
          ],
        ),
      ),
    );
  }

  void showDialog(){
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                child: CongratulationsDialog(),
              ));
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });

  }

  Widget quotesListWidget() {
    return const QuotesPage();
  }
}


class CongratulationsDialog extends StatefulWidget {
  @override
  State<CongratulationsDialog> createState() => _CongratulationsDialogState();
}

class _CongratulationsDialogState extends State<CongratulationsDialog> {
  final ConfettiController _controller =
  ConfettiController(duration: const Duration(seconds: 5));

@override
  void initState() {
  _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Text('Congratulations!'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Exercise completed successfully!'),
                SizedBox(height: 20),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.exercisesPage, (Route<dynamic> route) => false);
                },
                child: const Text('Okey'),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controller,
              maximumSize: const Size(30, 20),
              blastDirectionality: BlastDirectionality
                  .explosive, // Change this to control the direction of the confetti explosion
              shouldLoop: false, // Set to true for continuous animation
              colors: const [Colors.green, Colors.blue, Colors.pink,Colors.green, Colors.black54, Colors.red,Colors.amber, Colors.indigo, Colors.pinkAccent,], // Customize confetti colors
            ),
          ),
        ],
      ),
    );
  }
}
