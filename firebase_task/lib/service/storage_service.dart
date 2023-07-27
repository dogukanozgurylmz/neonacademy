import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  late FirebaseStorage _storage;

  void init() {
    _storage = FirebaseStorage.instance;
  }

  Future<void> addImage(String collection, String id, File? imageFile) async {
    try {
      var ref = _storage.ref().child(collection).child(id);
      var metadata = SettableMetadata(
          contentType:
              'image/jpeg'); // Resim dosyası türüne göre content type'ı ayarlayın
      await ref.putFile(imageFile!, metadata);
    } catch (e) {
      print("Resim yükleme hatası: $e");
    }
  }

  Future<String> getImageProvider(String collection, String id) async {
    try {
      var ref = _storage.ref().child(collection).child(id);
      var downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return "";
    }
  }
}
