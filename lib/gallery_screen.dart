import 'dart:io';
import 'package:flutter/material.dart';
import 'databaseHelper.dart';


// ignore: use_key_in_widget_constructors
class GalleryScreen extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: FutureBuilder<List<String>>(
        future: dbHelper.getAllImagePaths(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final imagePaths = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final imagePath = imagePaths[index];
                final imageFile = File(imagePath);

                return Image.file(imageFile, fit: BoxFit.cover);
              },
            );
          }
        },
      ),
    );
  }
}