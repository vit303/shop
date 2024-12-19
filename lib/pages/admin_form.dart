import 'package:flutter/material.dart';
import 'package:shop/pages_components/admin.dart';
import 'package:shop/pages_components/admin_service.dart';

class AdminForm extends StatefulWidget {
  final Function(bool) onAdminChecked;

  AdminForm({required this.onAdminChecked});

  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _id = 0;
  String _code = '';
  late Future<List<Admin>> _adminsFuture;

  @override
  void initState() {
    super.initState();
    _adminsFuture = AdminService().loadAdmins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Form'),
      ),
      body: FutureBuilder<List<Admin>>(
        future: _adminsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No admins available.'));
          } else {
            final admins = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'ID'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ID';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _id = int.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Code'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your code';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _code = value;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Проверка введенных данных
                          bool isValidAdmin = admins.any((admin) =>
                              admin.name == _name &&
                              admin.id == _id &&
                              admin.code == _code);

                          // Передача результата проверки на HomePage
                          widget.onAdminChecked(isValidAdmin);

                          // Вернуться на предыдущий экран
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
