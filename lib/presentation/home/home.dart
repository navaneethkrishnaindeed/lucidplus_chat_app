import 'dart:developer';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sensors_plus/sensors_plus.dart';

import '../../infrastructure/global_database/telegram_apis/send_message/irepo.dart';
import '../../infrastructure/local_database/secured_shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isenterd = false;
  bool enterA_ValidID = false;
  String telegramId = "";
  late bool val;
  @override
  void initState() {
    super.initState();

    getval();

    getContactPermission();
  }

  void getval() async {
    val = await FlutterLocalSecuredStorage().getbool("telegram_id");
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      // log("message");
    } else {
      log("is not permissed ");
      try {
        await Permission.contacts.request();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late StreamSubscription _volumeButtonSubscription;
    String? _latestHardwareButtonEvent;

    StreamSubscription<String>? _buttonSubscription;
    double dx = 60, dy = 350;

    userAccelerometerEvents.listen((UserAccelerometerEvent event) async {
      // log(event.x.toString());
      if (event.x >= 60 ||
          event.y >= 60 ||
          event.x <= -60 ||
          event.y <= -60 ||
          (event.z >= 60 || event.z <= -60)) {
        var id = await FlutterLocalSecuredStorage().read(
          "telegram_id",
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sending Message"),
        ));
        final pos = await Geolocator.getCurrentPosition();
        print(pos);
        final stringPos =
            "https://maps.google.com/?q=${pos.latitude},${pos.longitude}";
        ITelegramSendMessageRepoImpl instance = ITelegramSendMessageRepoImpl();
        instance.sendMessageTo(
            id, "Hello chtbot activated your  and  her location is $stringPos");
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
          child: isenterd
              ? Center(
                  child: Text("You are good to go !!!"),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: TextFormField(
                              onChanged: (value) async {
                                telegramId = value;
                              },
                              onTap: () async => Permission.contacts.request(),
                              decoration: InputDecoration(
                                hintText: "Enter Contact",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ))),

                      ElevatedButton(
                        onPressed: () async {
                          if (telegramId == "") {
                            setState(() {
                              enterA_ValidID = true;
                            });
                          } else {
                            await FlutterLocalSecuredStorage()
                                .write("telegram_id", telegramId);
                            if (await FlutterLocalSecuredStorage()
                                .getbool("telegram_id")) {
                              setState(() {
                                isenterd = true;
                              });
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )

                      // isenterd?

                      // ListView.builder()
                    ],
                  ),
                )),
    );
  }
}