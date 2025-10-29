import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'camera_drawing.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<String> surpriseItems = [
    'Use the color 🎨 Red!',
    'Trace a ⭐ Star!',
    'Draw a 🐱 Cat!',
    'Try drawing with your left hand!',
    'Make a rainbow 🌈',
    'Use dots to draw a picture!',
    'Draw something that makes you happy 😊',
    'Draw your favorite cartoon character 🧸',
    'Use only circles to make a picture 🔵',
    'Draw a magical creature like a unicorn 🦄',
    'Draw your dream house 🏡',
    'Draw what you want to be when you grow up 👩‍🚀👨‍⚕️',
    'Try drawing with your eyes closed! 🙈',
    'Draw your favorite food 🍕🍦',
    'Make a monster with 3 eyes and 4 arms 👾',
    'Draw your best friend 👫',
    'Use only two colors to make a picture 🎨',
    'Draw the view from your window 🪟',
    'Draw your favorite animal 🐘🦁',
    'Draw a robot 🤖',
    'Draw a scene from your favorite storybook 📖',
    'Draw the sun wearing sunglasses 😎☀️',
    'Draw a rocket flying into space 🚀',
  ];

  List<XFile> _images = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void showSurprise(BuildContext context) {
    final randomItem = (surpriseItems..shuffle()).first;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.pink.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '🎁 Surprise!',
          style: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: Text(randomItem, style: GoogleFonts.fredoka(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Yay!', style: TextStyle(color: Colors.pink)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4), Color(0xFFFF6347)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎨 TraceWhiz',
              style: GoogleFonts.luckiestGuy(fontSize: 28, color: Colors.white),
            ),
            Text(
              'Trace it. Love it. Draw like a Whiz!',
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showSurprise(context),
            icon: const Text('🎁', style: TextStyle(fontSize: 26)),
            tooltip: 'Surprise Tool',
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _images.isEmpty
            ? Center(
                // child: Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Icon(
                //       Icons.image_outlined,
                //       size: 70,
                //       color: Colors.pinkAccent,
                //     ),
                //     const SizedBox(height: 16),
                //     Text(
                //       'No drawings yet!',
                //       style: GoogleFonts.fredoka(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     const SizedBox(height: 8),
                //     Text(
                //       'Tap the 🖼️ button below to add your first masterpiece!',
                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.fredoka(fontSize: 16),
                //     ),
                //   ],
                // ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: DefaultTextStyle(
                        style: GoogleFonts.fredoka(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFF69B4),
                        ),
                        child: AnimatedTextKit(
                          //isRepeatingAnimation: true,
                          repeatForever: true, // 🔁 Infinite animation
                          pause: const Duration(milliseconds: 1000),
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Oops! No drawings yet 🎨',
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap the 🖼️ button below and create your first masterpiece!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                itemCount: _images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CameraDrawing(
                            selectedImage: File(_images[index].path),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFFFB6C1),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_images[index].path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pickImage,
      //   backgroundColor: Color(0xFFFF69B4),
      //   child: const Icon(
      //     Icons.add_photo_alternate_rounded,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color(0xFFFF69B4),
      //   onPressed: _pickImage,
      //   child: const Text('🌈', style: TextStyle(fontSize: 28)),
      // ),
      floatingActionButton: RawMaterialButton(
        onPressed: _pickImage,
        fillColor: Colors.transparent, // No background color
        elevation: 0, // No shadow
        shape: const CircleBorder(), // Optional for round tap area
        constraints: const BoxConstraints.tightFor(width: 56, height: 56),
        child: const Text('🖼️', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
