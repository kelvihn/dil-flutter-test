import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruit_project/api.dart';

import 'conflicted_layout_1.dart';
import 'conflicted_layout_2.dart';

const MethodChannel _channel = MethodChannel("sample/getAndroidId");

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
      ///[handle success]
    } else {
      ///[handle error]
      debugPrint("Something occured, please try again later.");
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
              onPressed: () {
                ///[Fetch Device ID from MainActivity.kt] : DONE
                getDeviceId();
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ConflictedLayout()));
              },
              child: const Text('Conflicted Layout 1')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ConflictedLayout2()));
              },
              child: const Text('Conflicted Layout 2')),
        ],
      ),
    );
  }

  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<String> getDeviceId() async {
  try {
    final String? deviceId = await _channel.invokeMethod<String>('getAndroidId');
    return deviceId ?? "Not found";
  } on PlatformException catch (e) {
    return 'Failed to get device ID: ${e.message}';
  }
}


}
