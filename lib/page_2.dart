import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recruit_project/api.dart';

import 'conflicted_layout_1.dart';
import 'conflicted_layout_2.dart';

// ignore: must_be_immutable
class PageTwo extends StatefulWidget {
  PageTwo({super.key});

  static const platform = MethodChannel('com.example.recruit_project/channel');

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  String name = "";
  File? image;

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //init DIO
  final ApiService _apiService = ApiService(Dio());

  XFile? pickedImage;

  void makeAPICall() async {
    var res = await _apiService.dio.get('/appversion');

    debugPrint("${res.data}");

    if (res.statusCode == 200) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Request success',
              style: const TextStyle(color: Colors.white)),
        ),
      );
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Request Failed',
              style: const TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<void> _callKotlinCode() async {
    try {
      final String result = await PageTwo.platform.invokeMethod('getAndroidId');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("My name is $name"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                _callKotlinCode();
              },
              child: const Text('Print device ID')),
          const SizedBox(height: 30),
          image == null
              ? ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text('Select Image'))
              : Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(8),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        // shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            color: Colors.redAccent.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: Image.file(
                        image!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              // shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(3.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  color: Colors.redAccent.withOpacity(0.3),
                                )
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  image == null;
                                });
                              },
                              // splashColor: kPrimaryColor
                              //     .withOpacity(0.4),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )))
                  ],
                ),
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

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage!.path);
      });
    } else {
      print('No image selected.');
    }
  }
}
