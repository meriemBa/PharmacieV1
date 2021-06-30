import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:pharmacie/screens/data.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String result;
  Items item;
  List<Items> items = [];
  ScrollController scrollController = new ScrollController();
  // Future<List<Items>> fetchItems(BuildContext context) async {
  //   final jsonString =
  //       await DefaultAssetBundle.of(context).loadString('assets/data.json');
  //   return itemsFromJson(jsonString);
  // }
  Future<String> loadFromAssets() async {
    return await rootBundle.loadString('assets/data.json');
  }

  @override
  void initState() {
    super.initState();
    loadYourData();
  }

  loadYourData() async {
    String jsonString = await loadFromAssets();
    final yourDataModel = itemsFromJson(jsonString);

    for (int i = 0; i < yourDataModel.length; i++) {
      if (yourDataModel[i].code == result) {
        print("NOMMMMMMMMM");
        print(yourDataModel[i].nom);
        items.add(yourDataModel[i]);
        print(items);
        // Do your stuff
      }
    }
  }

  Future scanQR() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
        loadYourData();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unkown error";
        });
      }
    } on FormatException catch (e) {
      result = "Yo pressed de back button befor scanning";
    } catch (e) {
      setState(() {
        result = "Other error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('fetch med data '),
        ),
        body: Center(
          child: Column(children: [
            Row(children: []),
            items == null
                ? Container()
                : Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new ListTile(
                                title: new Text(items[index].nom),
                                trailing: new Text(items[index].ppv),
                              ),
                              Text(
                                result != null
                                    ? result
                                    : 'Veillez scanner le code barre de votre medicament',
                              ),
                            ],
                          );
                        }),
                  ),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.scanner),
            onPressed: scanQR,
            label: Text('QR Scan')));
  }
}
