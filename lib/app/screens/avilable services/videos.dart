import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/// Single, unified video screen used by ServicesOverviewScreen.
/// Pass [title] as the AppBar label and [videos] as a list of URLs or asset paths.
class ServiceVideosScreen extends StatelessWidget {
  final List<String> videos;
  final String title;

  const ServiceVideosScreen({
    super.key,
    required this.videos,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.amber,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return VideoCard(videoPath: videos[index]);
          },
        ),
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final String videoPath;

  const VideoCard({super.key, required this.videoPath});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = widget.videoPath.startsWith('http')
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
        : VideoPlayerController.asset(widget.videoPath);

    await _videoPlayerController.initialize();

    if (!mounted) return;

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage,
              style: const TextStyle(color: Colors.white)),
        );
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized;

    return Container(
      height: 250,
      margin: const EdgeInsets.only(bottom: 20),
      child: isReady
          ? Chewie(controller: _chewieController!)
          : const Center(
          child: CircularProgressIndicator(color: Colors.amber)),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}