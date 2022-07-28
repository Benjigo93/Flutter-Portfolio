import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../components/menu_nav.dart';

// Scanner Page
class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ScannerState createState() {
    return ScannerState();
  }
}

class ScannerState extends State<ScannerPage> {
  late String scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const MenuNavigation(),
      body: Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    onPressed: () => scanBarcodeNormal(),
                    child: const Text('Start barcode scan')
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    onPressed: () => scanQR(),
                    child: const Text('Start QR scan')
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    onPressed: () => startBarcodeScanStream(),
                    child: const Text('Start barcode scan stream')
                ),
              ),
              (scanBarcode.isNotEmpty)?
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                    'Scan result : $scanBarcode\n',
                    style: const TextStyle(fontSize: 20)
                ),
              ):
              Container(),
            ]
        ),
      ),
    );
  }
}

