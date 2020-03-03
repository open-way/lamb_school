import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lamb_school/enums/enum.dart';
import 'package:lamb_school/models/hijo_model.dart';
import 'package:lamb_school/models/operation_model.dart';
import 'package:lamb_school/models/response_dialog_model.dart';
import 'package:lamb_school/pages/estado_cuenta_page/operation_detail.dart';
import 'package:lamb_school/services/portal-padres.service.dart';
import 'package:lamb_school/widgets/drawer.dart';
import 'package:lamb_school/widgets/filter_anho_dialog.dart';

class EstadoCuentaPage extends StatefulWidget {
  static const String routeName = '/estado_cuenta';

  EstadoCuentaPage({Key key, @required this.storage}) : super(key: key);
  final FlutterSecureStorage storage;

  @override
  _EstadoCuentaPageState createState() => _EstadoCuentaPageState();
}

class _EstadoCuentaPageState extends State<EstadoCuentaPage> {
  final PortalPadresService portalPadresService = new PortalPadresService();

  List<dynamic> _listaOperations;
  OperationTotalModel _operationsTotal;

  HijoModel _currentChildSelected;

  String idAnho;

  @override
  void initState() {
    super.initState();
    this._loadMaster();
  }

  Future _loadMaster() async {
    await this._loadChildSelectedStorageFlow();
    // Usar todos los metodos que quieran al hijo actual.
    this.getOperations();
  }

  getOperations() {
    var now = new DateTime.now();
    this.idAnho = this.idAnho ?? now.year.toString();

    this._listaOperations = [];
    var queryParameters = {
      'id_anho': this.idAnho,
      'id_alumno': this._currentChildSelected.idAlumno,
    };
    this.portalPadresService.getEstadoCuenta$(queryParameters).then((onValue) {
      _listaOperations = onValue?.movements ?? [];
      _operationsTotal = onValue.movementsTotal;

      print('_operationsTotal');
      print('_operationsTotal');
      print('_operationsTotal');
      print(_operationsTotal.total);

      setState(() {});
    }).catchError((err) {
      print(err);
    });
  }

  Future _loadChildSelectedStorageFlow() async {
    var childSelected = await widget.storage.read(key: 'child_selected');
    this._currentChildSelected =
        new HijoModel.fromJson(jsonDecode(childSelected));
    setState(() {});
  }

  Future<Null> _handleRefresh() async {
    this.getOperations();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(
        storage: widget.storage,
        onChangeNewChildSelected: (HijoModel childSelected) {
          this._currentChildSelected = childSelected;
          this.getOperations();
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text('Estado cuenta'),
        centerTitle: true,
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                this._currentChildSelected?.nombre ?? '',
                style: TextStyle(color: Colors.white),
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width - 2, 40)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showDialog,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new Card(
              child: new Container(
                padding: new EdgeInsets.all(15),
                child: new RefreshIndicator(
                  child: new OperationsList(
                    listaOperations: this._listaOperations ?? [],
                  ),
                  onRefresh: _handleRefresh,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _showDialog() async {
    if (this._currentChildSelected?.idAlumno != null) {
      ResponseDialogModel response = await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Filtrar'),
          children: <Widget>[
            new FilterAnhoDialog(
              idAlumno: this._currentChildSelected.idAlumno,
              idAnhoDefault: this.idAnho,
            ),
          ],
        ),
      );

      switch (response?.action) {
        case DialogActions.SUBMIT:
          print('SUBMIT');
          this.idAnho = response.data;
          this.getOperations();
          break;
        default:
          print('default');
      }
    }
  }
}

class OperationsList extends StatefulWidget {
  final List<dynamic> listaOperations;

  OperationsList({Key key, @required this.listaOperations}) : super(key: key);
  @override
  _OperationsListState createState() => _OperationsListState();
}

class _OperationsListState extends State<OperationsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView(
        children: widget.listaOperations
            .map(
              (dynamic operacion) => ListTile(
                title: Text(operacion['glosa']),
                subtitle: Text("${operacion['fecha']}"),
                trailing: Text('S/. ${operacion['total'].toString()}'),
                leading: CircleAvatar(child: Icon(Icons.check_box)),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OperationDetail(
                      operation: operacion,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
