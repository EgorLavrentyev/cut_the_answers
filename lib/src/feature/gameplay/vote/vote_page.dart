import 'package:flutter/material.dart';
import 'package:job_job_game/src/config/colors.dart';
import 'package:job_job_game/src/feature/gameplay/vote/widgets/vote_widget.dart';

import '../../../core/classes/app.dart';
import '../../../core/classes/game.dart';
import '../../../core/func/data_func.dart';
import '../../../core/models/player.dart';
import '../../widgets/overlay_loading/controller.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key, required this.answers}) : super(key: key);

  final List<Map<String, dynamic>> answers;



  @override
  State<VotePage> createState() => _VotePageState();

}


class _VotePageState extends State<VotePage> {


  List<Map<String, MapEntry>> convertAnswers = [];
  int voteCount = 3;


  _convertAnswers() {
    for (var item in widget.answers){
      for (var entry in item.entries) {
        for (var answer in entry.value.entries) {
          convertAnswers.add({item.keys.first: answer});
        }
      }
    }

    convertAnswers.shuffle();
  }

  late var listen;

  @override
  void initState() {
    _convertAnswers();
    var doc = App.database.collection('game').doc(Game.roomId);
    listen = doc.snapshots().listen((event) async {
      Game.players.clear();
      for (var map in event.data()!["players"]) {
        Game.players.add(Player.fromMap(map));
      }
      if (Game.players.every((element) => element.isReady == true)) {

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Container()));
        OverlayLoadingController.remove(context);
        listen.cancel();
      }
    });

    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            OverlayLoadingController.show(context);
            DataFunc.setMeReady(true);
          },),

    body: SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              itemCount: convertAnswers.length,

                itemBuilder: (context, index){
                  return VoteWidget(answer: convertAnswers[index].values.first, nickname: convertAnswers[index].keys.first);
                }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 5,);
            },)));
  }
}




