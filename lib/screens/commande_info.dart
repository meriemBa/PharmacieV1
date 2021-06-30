import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/Repository/db.dart';
import 'package:pharmacie/model/commande.dart';

class CommandeInfo extends StatefulWidget {
  final String commmandeId;
  CommandeInfo(this.commmandeId);

  @override
  _CommandeInfoState createState() => _CommandeInfoState();
}

/// Stream
Stream infoStream;

class _CommandeInfoState extends State<CommandeInfo> {
  QuerySnapshot commandeSnapshot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;

  @override
  void initState() {
    databaseService.getCommandeData().then((value) {
      commandeSnapshot = value;

      setState(() {});
    });

    super.initState();
  }

  CommandeModel getCommandeModelFromDatasnapshot(
      DocumentSnapshot commandeSnapshot) {
    CommandeModel commandeModel = new CommandeModel();

    commandeModel.fullName = commandeSnapshot.data()['name'];
    commandeModel.adresse = commandeSnapshot.data()['adress'];
    commandeModel.phoneNumber = commandeSnapshot.data()['phone'];

    /// shuffling the options
    return commandeModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: Text("No Data"),
                      ),
                    ),
                    ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CommandePlayTile(
                            commandeModel: getCommandeModelFromDatasnapshot(
                                commandeSnapshot.documents[index]),
                            index: index,
                          );
                        })
                  ],
                ),
              ),
            ),
    );
  }
}

class CommandePlayTile extends StatefulWidget {
  final CommandeModel commandeModel;
  final int index;

  CommandePlayTile({@required this.commandeModel, @required this.index});

  @override
  _CommandePlayTileState createState() => _CommandePlayTileState();
}

class _CommandePlayTileState extends State<CommandePlayTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.commandeModel.fullName}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.commandeModel.adresse}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
