import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shop/pages_components/admin.dart';

class AdminService {
  Future<List<Admin>> loadAdmins() async {
    final String response = await rootBundle.loadString('lib/data_base/staff.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Admin.fromJson(json)).toList();
  }
}
