import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/Repository/db.dart';
import 'package:pharmacie/model/medicamentModel.dart';
import 'package:pharmacie/screens/commandeForm.dart';
import 'package:pharmacie/screens/commande_info.dart';
import 'package:pharmacie/screens/generate.dart';
import 'package:random_string/random_string.dart';

class MedicamentFormScreen extends StatefulWidget {
  final String commandeId;
  String jsonString;

  MedicamentFormScreen(this.commandeId, this.jsonString);
  @override
  State<StatefulWidget> createState() {
    return MedicamentFormScreenState();
  }
}

class MedicamentFormScreenState extends State<MedicamentFormScreen> {
  String medicamentName;
  String quantite;
  String phoneNumber;
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading;
  String commandeId;
  bool centerCircle;
  List<MedicamentModel> medicaments = [];
  MedicamentModel medicament;

  // Future<void> getMedList() async {
  //   // print(query);
  //   // if (query != "") {
  //   // queryData(widget.searchText);

  //   QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
  //       .collection("commande")
  //       .doc(widget.commandeId)
  //       .collection("medicament")
  //       .get();
  //   print(commandeId);
  //   featureSnapShot1.docs.forEach(
  //     (element) {
  //       medicament = MedicamentModel(
  //           nomMedicament: element.data()["medicamentName"],
  //           quantite: element.data()['quantite']);
  //       setState(() {
  //         medicaments.add(medicament);
  //       });
  //     },
  //   );
  // }

  // already generated qr code when the page opens
  Future<void> getMedList() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("commande")
        .doc(widget.commandeId)
        .collection("medicament")
        .get();
    print(widget.commandeId);
    featureSnapShot1.docs.forEach(
      (element) {
        medicament = MedicamentModel(
            nomMedicament: element.data()["medicamentName"],
            quantite: element.data()['quantite']);

        setState(() {
          medicaments.add(medicament);
        });
        // String dataM =
        //     " Medicament :${medicament.nomMedicament} , quantité: ${medicament.quantite} \n";
        // print("dokhlo");
        // print(dataM);
        // List<MedicamentModel> m = medicaments;
        // String myData = m.join();
        // print(myData.toString());
      },
    );
    List<String> MaList = List();
    for (var ele in medicaments) {
      MaList.add("Medicament:" +
          ele.nomMedicament +
          " , quantité:" +
          ele.quantite +
          "\n");
    }

    String listData =
        widget.jsonString + "Infos Sur la commande \n " + MaList.join("\n");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => GeneratePage(listData)));
  }

  createCommandeMed() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> medData = {
        "medicamentName": medicamentName,
        "quantite": quantite,
      };

      // String data =
      //     " Medicament :${medicamentName} \n quantité: ${quantite} \n ${widget.jsonString}";
      // print(data);
      databaseService.addMedData(medData, widget.commandeId).then((value) {
        setState(() {
          isLoading = false;
        });

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GeneratePage(widget.commandeId)));
      });
      // getMedList();
    }
  }

  Widget _builmedicamentName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Medicament', icon: Icon(Icons.medical_services)),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Medicament is Required';
        }

        return null;
      },
      onChanged: (String value) {
        medicamentName = value;
      },
    );
  }

  Widget _buildquantite() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Quantité', icon: Icon(Icons.production_quantity_limits)),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Quantité is Required';
        }

        return null;
      },
      onChanged: (String value) {
        quantite = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _builmedicamentName(),
                SizedBox(
                  height: 10,
                ),
                _buildquantite(),
                GestureDetector(
                  onTap: () {
                    createCommandeMed();
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: circular
                              ? CircularProgressIndicator()
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    getMedList();
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: circular
                              ? CircularProgressIndicator()
                              : Text(
                                  "generate",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
