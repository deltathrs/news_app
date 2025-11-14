import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> storeUserEmail(String email) async {
    await _secureStorage.write(key: 'user_email', value: email);
  }

  Future<String?> getUserEmail() async {
    return await _secureStorage.read(key: 'user_email');
  }

  Future<void> storeUserPhotoUrl(String photoUrl) async {
    await _secureStorage.write(key: 'user_photo_url', value: photoUrl);
  }

  Future<String?> getUserPhotoUrl() async {
    return await _secureStorage.read(key: 'user_photo_url');
  }
}
