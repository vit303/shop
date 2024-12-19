import 'dart:io';
import 'dart:convert';

class ApartmentService {
  final String filePath = 'lib/data_base/aplications.json';

  Future<void> saveDataToJson(Map<String, dynamic> apartmentData, String filePath) async {
    File jsonFile = File(filePath);
    if (!await jsonFile.exists()) {
      await jsonFile.create();
    }

    List<dynamic> existingData = [];
    if (await jsonFile.length() > 0) {
      String jsonString = await jsonFile.readAsString();
      existingData = json.decode(jsonString);
    }

    existingData.add(apartmentData);
    await jsonFile.writeAsString(json.encode(existingData));
    print('Data successfully saved to $filePath');
  }
}