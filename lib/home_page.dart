// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  String _result = '';
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = '';
        _isLoading = true;
      });

      try {
        // Convert image to base64
        String base64Image = base64Encode(_image!.readAsBytesSync());
        final result = await _apiService.detectAge(base64Image);

        if (result.isNotEmpty) {
          setState(() {
            _result = result.map((face) {
              return 'Detected Age: ${face['age']}';
            }).join('\n');
          });
        } else {
          setState(() {
            _result = 'No faces detected or unable to detect age.';
          });
        }
      } catch (e) {
        setState(() {
          _result = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Detection App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null) Image.file(_image!),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty) Text(_result),
          ],
        ),
      ),
    );
  }
}
