import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pillowtalk/services/chat_services.dart';

class ImagePreviewScreen extends StatefulWidget {
  final File imageFile;
  String currentId;
  String partnerId;

  ImagePreviewScreen({
    required this.imageFile,
    required this.currentId,
    required this.partnerId,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                _cropImage(widget.imageFile);
              },
              icon: Icon(
                Icons.crop,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Image.file(
                widget.imageFile,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.8,
                MediaQuery.of(context).size.height * 0.07,
              ),
            ),
            child: Text('Send',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            onPressed: () async {
              String? imageUrl =
                  await ChatServices().uploadImageToStorage(widget.imageFile);
              ChatServices().sendMessage(widget.currentId, widget.partnerId,
                  imageUrl: imageUrl);
              Navigator.pop(context);
            } /* onCropPressed */,
          )
        ],
      ),
    );
  }

  Future<void> _cropImage(File? selectedImage) async {
    if (selectedImage != null) {
      try {
        final croppedFile = await ImageCropper().cropImage(
            sourcePath: selectedImage.path,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 100,
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
              )
            ]);

        if (croppedFile != null) {
          setState(() {
            _selectedImage = File(croppedFile.path);
          });
        }
      } catch (e) {
        print('Error cropping image: $e');
      }
    }
  }
}
