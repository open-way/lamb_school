import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OperationDetail extends StatelessWidget {
  final dynamic operation;

  OperationDetail({@required this.operation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(operation['glosa']),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Glosa"),
                        subtitle: Text(operation['glosa']),
                      ),
                      // ListTile(
                      //   title: Text("ID"),
                      //   subtitle: Text("${operation.id}"),
                      // ),
                      ListTile(
                        title: Text("Fecha"),
                        subtitle: Text(operation['fecha']),
                      ),
                      ListTile(
                        title: Text("Importe"),
                        subtitle: Text("${operation['total']}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
