import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/keys.dart';

//Storage
class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();

    /*this line of code will check if we already have data stored in the
    local storage with the key we defined. If there is already data, this will be skipped. 
    If not, an empty list will be initialized.
    */
    await _box.writeIfNull(taskKey, []);

    //this will return the storage service instance
    return this;
  }

  //READ: Generic Type. This will return data in the storage given a key.
  T read<T>(String key) {
    return _box.read(key);
  }

  //WRITE:
  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
