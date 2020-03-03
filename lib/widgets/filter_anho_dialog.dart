import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamb_school/enums/enum.dart';
import 'package:lamb_school/models/anho_model.dart';
import 'package:lamb_school/models/response_dialog_model.dart';
import 'package:lamb_school/services/anhos.service.dart';

class FilterAnhoDialog extends StatefulWidget {
  FilterAnhoDialog(
      {Key key, @required this.idAlumno, @required this.idAnhoDefault})
      : super(key: key);
  final String idAlumno;
  final String idAnhoDefault;
  @override
  _FilterAnhoDialogState createState() => _FilterAnhoDialogState();
}

class _FilterAnhoDialogState extends State<FilterAnhoDialog> {
  final AnhosService _anhosService = new AnhosService();

  List<DropdownMenuItem<String>> _listaAnhos;
  String _idAnho;

  @override
  void initState() {
    super.initState();
    this.getMasters();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMasters() {
    this.getAnhos();
    this._idAnho = widget.idAnhoDefault;
  }

  void getAnhos() {
    if (this.widget.idAlumno.isNotEmpty) {
      var query = {
        'id_alumno': this.widget?.idAlumno,
      };
      this._anhosService.getByQuery$(query).then((listSnap) {
        this._listaAnhos = listSnap.map((AnhoModel snap) {
          return DropdownMenuItem(
            value: snap.idAnho,
            child: Text(snap.idAnho),
          );
        }).toList();
        setState(() {});
      }).catchError((err) {
        print(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: InputDecorator(
              decoration: InputDecoration(
                icon: Icon(Icons.date_range),
                labelText: 'Seleccione año',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: this._idAnho,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      this._idAnho = newValue;
                    });
                  },
                  items: this._listaAnhos,
                ),
              ),
            ),
          ),
          new SizedBox(
            width: double.infinity, // match_parent
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Filtrar'),
              onPressed: () {
                if (this._idAnho.isNotEmpty) {
                  var responseDialog = new ResponseDialogModel(
                      action: DialogActions.SUBMIT, data: this._idAnho);
                  Navigator.pop(context, responseDialog);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
