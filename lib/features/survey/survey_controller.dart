import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/income_entry.dart';
import 'models/survey_model.dart';
import 'services/location_service.dart';

class SurveyController extends ChangeNotifier {
  SurveyController({required this.locationService}) {
    _initControllers();
  }

  final LocationService locationService;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _checkboxes = {
    'a36': false,
    'a37': false,
    'a41': false,
    'a42': false,
    'a46': false,
    'a47': false,
    'a48': false,
    'a49': false,
    'a53': false,
    'a55': false,
    'a56': false,
    'a81': false,
    'a84': false,
    'a87': false,
    'a90': false,
  };

  final List<IncomeEntry> _incomes = [];
  final List<List<int>> _fechaList = [];
  String fecha = '';
  String latestLatitud = '';
  String latestLongitud = '';

  int get numeroDeIngresos => _incomes.length;
  UnmodifiableListView<IncomeEntry> get incomes => UnmodifiableListView(_incomes);
  UnmodifiableListView<List<int>> get fechaList => UnmodifiableListView(_fechaList);

  TextEditingController controllerFor(String key) => _controllers[key]!;

  bool checkboxValue(String key) => _checkboxes[key] ?? false;

  void setCheckbox(String key, bool value) {
    _checkboxes[key] = value;
    notifyListeners();
  }

