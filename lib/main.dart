import 'package:flutter/material.dart';
import 'package:flutter_shieldfraud/plugin_shieldfraud.dart';
import 'package:flutter_shieldfraud/shield_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    print('init shield');
    ShieldConfig config = _shieldResultCallback();
    Shield.initShield(config);

    super.initState();
  }

  ShieldConfig _shieldResultCallback() {
    ShieldCallback shieldCallback =
        ShieldCallback((Map<String, dynamic> result) async {
      print('Starting shield process');
      print(await createOrderMessage(result));
    }, (ShieldError error) {
      print('ShieldError: ${error.message}');
    });

    ShieldConfig config =
        ShieldConfig(siteID: '*', key: '*', shieldCallback: shieldCallback);
    return config;
  }

  Future<String> createOrderMessage(Map<String, dynamic> result) async {
    var order = await fetchUserOrder(result);
    return 'Your order is: $order';
  }

  Future<String> fetchUserOrder(Map<String, dynamic> result) => Future.delayed(
        const Duration(seconds: 5),
        () => 'Large Latte Coffee along with Callback result: $result',
      );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: MaterialButton(
          onPressed: () {
            Shield.sendDeviceSignature("test sending device signature").then(
                (value) => print(
                    "sending device signature in real time successful: $value"));
          },
          child: const Text("Send attributes"),
        )),
      ),
    );
  }
}
