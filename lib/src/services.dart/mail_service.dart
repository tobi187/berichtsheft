import 'package:berichtsheft/src/models/berichtsheft_model.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class MailService {
  Future<bool> sendMail(BerichstsheftModel data) async {
    final date = DateTime.now();
    String textBody = """
    Berichtsheft für KW ${date.weekOfYear.toString()}
    --------------------------------------
    Betriebliche Todos:
    ${data.stichPunkte}

    WochenBericht:
    ${data.bericht}

    Schule:
    ${data.schule}

    Kuss Kuss
    """;

    final Email email = Email(
        subject: "Berichtsheft ${date.weekOfYear.toString()}",
        body: textBody,
        recipients: ["t.fischer@walz.de", "fischer.tobias@freenet.de"]);

    try {
      await FlutterEmailSender.send(email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
