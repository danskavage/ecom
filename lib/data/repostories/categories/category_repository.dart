import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/features/shop/models/category_model.dart';
import 'package:flutter_application_2/utils/exceptions/firebase_exception.dart';
import 'package:flutter_application_2/utils/exceptions/platform_exception.dart';
import 'package:flutter_application_2/utils/local_storage/firebase_storage_service.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //get all categories

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //upload all categories with their images
      final storage = Get.put(TFirebaseStorageService());

      //loop through each category

      for (var category in categories) {
        //Get Imagedata link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        //ipload image and get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);
        //assign URL to category image attribute
        category.image = url;

        //storage category in firebase
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
