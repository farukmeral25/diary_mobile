import 'package:diary_mobile/core/utils/image/i_image_service.dart';
import 'package:diary_mobile/core/utils/image/image_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:diary_mobile/core/utils/device_manager.dart';
import 'package:diary_mobile/core/utils/dio_manager.dart';
import 'package:diary_mobile/core/utils/local_services/service/i_local_service.dart';
import 'package:diary_mobile/core/utils/local_services/service/local_service.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // client
  sl.registerLazySingleton<Dio>(() => DioManager.getDio());

  // Api Service
  //sl.registerLazySingleton(() => ApiService(sl()));

  sl.registerSingletonAsync<DeviceInfo>(() async => await DeviceInfo.createDeviceInfo());
  await sl.isReady<DeviceInfo>();

  sl.registerLazySingleton(() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)));

  sl.registerLazySingleton<ILocalService>(() => LocalService(sl()));

  // Image Service
  sl.registerLazySingleton<IImageService>(() => ImageService());
}
