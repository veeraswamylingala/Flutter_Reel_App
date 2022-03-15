// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:video_player/video_player.dart';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class ReelModel {
  String profilePic;
  String firebaseId;
  String status;
  int id;
  int userId;
  String username;
  String videoPath;
  String highlightsTitle;
  String highlightsThumnail;
  String categoryName;
  int commentryId;
  int hscMusicId;
  int likes;
  int disLikes;
  int hot;
  int comments;
  String commentry;
  String isPublic;
  dynamic invitationId;
  String createdAt;
  String updatedAt;

  VideoPlayerController? controller;

  ReelModel({
    required this.profilePic,
    required this.firebaseId,
    required this.status,
    required this.id,
    required this.userId,
    required this.username,
    required this.videoPath,
    required this.highlightsTitle,
    required this.highlightsThumnail,
    required this.categoryName,
    required this.commentryId,
    required this.hscMusicId,
    required this.likes,
    required this.disLikes,
    required this.hot,
    required this.comments,
    required this.commentry,
    required this.isPublic,
    required this.invitationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) => ReelModel(
        profilePic: json["Profile_Pic"],
        firebaseId: json["firebase_id"],
        status: json["Status"],
        id: json["Id"],
        userId: json["User_Id"],
        username: json["Username"],
        videoPath: json["Video_Path"],
        highlightsTitle: json["highlights_title"],
        highlightsThumnail: json["Highlights_Thumnail"],
        categoryName: json["category_name"],
        commentryId: json["commentry_id"],
        hscMusicId: json["hsc_music_id"],
        likes: json["Likes"],
        disLikes: json["DisLikes"],
        hot: json["Hot"],
        comments: json["Comments"],
        commentry: json["Commentry"],
        isPublic: json["is_public"],
        invitationId: json["invitation_id"],
        createdAt: json["Created_at"],
        updatedAt: json["Updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "Profile_Pic": profilePic,
        "firebase_id": firebaseId,
        "Status": status,
        "Id": id,
        "User_Id": userId,
        "Username": username,
        "Video_Path": videoPath,
        "highlights_title": highlightsTitle,
        "Highlights_Thumnail": highlightsThumnail,
        "category_name": categoryName,
        "commentry_id": commentryId,
        "hsc_music_id": hscMusicId,
        "Likes": likes,
        "DisLikes": disLikes,
        "Hot": hot,
        "Comments": comments,
        "Commentry": commentry,
        "is_public": isPublic,
        "invitation_id": invitationId,
        "Created_at": createdAt,
        "Updated_at": updatedAt,
      };

  Future<Null> loadController() async {
    controller = VideoPlayerController.network(videoPath);
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
