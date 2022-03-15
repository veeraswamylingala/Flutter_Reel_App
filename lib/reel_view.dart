import 'package:flutter/material.dart';
import 'package:flutter_reel/Model/ReelModel.dart';
import 'package:flutter_reel/Provider/reel_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ReelView extends StatefulWidget {
  @override
  _ReelViewState createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> {
  @override
  void initState() {
    intilazeProviderModel();
    // TODO: implement initState
    super.initState();
  }

  intilazeProviderModel() {
    var reelProvider = Provider.of<ReelProvider>(context, listen: false);
    reelProvider.loadVideo(0);
    reelProvider.loadVideo(1);
    //  reelProvider.setInitialised(true);
  }

  @override
  Widget build(BuildContext context) {
    var reelProvider = Provider.of<ReelProvider>(context, listen: false);
    return Scaffold(
        //  appBar: AppBar(title: Text("")),
        body: Container(
            child: FutureBuilder(
      future: reelProvider.getReelsFunc(context), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              List<ReelModel> reels = snapshot.data;
              return Container(
                child: Consumer<ReelProvider>(
                    builder: (context, reelProvider, child) {
                  return PageView.builder(
                    controller: PageController(
                      initialPage: 0,
                      viewportFraction: 1,
                    ),
                    itemCount: reelProvider.getreels.length,
                    onPageChanged: (index) {
                      index = index % (reelProvider.getreels.length);
                      reelProvider.changeVideo(index);
                    },
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      index = index % (reelProvider.getreels.length);
                      return Container(
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child: videoCard(reelProvider.getreels[index]));
                    },
                  );
                }),
              );
            }
        }
      },
    )));
  }

  Widget videoCard(ReelModel video) {
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller!.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller!),
                  ),
                )),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.black,
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    )),
                  ),
                ),
              ),
        //  video.controller. ?  Center(
        //       child: IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.play_arrow,
        //             size: 50,
        //           ))),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
        // Positioned(

        //     ///  bottom: 5,
        //     child:
        //         VideoProgressIndicator(video.controller!, allowScrubbing: true))
      ],
    );
  }

  Widget VideoDescription(ReelModel reel) {
    return Expanded(
        child: Container(
            height: 120.0,
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '@' + reel.username,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    reel.highlightsTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(children: [
                    Icon(
                      Icons.music_note,
                      size: 15.0,
                      color: Colors.white,
                    ),
                    Text(reel.categoryName,
                        style: TextStyle(color: Colors.white, fontSize: 14.0))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                ])));
  }
}
