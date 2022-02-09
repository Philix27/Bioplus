import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CheckoutNews {
  int? price;
  final CollectionReference collectionReference;
  final Reference storageReference;
  final String paymentPurpose;
  final List<Asset> imageFiles;
  final String vidFilePath;
  final bool isVideo;
  final String docID;
  final Map<String, dynamic> docMap;

  CheckoutNews({
    this.price,
    required this.collectionReference,
    required this.storageReference,
    required this.isVideo,
    required this.paymentPurpose,
    required this.imageFiles,
    required this.vidFilePath,
    required this.docID,
    required this.docMap,
  });
}
