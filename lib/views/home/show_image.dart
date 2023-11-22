import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pillowtalk/services/chat_services.dart';

class ShowImageScreen extends StatefulWidget {
  String imageFile;

  ShowImageScreen({
    required this.imageFile,
  });

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CachedNetworkImage(
            imageUrl: widget.imageFile,
          ),
        ),
      ),
    );
  }
}
