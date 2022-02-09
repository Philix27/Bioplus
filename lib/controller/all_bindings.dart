import 'package:bioplus/core/app_users.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/view/auth/auth_controller.dart';
import 'package:bioplus/view/market/product_controller.dart';

class AllControllerBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    //? Core
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    // UserController().u
    //? Services
    //? UI
    // Get.put<CommentController>(CommentController(), permanent: true);
    Get.put<ProductController>(ProductController(), permanent: true);
    // Get.put<CartController>(CartController(), permanent: true);
    // ? Leave the two controllers underneath

    //? FCM
    // Get.put<PushNotificationService>(PushNotificationService(),
    // permanent: true);
  }
}

AppUser appUser = Get.find<AppUser>();
AuthController authController = Get.find<AuthController>();
