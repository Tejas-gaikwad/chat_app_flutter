import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String url;
  const VideoApp({super.key, required this.url});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);

    _chewieController = ChewieController(
      videoPlayerController: _controller,

      aspectRatio:
          16 / 9, // Initial aspect ratio (you can change it dynamically).
      autoInitialize: true,
      controlsSafeAreaMinimum: EdgeInsets.all(14),

      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      looping: false, // Set to true if you want the video to loop.
      autoPlay:
          false, // Set to true if you want the video to play automatically.
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );

    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        // Get the video's actual aspect ratio.
        final videoWidth = _controller.value.size?.width ?? 1;
        final videoHeight = _controller.value.size?.height ?? 1;
        final videoAspectRatio = videoWidth / videoHeight;

        // Set the Chewie aspect ratio dynamically.
        _chewieController = _chewieController.copyWith(
          aspectRatio: videoAspectRatio,
        );
      }

      if (!_controller.value.isPlaying && !_controller.value.isBuffering) {
        // Video has ended, implement any desired behavior here.
      }
    });

    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
