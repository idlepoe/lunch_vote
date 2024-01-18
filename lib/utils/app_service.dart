import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppService {
  static Future<String> uploadFileToStorage(XFile? xFile) async {
    String today = DateFormat('yyyyMMddhhmmss').format(DateTime.now());
    String result = "";
    Reference _reference = FirebaseStorage.instance
        .ref()
        .child('images/' + today + "_" + xFile!.name);
    await _reference.putData(await xFile!.readAsBytes());
    result = await _reference.getDownloadURL();
    return result;
  }
}
