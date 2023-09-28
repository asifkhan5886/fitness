import 'package:hive/hive.dart';
import 'hive_keys.dart';
import 'user_details.dart';

class PrefBox {
  static PrefBox? _instance;
  static Box? box;

  final String _keyIsAudioPlay = "is_audioPlay";
  final String _keyItemIds = "item_ids";
  final String _keyUserPayload = "user_payload";


  static Future<PrefBox> getInstance() async {
    _instance ??= PrefBox();

    if (!Hive.isBoxOpen(HiveKeys.prefBoxName)) {
      box = await Hive.openBox(HiveKeys.prefBoxName);
    } else {
      box = Hive.box(HiveKeys.prefBoxName);
    }

    return _instance ?? PrefBox();
  }
  UserDetails get userPayload {
    return box?.get(_keyUserPayload, defaultValue: UserDetails());
  }

  set userPayload(UserDetails? userPayload) {
    box?.put(_keyUserPayload, userPayload);
  }

  set setItemIds(List<String> itemIds) {
    box?.put(_keyItemIds, itemIds);
  }

  List<String> get getItemIds {
    return box?.get(_keyItemIds, defaultValue: <String>[]);
  }

  bool get isAudioPlay {
    return box?.get(_keyIsAudioPlay, defaultValue: true);
  }

  set isAudioPlay(bool isAudioPlay) {
    box?.put(_keyIsAudioPlay, isAudioPlay);
  }
}
