import 'package:berichtsheft/src/models/berichtsheft_model.dart';
import 'package:berichtsheft/src/services.dart/data_provider.dart';
import 'package:berichtsheft/src/services.dart/mail_service.dart';
import 'package:berichtsheft/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

import '../widgets/delete_popup.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BerichstsheftModel data = BerichstsheftModel();
  final TextEditingController berichtController = TextEditingController();
  final TextEditingController aufgabenController = TextEditingController();
  final TextEditingController schulController = TextEditingController();

  void getSavedData() async {
    data = await DataProvider.getData();
    aufgabenController.text = data.stichPunkte;
    berichtController.text = data.bericht;
    schulController.text = data.schule;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  @override
  void dispose() {
    berichtController.dispose();
    aufgabenController.dispose();
    schulController.dispose();
    // DataProvider().saveData(BerichstsheftModel(
    //     bericht: berichtController.text,
    //     schule: schulController.text,
    //     stichPunkte: aufgabenController.text));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berichtsheft'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => const DeletionPopup());
              },
              icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Betriebsaufgaben",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 30,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 17),
                controller: aufgabenController,
              ),
            ),
          )),
          const Text(
            "Betriebsbericht",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 30,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 17),
                controller: berichtController,
              ),
            ),
          )),
          const Text(
            "Schule",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 30,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 17),
                controller: schulController,
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    bool success = await MailService().sendMail(
                        BerichstsheftModel(
                            bericht: berichtController.text,
                            stichPunkte: aufgabenController.text,
                            schule: schulController.text));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(success ? "send" : "something went wrong")));
                  },
                  child: const Text("Send Mail")),
              ElevatedButton(
                  onPressed: () async {
                    bool succes = await DataProvider.saveData(
                        BerichstsheftModel(
                            bericht: berichtController.text,
                            stichPunkte: aufgabenController.text,
                            schule: schulController.text));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(succes ? "saved" : "something went wrong"),
                    ));
                  },
                  child: const Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
