import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:lamb_school/enums/enum.dart';
import 'package:lamb_school/models/agenda_model.dart';
import 'package:lamb_school/models/hijo_model.dart';
import 'package:lamb_school/models/response_dialog_model.dart';
import 'package:lamb_school/pages/agenda_page/filter_periodo_aca_dialog.dart';
import 'package:lamb_school/services/periodos-academicos.service.dart';
import 'package:lamb_school/services/portal-padres.service.dart';
import 'package:lamb_school/widgets/drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatefulWidget {
  static const String routeName = '/agenda';

  AgendaPage({
    Key key,
    @required this.storage,
  }) : super(key: key);

  final FlutterSecureStorage storage;

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> with TickerProviderStateMixin {
  final PortalPadresService portalPadresService = new PortalPadresService();
  final PeriodosAcademicosService _periodoAcaService =
      new PeriodosAcademicosService();
  GlobalKey<RefreshIndicatorState> refreshKey;
  final Map<DateTime, List> _agendaEventos = new Map();
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final Map<String, String> queryParams = new Map();
  String _currentIdChildSelected;
  String _currentNameChildSelected;
  String _idPeriodoAcademico;
  String _idAnho;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    final _selectedDay = DateTime.now();

    _selectedEvents = _agendaEventos[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    this._loadMaster();
  }

  void _loadMaster() async {
    await this._loadChildSelectedStorageFlow();

    // Usar todos los metodos que quieran al hijo actual.
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Agenda'),
      centerTitle: true,
      bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              this._currentNameChildSelected ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width - 2, 40)),
      actions: <Widget>[
        IconButton(
          //alignment: CrossAxisAlignment.center,
          icon: Icon(Icons.filter_list),
          onPressed: _showDialog,
        ),
      ],
    );
    return Scaffold(
      drawer: AppDrawer(
        storage: widget.storage,
        onChangeNewChildSelected: (HijoModel childSelected) async {
          this._currentIdChildSelected = childSelected.idAlumno;
          this.queryParams['id_alumno'] = this._currentIdChildSelected;
          this._currentNameChildSelected = childSelected.nombre;
          await _loadChildSelectedStorageFlow();
        },
      ),
      appBar: appBar,
      body: RefreshIndicator(
        displacement: 2,
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: _calendarBox(appBar.preferredSize.height),
      ),
    );
  }

  Widget _calendarBox(double appBarHeight) {
    return new FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
        controller: _controllerTwo,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height - appBarHeight,
              child: Column(
                children: <Widget>[
                  scrollWidget(),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildEventList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    await _loadChildSelectedStorageFlow();
    return null;
  }

  Future _loadChildSelectedStorageFlow() async {
    var now = new DateTime.now();
    DateTime selectedDay = now;
    var childSelected = await widget.storage.read(key: 'child_selected');
    var currentChildSelected =
        new HijoModel.fromJson(jsonDecode(childSelected));
    this._currentIdChildSelected = currentChildSelected.idAlumno;
    this._currentNameChildSelected =
        this._currentNameChildSelected ?? currentChildSelected.nombre;
    var listaPeriodos = await this
        ._periodoAcaService
        .getAll$({'id_alumno': _currentIdChildSelected});
    if (this.queryParams['id_alumno'] == null) {
      this.queryParams['id_alumno'] = this._currentIdChildSelected;
    }
    if (this.queryParams['id_periodo'] == null) {
      this.queryParams['id_periodo'] = listaPeriodos[0].idPeriodo;
    }
    this._idPeriodoAcademico =
        this._idPeriodoAcademico ?? this.queryParams['id_periodo'];
    try {
      this._idAnho =
          listaPeriodos[int.parse(this._idPeriodoAcademico)].anhoPeriodo;
    } catch (e) {
      print('Error: $e');
    }
    if (int.parse(this._idAnho ?? '${now.year}') == now.year) {
      selectedDay = now;
    } else {
      selectedDay = DateTime(int.parse(this._idAnho), 1, 1, 0, 0);
    }
    try {
      _calendarController.setSelectedDay(selectedDay);
    } catch (e) {
      print('Error calendar controller: $e');
    }
    setState(() {});
  }

  final ScrollController _controllerOne = ScrollController();
  final ScrollController _controllerTwo = ScrollController();

  Widget scrollWidget() {
    return new Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: CupertinoScrollbar(
          controller: _controllerOne,
          child: ListView.builder(
            controller: _controllerOne,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) => Column(
              children: <Widget>[futureBuildCalendar(context)],
            ),
          )),
    );
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  _getEventosDays(List<AgendaModel> agenda) {
    _agendaEventos.clear();
    for (var i = 0; i < agenda.length; i++) {
      var listDays = [];
      listDays.clear();
      listDays = getDates(i, agenda);
      var days = calculateDaysInterval(listDays[0], listDays[1]);
      for (var c = 0; c < days.length; c++) {
        if (_agendaEventos[days[c]] != null) {
          _agendaEventos[days[c]].add(agenda[i].idActividad);
        } else {
          _agendaEventos[days[c]] = [agenda[i].idActividad];
        }
      }
    }
    return _agendaEventos;
  }

  Widget futureBuildCalendar(BuildContext context) {
    return new FutureBuilder(
        future: portalPadresService.getAgenda(this.queryParams),
        builder: (context, AsyncSnapshot<List<AgendaModel>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            List<AgendaModel> agenda = snapshot.data;
            return _buildTableCalendar(agenda);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar(List<AgendaModel> agenda) {
    return TableCalendar(
      calendarController: _calendarController,
      events: _getEventosDays(agenda),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, events) {
          return _dayBuilder(date, events, Colors.black);
        },
        weekendDayBuilder: (context, date, events) {
          return _dayBuilder(date, events, Colors.black45);
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          var childWidget = <Widget>[];
          if (events.isNotEmpty) {
            var eventsList = events.toList();
            for (var i = 0; i < agenda.length; i++) {
              for (var c = 0; c < eventsList.length; c++) {
                if (eventsList[c] == agenda[i].idActividad) {
                  childWidget.add(_buildEventsMarker(
                      [eventsList[c]], agenda[i].categoriaColor));
                }
              }
              if (childWidget.length > 4) {
                childWidget = childWidget.sublist(0, 4);
              }
            }
            var containerRow = Row(
              children: childWidget,
              mainAxisAlignment: MainAxisAlignment.center,
            );
            children.add(containerRow);
          }
          return children;
        },
      ),
      onDaySelected: _onDaySelected,
    );
  }

  Widget _dayBuilder(DateTime date, List events, Color txtColor) {
    var asisColor;
    if (events != null) {
      asisColor = Colors.black12;
    }
    return Container(
      decoration: BoxDecoration(
        color: asisColor,
        shape: BoxShape.circle,
      ),
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      width: 100,
      height: 100,
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle().copyWith(fontSize: 16.0, color: txtColor),
        ),
      ),
    );
  }

  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  Widget _buildEventsMarker(List events, String color) {
    if (events.isNotEmpty) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Color(hexStringToHexInt(color))),
        width: 10.0,
        height: 10.0,
      );
    } else {
      return null;
    }
  }

  _getDetalleActividad(String idActividad, List<AgendaModel> listaActividades) {
    for (var i = 0; i < listaActividades.length; i++) {
      if (idActividad == listaActividades[i].idActividad) {
        return '"' +
            listaActividades[i].categoriaNombre +
            '": ' +
            listaActividades[i].nombre;
      }
    }
  }

  List getDates(int i, List<AgendaModel> listaActividades) {
    DateTime startParseDate = DateTime.parse(listaActividades[i].fechaInicio);
    DateTime endParseDate = DateTime.parse(listaActividades[i].fechaFinal);
    DateTime startDate = DateTime(startParseDate.year, startParseDate.month,
        startParseDate.day, 0, 0, 0, 0, 0);
    DateTime endDate = DateTime(
        endParseDate.year, endParseDate.month, endParseDate.day, 0, 0, 0, 0, 0);
    return [startDate, endDate, startParseDate, endParseDate];
  }

  _showDetalleActividadAlert(
      String idActividad, List<AgendaModel> listaActividades) {
    int getId;
    for (var i = 0; i < listaActividades.length; i++) {
      if (idActividad == listaActividades[i].idActividad) {
        getId = i;
      }
    }
    var dayList = getDates(getId, listaActividades);
    var rangoFechas;
    var rangoHoras;
    final formatoFecha = new DateFormat('EE dd, MM');
    final formatoHora = new DateFormat('HH:mm');
    if (dayList[0] == dayList[1]) {
      rangoFechas = formatoFecha.format(dayList[2]).toString();
    } else {
      rangoFechas = formatoFecha.format(dayList[2]).toString() +
          ' - ' +
          formatoFecha.format(dayList[3]).toString();
    }
    rangoHoras = formatoHora.format(dayList[2]).toString() +
        ' - ' +
        formatoHora.format(dayList[3]).toString();

    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );
    var nivel = listaActividades[getId].nivel ?? '';
    var grado = listaActividades[getId].grado ?? '';
    var nivelGrado;
    if (grado != '') {
      nivelGrado = nivel + ': ' + grado;
    } else {
      nivelGrado = '';
    }
    var seccion = listaActividades[getId].seccion ?? '';
    var curso = listaActividades[getId].curso ?? '';
    return new Alert(
        context: context,
        style: alertStyle,
        title: listaActividades[getId].categoriaNombre,
        content: Column(
          children: <Widget>[
            Text(rangoFechas),
            Text(rangoHoras),
            Text(listaActividades[getId].nombre),
            Text(listaActividades[getId].descripcion),
            Text(nivelGrado + ' ' + seccion),
            Text(curso),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget _buildEventList() {
    return new FutureBuilder(
        future: portalPadresService.getAgenda(this.queryParams),
        builder: (context, AsyncSnapshot<List<AgendaModel>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            List<AgendaModel> agenda = snapshot.data;
            return ListView(
              children: _selectedEvents
                  .map((event) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          title: Text(_getDetalleActividad(event, agenda)),
                          onTap: () =>
                              {_showDetalleActividadAlert(event, agenda)},
                        ),
                      ))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future _showDialog() async {
    if (this._currentIdChildSelected != null) {
      ResponseDialogModel response = await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text('Filtrar'),
          children: <Widget>[
            new FilterPeriodoAcaDialog(
              idAlumno: this._currentIdChildSelected,
              idPeriodoDefault: this._idPeriodoAcademico,
            ),
          ],
        ),
      );

      switch (response?.action) {
        case DialogActions.SUBMIT:
          if (response.data != null) {
            this._idPeriodoAcademico = response.data;
            this.queryParams['id_periodo'] = _idPeriodoAcademico;
            await this._loadChildSelectedStorageFlow();
          }
          break;
        default:
      }
    }
  }
}
