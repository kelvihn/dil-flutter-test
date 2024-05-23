import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruit_project/api.dart';

// ignore: must_be_immutable
class PageTwo extends StatefulWidget {
  String name = "";
  PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  //init DIO
  final ApiService _apiService = ApiService(Dio());

  void _loadData() {
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('We are happy people'),
      ));
    });
  }

  XFile? pickedImage;

  @override
  void initState() {
    ///[Display a snackbar on Page load]
    _loadData();
    super.initState();
  }

  void makeAPICall() async {
    var res = await _apiService.dio.get('/appversion');

    debugPrint("${res.data}");

    if (res.statusCode == 200) {
      ///[handle success]
    } else {
      ///[handle error]
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("My name is ${widget.name}"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                ///[Fetch Device ID from MainActivity.kt]
                ///Call [getAndroidId()] which gets the device ID natively and [prints] it on the console
              },
              child: const Text('Print device ID')),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Select Image')),
          const SizedBox(height: 10),
          if (pickedImage != null) Image.file(File(pickedImage!.path)),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {
                makeAPICall();
              },
              child: const Text('Test API call')),
        ],
      ),
    );
  }

  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
