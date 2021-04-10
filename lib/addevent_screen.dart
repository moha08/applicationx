import 'package:applicationx/beans/event.dart';
import 'package:applicationx/Eventhome_screen.dart';
import 'package:applicationx/event_screen.dart';
import 'package:button_picker/button_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_days_week/select_days_week_controller.dart';
import 'package:select_days_week/select_days_week_widget.dart';
import 'backend/teams.dart';
import 'beans/team.dart';
import 'backend/events.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'show_dialog.dart';

class AddeventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    toggleableActiveColor: shrinePink400,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;

class MyTextFieldDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;

  MyTextFieldDatePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    @required this.lastDate,
    @required this.firstDate,
    @required this.initialDate,
    @required this.onDateChanged,
  })  : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!initialDate.isBefore(firstDate),
            'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate),
            'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  _MyTextFieldDatePicker createState() => _MyTextFieldDatePicker();
}

class _MyTextFieldDatePicker extends State<MyTextFieldDatePicker> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;
  Duration _duration = Duration(hours: 0, minutes: 0);
  var textInput = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = DateFormat.MMMEd();
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    _controllerDate.text = _dateFormat.format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}

class _State extends State<AddeventPage> {
  DateTime selectedDateTime;
  bool pressed = false;
  bool recVal = false;
  TextEditingController _eventNameController = TextEditingController();
  TimeOfDay _fromtime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _totime = TimeOfDay(hour: 7, minute: 15);
  TextEditingController _locationNameController = TextEditingController();
  int _teamSizeValue = 1;
  double _closeEventBefore = 0;

  bool _validate_eventName = false;

  String _team = "-99";

  Future<List<DropdownMenuItem<String>>> getTeams() async {
    List<Team> _items = List<Team>();
    _items = await Teams().getTeams();

    // your list of DropDownMenuItem
    List<DropdownMenuItem<String>> menuItems = List();

    menuItems.add(DropdownMenuItem<String>(
      // items[key] this instruction get the value of the respective key
      child: Text("Select Your Team"), // the value as text label
      value: "-99", // the respective key as value
    ));

    // loop in the map and getting all the keys
    for (Team team in _items) {
      menuItems.add(DropdownMenuItem<String>(
        // items[key] this instruction get the value of the respective key
        child: Text(team.name), // the value as text label
        value: team.teamCode, // the respective key as value
      ));
    }
    return menuItems;
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    setState(() {});
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _fromtime,
    );
    if (newTime != null) {
      setState(() {
        _fromtime = newTime;
      });
    }
  }

  void _selectToTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _totime,
    );
    if (newTime != null) {
      setState(() {
        _totime = newTime;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textInput;

    return Scaffold(
      appBar: AppBar(
        title: Text('NEW EVENT'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EventHomePage()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _validate_eventName = false;
                  });
                },
                obscureText: false,
                controller: _eventNameController,
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'Please enter event name',
                  errorText:
                      _validate_eventName ? 'Value Can\'t Be Empty' : null,
                  //suffixIcon: Icon(Icons.contact_page),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Event Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              //color: Colors.orangeAccent,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: Colors.green[50],
                        //elevation: 8,
                        isExpanded: true,
                        value: _teamSizeValue,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Select Team Size',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                              //  fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '5 VS 5',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '6 VS 6',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '7 VS 7',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '8 VS 8',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '9 VS 9',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '10 VS 10',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              '11 VS 11',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 8,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _teamSizeValue = value;
                            print(_teamSizeValue);
                          });
                        }),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: MyTextFieldDatePicker(
                labelText: "Date",
                prefixIcon: Icon(Icons.date_range),
                suffixIcon: Icon(Icons.arrow_drop_down),
                lastDate: DateTime.now().add(Duration(days: 366)),
                firstDate: DateTime.now(),
                initialDate: DateTime.now().add(Duration(days: 1)),
                onDateChanged: (selectedDate) {
                  setState(() {
                    selectedDateTime = selectedDate;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text('Select Start Time'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start Time: ${_fromtime.format(context)}',
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _selectToTime,
                    child: Text('Select End Time'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'End Time: ${_totime.format(context)}',
                  ),
                ],
              ),
            ),
            /*   Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "      Recurrence",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
                Checkbox(
                  value: recVal,
                  onChanged: (bool value) {
                    setState(() {
                      recVal = value;
                    });
                  },
                ),
              ],
            ),*/
            /* Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SelectDaysWeekWidget(
                SelectDaysWeekController(
                    // unSelectableDays: [1, 2, 3, 4, 5, 6, 7],
                    ),
                color: Colors.green,
                singleDay: false,
                validatorDay: (int day) async {
                  return day != 0;
                },
                daySelected: (int day) {
                  print(day);
                },
              ),
            ),*/
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                obscureText: false,
                controller: _locationNameController,
                decoration: InputDecoration(
                  hintText: 'Please enter location name',
                  //suffixIcon: Icon(Icons.contact_page),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Location Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              //color: Colors.orangeAccent,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: TestWidget(context),
                  ),
                ),
              ),
            ),
            /* Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),*/
            /*   Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                "     Close Event Before:",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
                //  fontWeight: FontWeight.bold),
                // textAlign: TextAlign.center,
              ),
              ButtonPicker(
                minValue: 0,
                maxValue: 24,
                initialValue: _closeEventBefore,
                onChanged: (val) {
                  setState(() {
                    _closeEventBefore = val;
                  });
                },
                step: 1,
                horizontal: false,
                loop: true,
                padding: 0.0,
                iconUp: Icons.keyboard_arrow_up,
                iconDown: Icons.keyboard_arrow_down,
                iconLeft: Icons.keyboard_arrow_left,
                iconRight: Icons.keyboard_arrow_right,
                iconUpRightColor: Colors.green,
                iconDownLeftColor: Colors.green,
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              ),
              Text(
                " Hours ",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
                //  fontWeight: FontWeight.bold),
                // textAlign: TextAlign.center,
              ),
            ]),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onPressed: () => saveEvent()),
    );
  }

  Future saveEvent() async {
    setState(() {
      _eventNameController.text.isEmpty
          ? _validate_eventName = true
          : _validate_eventName = false;
    });

    if (_validate_eventName == false) {
      EasyLoading.show(
        status: 'loading...',
      );

      Event eventObj = Event();
      eventObj.name = _eventNameController.text;
      eventObj.teamSize = _teamSizeValue;
      eventObj.date = selectedDateTime.toString();
      eventObj.startTime = _fromtime.toString().substring(10, 15);
      eventObj.endTime = _totime.toString().substring(10, 15);
      eventObj.locationName = _locationNameController.text;
      eventObj.teamCode = _team;
      eventObj.closeEvent = _closeEventBefore;

      String addedEventOutput = await Events().addEvent(eventObj);
      if (addedEventOutput == 'success') {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventPage()),
        ).then((value) {
          setState(() {});
        });
      } else {
        ShowDialogMessage.dialogShow(
          context,
          addedEventOutput,
          "Message",
        );
      }
    }

    /* Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventPage()),
            );*/
  }

  @override
  Widget TestWidget(BuildContext context) {
    return FutureBuilder(
        future: getTeams(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          return DropdownButton(
            dropdownColor: Colors.green[50],
            // elevation: 8,
            isExpanded: true,
            value: _team,
            items: snapshot.data,
            onChanged: (value) {
              setState(() {
                print(value);
                _team = value;
              });
            },
          );
        });
  }
}
