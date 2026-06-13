import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/ai_service.dart';
import '../../services/image_service.dart';
import '../../services/secure_storage_service.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final aiServiceProvider = Provider<AiService>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AiService(secureStorage);
});

final imageServiceProvider = Provider<ImageService>((ref) {
  return ImageService();
});
