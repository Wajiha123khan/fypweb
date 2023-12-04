// import 'package:pod_player/pod_player.dart';
// import 'package:flutter/material.dart';

// class youtube_video_play_screen extends StatefulWidget {
//   final String Path;
//   const youtube_video_play_screen({Key? key,required this.Path}) : super(key: key);

//   @override
//   State<youtube_video_play_screen> createState() => _youtube_video_play_screenState();
// }

// class _youtube_video_play_screenState extends State<youtube_video_play_screen> {
//    late final PodPlayerController controller;

//   @override
//   void initState() {
//      controller = PodPlayerController(
//     playVideoFrom: PlayVideoFrom.youtube(widget.Path),
//     podPlayerConfig: const PodPlayerConfig(
//       autoPlay: true,
//       isLooping: false,
//       // videoQualityPriority: [720, 360]
//     )
//   )..initialise();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: PodVideoPlayer(controller: controller),
//     );
//   }}