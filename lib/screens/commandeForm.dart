import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/Repository/db.dart';
import 'package:pharmacie/screens/generate.dart';
import 'package:pharmacie/screens/medicament.dart';
import 'package:random_string/random_string.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String fullName;
  String adresse;
  String medicamentName;
  String quantite;
  String phoneNumber;
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading;
  bool centerCircle;
  String commandeId;

  void createCommande() async {
    commandeId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        centerCircle = true;
      });

      Map<String, String> profData = {
        "name": fullName,
        "adress": adresse,
        "phone": phoneNumber,
      };

      // String jsonString = jsonEncode(profData);
      // print(jsonString);
      String dataClient =
          "Infos sur le Client : \n Nom_Client :${fullName}\n  Adresse: ${adresse}\n  Télé: ${phoneNumber}\n";

      databaseService.addcommandeData(profData, commandeId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MedicamentFormScreen(commandeId, dataClient)));
      });
    }
  }

  Widget _buildName() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Nom et Prénom', icon: Icon(Icons.person)),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onChanged: (String value) {
        fullName = value;
      },
    );
  }

  Widget _buildAdress() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Adresse', icon: Icon(Icons.home_work_outlined)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Adress is Required';
        }

        return null;
      },
      onChanged: (String value) {
        adresse = value;
      },
    );
  }

  // Widget _builmedicamentName() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Medicament', icon: Icon(Icons.medical_services)),
  //     keyboardType: TextInputType.url,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Medicament is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _medicamentName = value;
  //     },
  //   );
  // }

  // Widget _buildquantite() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Quantité', icon: Icon(Icons.production_quantity_limits)),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Quantité is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _quantite = value;
  //     },
  //   );
  // }

  Widget _buildphoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Numéro téléphone', icon: Icon(Icons.phone_iphone)),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        return null;
      },
      onChanged: (String value) {
        phoneNumber = value;
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
                _buildName(),
                SizedBox(
                  height: 10,
                ),
                _buildAdress(),
                SizedBox(
                  height: 10,
                ),
                _buildphoneNumber(),
                GestureDetector(
                  onTap: () {
                    createCommande();
                    circular = true;
                  },
                  // _builmedicamentName(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // _buildquantite(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
