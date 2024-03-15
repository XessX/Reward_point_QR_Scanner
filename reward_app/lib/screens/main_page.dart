import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reward_app/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _textController = TextEditingController(text: '');
  String data = '';
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  //dynamic externalDir = '/storage/emulated/0/Download/Qr_code';
  bool isSwitch = false;
  // Future<void> _captureAndSavePng() async {
  //   try{
  //     RenderRepaintBoundary boundary = _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     var image = await boundary.toImage(pixelRatio: 3.0);
  //
  //     //Drawing White Background because Qr Code is Black
  //     final whitePaint = Paint()..color = Colors.white;
  //     final recorder = PictureRecorder();
  //     final canvas = Canvas(recorder,Rect.fromLTWH(0,0,image.width.toDouble(),image.height.toDouble()));
  //     canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
  //     canvas.drawImage(image, Offset.zero, Paint());
  //     final picture = recorder.endRecording();
  //     final img = await picture.toImage(image.width, image.height);
  //     ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();
  //
  //     //Check for duplicate file name to avoid Override
  //     String fileName = 'qr_code';
  //     int i = 1;
  //     while(await File('$externalDir/$fileName.png').exists()){
  //       fileName = 'qr_code_$i';
  //       i++;
  //     }
  //
  //     // Check if Directory Path exists or not
  //     dirExists = await File(externalDir).exists();
  //     //if not then create the path
  //     if(!dirExists){
  //       await Directory(externalDir).create(recursive: true);
  //       dirExists = true;
  //     }
  //
  //     final file = await File('$externalDir/$fileName.png').create();
  //     await file.writeAsBytes(pngBytes);
  //
  //     if(!mounted)return;
  //     const snackBar = SnackBar(content: Text('QR code saved to gallery'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //   }catch(e){
  //     if(!mounted)return;
  //     const snackBar = SnackBar(content: Text('Something went wrong!!!'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }


  User currentU= FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dragon Court', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: 'Enter Text',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 146, 20), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                data = _textController.text;
              });
            },
            fillColor: AppColors.primaryColor,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: const Text(
              'Generate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: [
              Text('Scan for Rewards', style: TextStyle(color: Colors.grey, fontSize: 25,fontWeight: FontWeight.bold),),
              Text('Scan to earn points and use rewards', style: TextStyle(color: Colors.grey, fontSize: 20),),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RepaintBoundary(
              key: _qrkey,
              child: QrImageView(
                data: currentU.uid,
                version: QrVersions.auto,
                size: 250.0,
                gapless: true,
                errorStateBuilder: (ctx, err) {
                  return const Center(
                    child: Text(
                      'Something went wrong!!!',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Text('Your Rewards Number', style: TextStyle(color: Colors.grey, fontSize: 15),),
              Text(currentU.uid, style: TextStyle(color: Colors.grey, fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Redeem your points', style: TextStyle(fontSize: 20),),
                   Spacer(),
                   // RadioMenuButton(onChanged: null, value: null, child: null, groupValue: null,),
                    Switch(value: isSwitch,activeColor: AppColors.primaryColor, onChanged: (value){setState(() {
                      isSwitch = value;
                    });}),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              RawMaterialButton(
                onPressed: (){

                },
                fillColor: AppColors.primaryColor,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                child: const Text(
                  'Use Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
