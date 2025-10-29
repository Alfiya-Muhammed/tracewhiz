import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class CameraDrawing extends StatefulWidget {
  final File selectedImage;

  const CameraDrawing({super.key, required this.selectedImage});

  @override
  State<CameraDrawing> createState() => _CameraDrawingState();
}

class _CameraDrawingState extends State<CameraDrawing> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  double _opacity = 0.5;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0), // Same as HomeScreen
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFB6C1), // Light Pink
                Color(0xFFFF69B4), // Hot Pink
                Color(0xFFFF6347), // Coral
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎨 Let’s Trace!',
              style: GoogleFonts.luckiestGuy(fontSize: 26, color: Colors.white),
            ),
            Text(
              'Overlay and trace like a whiz!',
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: _isCameraInitialized
          ? Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(child: CameraPreview(_cameraController!)),
                      Positioned.fill(
                        child: Opacity(
                          opacity: _opacity,
                          child: Center(
                            child: Transform.scale(
                              scale: _scale,
                              child: Image.file(
                                widget.selectedImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAEFFF),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🌈 Adjust Opacity",
                        style: GoogleFonts.fredoka(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFFFF69B4),
                          thumbColor: Color(0xFFFFB6C1),
                          overlayColor: Color(0xFFFF69B4).withAlpha(32),
                        ),
                        child: Slider(
                          value: _opacity,
                          min: 0.0,
                          max: 1.0,
                          divisions: 10,
                          label: _opacity.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() {
                              _opacity = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "🔍 Adjust Size",
                        style: GoogleFonts.fredoka(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFFFF69B4),
                          thumbColor: Color(0xFFFFB6C1),
                          overlayColor: Color(0xFFFF69B4).withAlpha(32),
                        ),
                        child: Slider(
                          value: _scale,
                          min: 0.3,
                          max: 2.0,
                          divisions: 17,
                          label: (_scale * 100).toStringAsFixed(0) + '%',
                          onChanged: (value) {
                            setState(() {
                              _scale = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            ),
    );
  }
}
