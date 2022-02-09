part of 'profile_page.dart';

class ProfileBody extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    bool noPPix = false;
    if (!_userController.user.profilePic.isURL) {
      noPPix = true;
    }

    List<Widget> adminList(List<String> adminTypes) {
      final List<Widget> widList = [];

// ignore: avoid_function_literals_in_foreach_calls
      adminTypes.forEach((type) {
        widList.add(
          ListTile(
            title: Text(
              type,
              style: Styles.headlineText2,
            ),
          ),
        );
      });
      return widList;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Card(
                color: Styles.canvasColor,
                child: noPPix
                    ? Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/ppic.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CachedNetworkImage(
                          imageUrl: _userController.user.profilePic,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Loading.spinKitFadingCircle(),
                          errorWidget: (context, url, error) =>
                              Loading.spinKitFadingCircle(
                                  color: Styles.warningColor),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Personal Details',
              style: Styles.headlineText1,
            ),
            const SizedBox(height: 20),
            CustomListTile(
              icon: CupertinoIcons.person_fill,
              text: _userController.user.username,
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.email,
              text: _userController.user.email,
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.phone,
              text: _userController.user.phoneNumber,
              onTap: () {},
            ),
            // CustomListTile(
            //   icon: Icons.update_rounded,
            //   text: "Customer Care",
            //   onTap: () {
            //     MyWidgets.goTo(SuggestionPage());
            //   },
            // ),
            const SizedBox(height: 20),
            Text(
              'Settings',
              style: Styles.headlineText1,
            ),
            const SizedBox(height: 20),
            // CustomListTile(
            //   icon: Icons.colorize,
            //   text: "Theme",
            //   onTap: () {
            //     Get.bottomSheet(
            //       Wrap(
            //         children: [
            //           ListTile(
            //             title: Text(
            //               'Light mode',
            //               style: Styles.headlineText2,
            //             ),
            //             autofocus: true,
            //             onTap: () {
            //               ThemeService().makeLight();
            //             },
            //           ),
            //           Divider(color: Styles.backgroundColor),
            //           ListTile(
            //             title: Text(
            //               'Dark mode',
            //               style: Styles.headlineText2,
            //             ),
            //             autofocus: true,
            //             onTap: () {
            //               ThemeService().makeDark();
            //             },
            //           ),
            //         ],
            //       ),
            //       backgroundColor: Styles.canvasColor,
            //       isDismissible: true,
            //     );
            //   },
            // ),

            //! Admin types
            //! Admin types
            CustomListTile(
              icon: Icons.admin_panel_settings,
              text: "Admin Type",
              onTap: () {
                Get.bottomSheet(
                  Wrap(
                    children: adminList(_userController.user.adminTypes),
                  ),
                  backgroundColor: Styles.canvasColor,
                  isDismissible: true,
                );
              },
            ),
            // CustomListTile(
            //   icon: Icons.payment,
            //   text: "Add card",
            //   onTap: () {
            //     MyWidgets.goTo(const AddPaymentCard());
            //   },
            // ),
            CustomListTile(
              icon: Icons.logout,
              text: "Logout",
              onTap: () => authController.logOut(),
            ),
          ],
        ),
      ),
    );
  }
}