  void disposeControllers() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
  }

  void setMainDate(DateTime date) {
    fecha = DateFormat('dd/MM/yyyy').format(date);
    notifyListeners();
  }

  void setIngresoDate(int index, DateTime date) {
    _checkAndAddAtIndex(_fechaList, index);
    _fechaList[index] = [date.day, date.month, date.year];
    notifyListeners();
  }

  bool addIngresoFromFields({required int empleoNumero, required int ocupacionNumero}) {
    if (_incomes.length >= 4) {
      return false;
    }
    final nombreValue = controllerFor('a57').text;
    final empleoValue = radioCheck(controllerFor('a58').text);
    final ocupacionValue = radioCheck(controllerFor('a59').text);
    final telefonoValue = controllerFor('a60').text;
    final ingresosValue = controllerFor('a61').text;
    final domicilioValue = controllerFor('a62').text;
    final lugarValue = controllerFor('a64').text;

    _incomes.add(
      IncomeEntry(
        nombre: nombreValue,
        empleo: empleoValue,
        empleoNumero: empleoNumero,
        ocupacion: ocupacionValue,
        ocupacionNumero: ocupacionNumero,
        telefono: telefonoValue,
        ingresos: ingresosValue,
        domicilio: domicilioValue,
        lugar: lugarValue,
      ),
    );

    controllerFor('a57').clear();
    controllerFor('a58').clear();
    controllerFor('a59').clear();
    controllerFor('a60').clear();
    controllerFor('a61').clear();
    controllerFor('a62').clear();
    controllerFor('a64').clear();
    notifyListeners();
    return true;
  }

  bool loadPreviousIngreso() {
    if (_incomes.isEmpty) {
      return false;
    }
    final last = _incomes.removeLast();
    controllerFor('a57').text = last.nombre;
    controllerFor('a58').text = last.empleo;
    controllerFor('a59').text = last.ocupacion;
    controllerFor('a60').text = last.telefono;
    controllerFor('a61').text = last.ingresos;
    controllerFor('a62').text = last.domicilio;
    controllerFor('a64').text = last.lugar;
    notifyListeners();
    return true;
  }

  Future<SurveySubmissionResult> submitSurvey() async {
    final formData1 = _getFormData1();
    if (_getOrDefault(formData1, 'a2').isEmpty) {
      return SurveySubmissionResult.failure('INGRESAR DNI TITULAR');
    }
    final location = await locationService.fetchLocation();
    if (location == null) {
      return SurveySubmissionResult.failure('NO GPS');
    }
    latestLatitud = location.latitude.toString();
    latestLongitud = location.longitude.toString();
    final model = buildSurveyModel();
    debugPrint('SURVEY SAVED: ${model.toMap()}');
    return SurveySubmissionResult.success('SQL GUARDADO');
  }

  SurveyModel buildSurveyModel() {
    final formData1 = _getFormData1();
    final formData2 = _getFormData2();
    final formData3 = _getFormData3();
    final formData4 = _getFormData4();
    final formData5 = _getFormData5();
    final formData6 = _getFormData6();
    final formData7 = _getFormData7();

    final escolaridad = _buildEscolaridad(formData3);

    final values = <String, String>{
      ...formData1,
      ...formData2,
      ...formData3,
      ...formData4,
      ...formData5,
      ...formData6,
      ...formData7,
      'fechaInforme': _getCurrentDate(),
      'escolaridad': escolaridad,
      'ingreso1': _getIncomeValue((entry) => entry.ingresos, 0),
      'ingreso2': _getIncomeValue((entry) => entry.ingresos, 1),
      'ingreso3': _getIncomeValue((entry) => entry.ingresos, 2),
      'ingreso4': _getIncomeValue((entry) => entry.ingresos, 3),
      'nombreingreso1': _getIncomeValue((entry) => entry.nombre, 0),
      'nombreingreso2': _getIncomeValue((entry) => entry.nombre, 1),
      'nombreingreso3': _getIncomeValue((entry) => entry.nombre, 2),
      'nombreingreso4': _getIncomeValue((entry) => entry.nombre, 3),
      'categorialaboral1': _getIncomeValue((entry) => entry.empleo, 0),
      'categorialaboral2': _getIncomeValue((entry) => entry.empleo, 1),
      'categorialaboral3': _getIncomeValue((entry) => entry.empleo, 2),
      'categorialaboral4': _getIncomeValue((entry) => entry.empleo, 3),
      'ocupacion1': _getIncomeValue((entry) => entry.ocupacion, 0),
      'ocupacion2': _getIncomeValue((entry) => entry.ocupacion, 1),
      'ocupacion3': _getIncomeValue((entry) => entry.ocupacion, 2),
      'ocupacion4': _getIncomeValue((entry) => entry.ocupacion, 3),
      'telefono1': _getIncomeValue((entry) => entry.telefono, 0),
      'telefono2': _getIncomeValue((entry) => entry.telefono, 1),
      'telefono3': _getIncomeValue((entry) => entry.telefono, 2),
      'telefono4': _getIncomeValue((entry) => entry.telefono, 3),
      'domicilio1': _getIncomeValue((entry) => entry.domicilio, 0),
      'domicilio2': _getIncomeValue((entry) => entry.domicilio, 1),
      'domicilio3': _getIncomeValue((entry) => entry.domicilio, 2),
      'domicilio4': _getIncomeValue((entry) => entry.domicilio, 3),
      'lugar1': _getIncomeValue((entry) => entry.lugar, 0),
      'lugar2': _getIncomeValue((entry) => entry.lugar, 1),
      'lugar3': _getIncomeValue((entry) => entry.lugar, 2),
      'lugar4': _getIncomeValue((entry) => entry.lugar, 3),
      'fechadelrecibo1': _fechaOrEmpty(0),
      'fechadelrecibo2': _fechaOrEmpty(1),
      'fechadelrecibo3': _fechaOrEmpty(2),
      'fechadelrecibo4': _fechaOrEmpty(3),
    };

    return SurveyModel(
      values: values,
      informelatitud: latestLatitud,
      informelongitud: latestLongitud,
    );
  }

  String _fechaOrEmpty(int index) {
    if (index < _fechaList.length) {
      final parts = _fechaList[index];
      if (parts.length == 3) {
        return '${parts[0]}/${parts[1]}/${parts[2]}';
      }
    }
    return '0/0/0';
  }

  String _getIncomeValue(String Function(IncomeEntry entry) selector, int index) {
    if (index >= 0 && index < _incomes.length) {
      return selector(_incomes[index]);
    }
    return '';
  }

  Map<String, String> _getFormData1() {
    return {
      'a1': controllerFor('a1').text,
      'a2': controllerFor('a2').text,
      'a3': controllerFor('a3').text,
      'a4': controllerFor('a4').text,
      'a5': controllerFor('a5').text,
      'a6': controllerFor('a6').text,
      'a7': radioCheck(controllerFor('a7').text),
      'a8': controllerFor('a8').text,
      'a9': controllerFor('a9').text,
      'a10': radioCheck(controllerFor('a10').text),
      'a11': radioCheck(controllerFor('a11').text),
      'a12': controllerFor('a12').text,
      'a13': controllerFor('a13').text,
      'a14': controllerFor('a14').text,
      'a15': controllerFor('a15').text,
      'a16': controllerFor('a16').text,
      'a17': controllerFor('a17').text,
      'a19': controllerFor('a19').text,
    };
  }

  Map<String, String> _getFormData2() {
    return {
      'a20': controllerFor('a20').text,
      'a21': controllerFor('a21').text,
      'a22': controllerFor('a22').text,
      'a23': controllerFor('a23').text,
      'a24': controllerFor('a24').text,
      'a25': controllerFor('a25').text,
      'a26': controllerFor('a26').text,
      'a27': controllerFor('a27').text,
    };
  }

  Map<String, String> _getFormData3() {
    return {
      'a28': controllerFor('a28').text,
      'a29': controllerFor('a29').text,
      'a30': controllerFor('a30').text,
      'a31': controllerFor('a31').text,
      'a32': controllerFor('a32').text,
      'a33': controllerFor('a33').text,
      'a34': controllerFor('a34').text,
      'a35': controllerFor('a35').text,
      'a36': _checkboxes['a36'].toString(),
      'a37': _checkboxes['a37'].toString(),
      'a41': _checkboxes['a41'].toString(),
      'a42': _checkboxes['a42'].toString(),
      'a38': radioCheck(controllerFor('a38').text),
      'a39': radioCheck(controllerFor('a39').text),
      'a40': controllerFor('a40').text,
    };
  }

  Map<String, String> _getFormData4() {
    return {
      'a43': controllerFor('a43').text,
      'a49': _checkboxes['a49'].toString(),
      'a50': controllerFor('a50').text,
      'a45': controllerFor('a45').text,
      'a46': _checkboxes['a46'].toString(),
      'a47': _checkboxes['a47'].toString(),
      'a48': _checkboxes['a48'].toString(),
      'a51': controllerFor('a51').text,
      'a52': controllerFor('a52').text,
      'a53': _checkboxes['a53'].toString(),
      'a55': _checkboxes['a55'].toString(),
      'a56': _checkboxes['a56'].toString(),
      'a54': controllerFor('a54').text,
      'a44': controllerFor('a44').text,
    };
  }

  Map<String, String> _getFormData5() {
    return {
      'a65': controllerFor('a65').text,
      'a66': controllerFor('a66').text,
      'a67': controllerFor('a67').text,
      'a68': radioCheck(controllerFor('a68').text),
      'a69': controllerFor('a69').text,
      'a70': controllerFor('a70').text,
      'a71': controllerFor('a71').text,
      'a72': radioCheck(controllerFor('a72').text),
      'a73': controllerFor('a73').text,
      'a74': controllerFor('a74').text,
      'a75': controllerFor('a75').text,
      'a76': controllerFor('a76').text,
      'a77': controllerFor('a77').text,
      'a78': controllerFor('a78').text,
      'a79': radioCheck(controllerFor('a79').text),
      'a80': controllerFor('a80').text,
    };
  }

  Map<String, String> _getFormData6() {
    return {
      'a81': _checkboxes['a81'].toString(),
      'a82': controllerFor('a82').text,
      'a83': controllerFor('a83').text,
      'a84': _checkboxes['a84'].toString(),
      'a85': controllerFor('a85').text,
      'a86': controllerFor('a86').text,
      'a87': _checkboxes['a87'].toString(),
      'a88': controllerFor('a88').text,
      'a89': controllerFor('a89').text,
      'a90': _checkboxes['a90'].toString(),
      'a91': controllerFor('a91').text,
      'a92': controllerFor('a92').text,
      'a93': controllerFor('a93').text,
    };
  }

  Map<String, String> _getFormData7() {
    return {
      'a94': controllerFor('a94').text,
      'a95': controllerFor('a95').text,
      'a96': controllerFor('a96').text,
      'a97': controllerFor('a97').text,
      'a98': radioCheck(controllerFor('a98').text),
      'a99': controllerFor('a99').text,
      'a100': controllerFor('a100').text,
      'a101': controllerFor('a101').text,
    };
  }

  String _buildEscolaridad(Map<String, String> formData3) {
    var escolaridad = '';
    if (formData3['a36'] == 'true') {
      escolaridad = 'SI';
      if (formData3['a37'] == 'true') {
        escolaridad += ' ESCUELA PUBLICA';
        if (formData3['a41'] == 'true') {
          escolaridad += ' ESCUELA PRIVADA';
          if (formData3['a42'] == 'true') {
            escolaridad += ' GASTOS ESCOLARES';
          }
        }
      }
    }
    return escolaridad;
  }

  void _initControllers() {
    for (final key in _textFieldKeys) {
      _controllers[key] = TextEditingController();
    }
  }

  void _checkAndAddAtIndex(List<List<int>> list, int index) {
    if (index >= list.length) {
      while (list.length <= index) {
        list.add([]);
      }
    }
  }

  String _getCurrentDate() {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(DateTime.now());
  }

  String _getOrDefault(Map<String, String> map, String key) {
    return map[key] ?? '';
  }

  String radioCheck(String text) {
    if (text == 'SELECCIONAR') {
      return '';
    }
    return text;
  }
}

