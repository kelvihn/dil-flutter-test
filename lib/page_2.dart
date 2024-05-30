import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruit_project/api.dart';

import 'conflicted_layout_1.dart';
import 'conflicted_layout_2.dart';

// ignore: must_be_immutable
class PageTwo extends StatelessWidget {
  String name = "";
  PageTwo({super.key});

  //init DIO
  final ApiService _apiService = ApiService(Dio());

  XFile? pickedImage;

  void makeAPICall() async {
    var res = await _apiService.dio.get('/appversion');

    debugPrint("${res.data}");

    if (res.statusCode == 200) {
      log(res.data);

      ///[handle success]
    } else {
      log(res.statusMessage.toString());

      ///[handle error]
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("My name is $name"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                ///[Fetch Device ID from MainActivity.kt]
                ///Call [getAndroidId()] which gets the device ID natively and [prints] it on the console
                final String? deviceId =
                    await const MethodChannel('com.example.recruit_project')
                        .invokeMethod('getDeviceId');
                log(deviceId.toString());
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConflictedLayout()));
              },
              child: const Text('Conflicted Layout 1')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConflictedLayout2()));
              },
              child: const Text('Conflicted Layout 2')),
        ],
      ),
    );
  }

  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
