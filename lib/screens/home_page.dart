import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String imageAsset = 'assets/image.png';

  Future<void> _shareText() async {
    const link = 'https://www.google.com';
    try {
      await Share.share(link, subject: 'Check out this link!');
    } catch (e) {
      print('Error sharing link: $e');
    }
  }

  Future<void> _pickAndShareImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _shareImage(pickedFile);
    }
  }

  Future<void> _shareImage(XFile pickedFile) async {
    try {
      await Share.shareXFiles([pickedFile], subject: 'Check out this image!');
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter Share Link POC',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 100, 55, 179),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              shareButton("Share Text", () async {
                await _shareText();
              }),
              const SizedBox(
                height: 20,
              ),
              shareButton("Share Image", () async {
                await _pickAndShareImage();
              })
            ],
          ),
        ));
  }

  shareButton(String title, Function()? onPressed) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
