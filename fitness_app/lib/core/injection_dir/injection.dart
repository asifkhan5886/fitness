import 'package:fitness_app/core/local_hive/pref_box.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> configureDependencies() async {
  /// Hive need a path for storing the data. Note: Web doesn't require
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  locator.registerSingletonAsync(
    () => PrefBox.getInstance(),
  );

}
