import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lamb_school/models/hijo_model.dart';
import 'package:lamb_school/widgets/drawer.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

class GenerateBarcodePage extends StatefulWidget {
  GenerateBarcodePage({
    Key key,
    @required this.storage,
  }) : super(key: key);

  final FlutterSecureStorage storage;
  static const String routeName = '/generate_barcode';

  @override
  _GenerateBarcodePageState createState() => _GenerateBarcodePageState();
}

class _GenerateBarcodePageState extends State<GenerateBarcodePage> {
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
    print(childSelected);
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
        title: Text('Código de barras'),
      ),
      body: Center(
        child: Card(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                // leading: Icon(Icons.album),
                title: Text(_currentChildSelected?.numDoc ?? ''),
                subtitle: Text(
                    '${_currentChildSelected?.nombre ?? ''} ${_currentChildSelected?.paterno ?? ''} ${_currentChildSelected?.materno ?? ''}'),
              ),
              new BarCodeImage(
                params: Code39BarCodeParams(
                  _currentChildSelected?.numDoc ?? '',
                  lineWidth:
                      2.0, // width for a single black/white bar (default: 2.0)
                  barHeight:
                      90.0, // height for the entire widget (default: 100.0)
                  withText:
                      true, // Render with text label or not (default: false)
                ),
                onError: (error) {
                  // Error handler
                  print('error bar-code = $error');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
