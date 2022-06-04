import 'package:flutter/material.dart';
import '../screens/main_page.dart';
import '../services.dart/data_provider.dart';

class DeletionPopup extends StatelessWidget {
  //VoidCallback continueCallBack;
  const DeletionPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Löschen", style: TextStyle(color: Colors.black)),
      content: const Text("Den ganzen Text löschen?",
          style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        TextButton(
          child: const Text("Ja"),
          onPressed: () async {
            // continueCallBack();
            await DataProvider.delete();
            Navigator.restorablePushNamed(context, MainPage.routeName);
          },
        ),
        TextButton(
          child: const Text("Abbrechen"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
