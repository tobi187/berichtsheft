import 'package:berichtsheft/src/models/berichtsheft_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  String schoolBoilerplate = """
  BWL: 
  VWL:
  Programmieren:
  ITS:
  Englisch:
  Deutsch:
  Geschichte:
  Elektro:
  Digitaltechnik
  """;

  Future<BerichstsheftModel> getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String schulText = _prefs.getString("schulText") ?? "";
    String berichtText = _prefs.getString("berichtText") ?? "";
    String aufgabenText = _prefs.getString("aufgabenText") ?? "";

    return BerichstsheftModel(
        bericht: berichtText, schule: schulText, stichPunkte: aufgabenText);
  }

  // Future<void> deleteData() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   await _prefs.remove("schulText");
  //   await _prefs.remove("berichtText");
  //   await _prefs.remove("aufgabenText");
  // }

  Future<bool> saveData(BerichstsheftModel data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      await _prefs.setString("schulText", data.schule);
      await _prefs.setString("berichtText", data.bericht);
      await _prefs.setString("aufgabenText", data.stichPunkte);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> delete() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove("schulText");
    await _prefs.remove("berichtText");
    await _prefs.remove("aufgabenText");
    await _prefs.setString("schulText", schoolBoilerplate);
  }
}
