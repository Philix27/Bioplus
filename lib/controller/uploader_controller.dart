import 'dart:io';
import 'package:bioplus/core/check_out_news.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Uploader extends GetxController {
  final Rx<List<String>> _urls = Rx<List<String>>([]);
  final Rx<String> _vidPath = Rx<String>('');
  RxBool isLoading = false.obs;

  Future<void> uploadDoc({required CheckoutNews checkoutNews}) async {
    if (checkoutNews.isVideo) {
      try {
        await _uploadVid(
          checkoutNews.vidFilePath,
          checkoutNews.docID,
          checkoutNews.storageReference,
        );
      } catch (e) {
        MyWidgets.errorSnackbar('Could not upload video');
      }

      checkoutNews.docMap.addAll({
        "vidUrl": _vidPath.value,
        "images": [],
      });
    } else if (checkoutNews.imageFiles.isNotEmpty) {
      // print("B600: video path - is empty");
      // print("B600: video path - is empty");
      try {
        await _uploadImages(
            checkoutNews.imageFiles, checkoutNews.storageReference);
      } catch (e) {
        MyWidgets.errorSnackbar('Error in uploading images');
      }

      checkoutNews.docMap.addAll({
        "images": _urls.value,
      });
    } else {
      checkoutNews.docMap.addAll({
        "images": [],
        "vidUrl": "",
      });
    }

    try {
      await checkoutNews.collectionReference
          .doc(checkoutNews.docID)
          .set(checkoutNews.docMap)
          .then((value) {
        MyWidgets.snackbar(
          title: 'Successful',
          message: checkoutNews.paymentPurpose,
          bgColor: Colors.green,
        );
      });
      isLoading.value = false;
    } on Exception {
      MyWidgets.snackbar(
        title: 'Sorry an error occured',
        message: checkoutNews.paymentPurpose,
        bgColor: Colors.red,
      );
    }
  }

  Future<dynamic> _postImage(
    Asset imageFile,
    Reference storageReference,
  ) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference reference = storageReference.child(fileName);
    final UploadTask uploadTask = reference.putData(
        (await imageFile.getByteData(quality: 70)).buffer.asUint8List());
    final TaskSnapshot storageTaskSnapshot = await uploadTask.snapshot;

    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<void> _uploadVid(
    String pathString,
    String docID,
    Reference storageReference,
  ) async {
    final File filee = File(pathString);
    final Reference reference = storageReference.child(docID);

    final UploadTask uploadTask = reference.putFile(
      filee,
      SettableMetadata(
        customMetadata: {"docID": docID},
        contentType: 'video/mp4',
      ),
    );

    final TaskSnapshot storageTaskSnapshot = await uploadTask.snapshot;
    MyWidgets.snackbar(title: "Video uploading");
    await storageTaskSnapshot.ref.getDownloadURL().then((value) {
      _vidPath.value = value.toString();
    });
  }

  Future<void> _uploadImages(
    List<Asset> _images,
    Reference storageReference,
  ) async {
    List<String> _imageUrls = [];

    for (final imageFile in _images) {
      await _postImage(imageFile, storageReference).then((downloadUrl) {
        _imageUrls.add(downloadUrl.toString());
        if (_imageUrls.length == _images.length) {
          _urls.value = _imageUrls;
        }
      }).catchError((err) {});
    }
    _imageUrls = [];
  }

  @override
  void onClose() {
    super.onClose();
    _urls.value = [];
  }
}