class SurveySubmissionResult {
  SurveySubmissionResult._(this.success, this.message);

  factory SurveySubmissionResult.success(String message) =>
      SurveySubmissionResult._(true, message);

  factory SurveySubmissionResult.failure(String message) =>
      SurveySubmissionResult._(false, message);

  final bool success;
  final String message;
}

const List<String> _textFieldKeys = [
  'a1',
  'a2',
  'a3',
  'a4',
  'a5',
  'a6',
  'a7',
  'a8',
  'a9',
  'a10',
  'a11',
  'a12',
  'a13',
  'a14',
  'a15',
  'a16',
  'a17',
  'a19',
  'a20',
  'a21',
  'a22',
  'a23',
  'a24',
  'a25',
  'a26',
  'a27',
  'a28',
  'a29',
  'a30',
  'a31',
  'a32',
  'a33',
  'a34',
  'a35',
  'a38',
  'a39',
  'a40',
  'a43',
  'a44',
  'a45',
  'a50',
  'a51',
  'a52',
  'a54',
  'a57',
  'a58',
  'a59',
  'a60',
  'a61',
  'a62',
  'a64',
  'a65',
  'a66',
  'a67',
  'a68',
  'a69',
  'a70',
  'a71',
  'a72',
  'a73',
  'a74',
  'a75',
  'a76',
  'a77',
  'a78',
  'a79',
  'a80',
  'a82',
  'a83',
  'a85',
  'a86',
  'a88',
  'a89',
  'a91',
  'a92',
  'a93',
  'a94',
  'a95',
  'a96',
  'a97',
  'a98',
  'a99',
  'a100',
  'a101',
];
