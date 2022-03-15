import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reel/Model/ReelModel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ReelProvider extends ChangeNotifier {
//VARIABLES
  List<ReelModel> reels = [];
  int prevVideo = 0;
  int actualScreen = 0;

  //GETTER
  List<ReelModel> get getreels => reels;

//Get Reels------------------------------------------------------
  Future<List<ReelModel>?> getReelsFunc(BuildContext context) async {
    var response = await http.get(
      Uri.parse('https://devhscapi2.hotshotsconnections.us/api/highlights/'),
    );
    //onSuceess
    if (response.statusCode == 200) {
      reels.clear();
      List data = jsonDecode(response.body);
      try {
        data.forEach((reel) {
          reels.add(ReelModel.fromJson(reel));
        });
      } catch (err) {}

      load();
      notifyListeners();
      return getreels;
    }
    //onFailure
    else {
      notifyListeners();
      return null;
    }
  }

  void load() async {
    await reels[0].loadController();
    reels[0].controller!.play();
    notifyListeners();
  }

  //Load Video--------------------------
  void loadVideo(int index) async {
    if (reels.length > index) {
      await reels[index].loadController();
      reels[index].controller?.play();

      notifyListeners();
    }
  }

  //change Video--------------------------
  changeVideo(index) async {
    if (reels[prevVideo].controller != null)
      reels[prevVideo].controller!.pause();

    if (reels[index].controller == null) {
      await reels[index].loadController();
    }
    reels[index].controller!.play();
    prevVideo = index;
    if (prevVideo + 1 < reels.length) {
      await reels[prevVideo + 1].loadController();
    }
    notifyListeners();

    print(index);
  }
}
