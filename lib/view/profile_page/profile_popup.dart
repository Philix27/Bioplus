part of 'profile_page.dart';

class ProfilePopup {
  static const String editprofile = 'Edit Profile';
  static const String customerCare = 'Tech Support';
  static const String notification = 'Notifications';
  static const String addCard = 'AddCard';
  // static const String fcm = 'FCM';

  static const List<String> choices = [
    editprofile,
    customerCare,
    notification,
    addCard,
    // fcm,
  ];

  static void choiceAction(String choice) {
    if (choice == addCard) {
      MyWidgets.getBack();
      // MyWidgets.goTo(const AddPaymentCard());
    } else if (choice == customerCare) {
      MyWidgets.getBack();
      MyWidgets.goTo(SuggestionPage());
    } else if (choice == editprofile) {
      MyWidgets.getBack();
      MyWidgets.goTo(const UpdateUserPage());
    } else if (choice == notification) {
      MyWidgets.getBack();
      MyWidgets.goTo(NotificationPage());
    }
    //  else if (choice == fcm) {
    //   MyWidgets.getBack();
    //   MyWidgets.goTo(NotificationPage());
    // }
  }
}
