import 'package:bioplus/view/widgets/webview.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class ChatsHandler {
  static const String delsuEdu = 'Delsu Online';
  static const String delsuOnline = 'Delsu Edu';

  static const List<String> choices = [delsuEdu, delsuOnline];

  static void choiceAction(String choice) {
    if (choice == delsuOnline) {
      MyWidgets.getBack();
      MyWidgets.goTo(const WebPageView(
        title: "Delsu Portal",
        url: "https://portal.delsu.edu.ng/",
      ));
    } else if (choice == delsuEdu) {
      MyWidgets.getBack();
      MyWidgets.goTo(const WebPageView(
        title: "Delsu Edu",
        url: "https://delsu.edu.ng/",
      ));
    }
  }
}
