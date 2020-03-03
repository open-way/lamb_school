import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lamb_school/models/hijo_model.dart';
import 'package:lamb_school/models/test_https_model.dart';
import 'package:lamb_school/services/test-https.service.dart';
import 'package:lamb_school/widgets/drawer.dart';

class TestHttpsPage extends StatefulWidget {
  TestHttpsPage({Key key, this.testHttpsService, @required this.storage})
      : super(key: key);

  static const String routeName = '/test_https';
  final TestHttpsService testHttpsService;
  final FlutterSecureStorage storage;

  @override
  _TestHttpsPageState createState() => _TestHttpsPageState();
}

class _TestHttpsPageState extends State<TestHttpsPage> {
  HijoModel _currentChildSelected;

  @override
  void initState() {
    super.initState();
    this._loadMaster();
  }

  Future _loadMaster() async {
    await this._loadChildSelectedStorageFlow();

    // Usar todos los metodos que quieran al hijo actual.
  }
  
  Future _loadChildSelectedStorageFlow() async {
    var childSelected = await widget.storage.read(key: 'child_selected');
    this._currentChildSelected =
        new HijoModel.fromJson(jsonDecode(childSelected));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        storage: widget.storage,
        onChangeNewChildSelected: (HijoModel childSelected) {
          this._currentChildSelected = childSelected;
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text('Test Https'),
      ),
      // body: ContactList());
      body: Card(
        child: FutureBuilder(
            future: widget.testHttpsService.testHttps$(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TestHttpsModel>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                print('Has errors');
                // return Text(snapshot.error);
                // print(snapshot.data);
              }
              if (snapshot.hasData) {
                for (final persona in snapshot.data) {
                  print(persona.email);
                  return Text(persona.email);
                }
                // print(snapshot.data.);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
