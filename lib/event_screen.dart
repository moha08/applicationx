import 'package:applicationx/addevent_screen.dart';
import 'package:applicationx/viewevent_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'beans/event.dart';
import 'backend/events.dart';

/// The hove page which hosts the calendar
class EventPage extends StatefulWidget {
  Widget build(BuildContext context) {}

  /// Creates the home page to display teh calendar widget.
  const EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events_list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('EVENTS LIST'), backgroundColor: Colors.green),
      body: getData(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddeventPage()),
            );
          }),
    );
  }

  Future<List<Meeting>> _getDataSource() async {
    List<Event> events_list = await Events().getEvents();

    List<Meeting> finalList = [];
    for (Event event in events_list) {
      String todayStr = event.date;
      String startTimeStr = event.startTime;
      String endTimeStr = event.endTime;
      DateTime todayDate = DateTime.parse(todayStr);
      DateTime startTime = todayDate
          .add(new Duration(hours: int.parse(startTimeStr.substring(0, 2))));
      DateTime endTime = todayDate
          .add(new Duration(hours: int.parse(endTimeStr.substring(0, 2))));
      finalList.add(Meeting(Icons.ac_unit_sharp, event.name, startTime, endTime,
          const Color(0xFF4CAF50), false));
    }

    return finalList;
  }

  Widget getData() {
    return FutureBuilder<List<Meeting>>(
        future: _getDataSource(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget

            print(snapshot.data.toString());
          }
          if (snapshot.hasError) {
            // return: show error widget
          }

          return SfCalendar(
            view: CalendarView.month,
            allowViewNavigation: true,
            todayHighlightColor: Colors.pink,
            cellBorderColor: Colors.green,
            showNavigationArrow: true,
            monthViewSettings: MonthViewSettings(
                showAgenda: true,
                appointmentDisplayCount: 4,
                showTrailingAndLeadingDates: true,
                agendaViewHeight: 400,
                agendaItemHeight: 75,
                numberOfWeeksInView: 4),
            dataSource: MeetingDataSource(snapshot.data),
            onTap: calendarTapped,
            onLongPress: null, //delete event
            // by default the month appointment display mode set as Indicator, we can
            // change the display mode as appointment using the appointment display
            // mode property
            // monthViewSettings: MonthViewSettings(
            //  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          );
        });
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Meeting app = calendarTapDetails.appointments[0];

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VieweventPage(app.eventName)),
      );
    } else if (calendarTapDetails.targetElement ==
        CalendarElement.calendarCell) {
      print("cll");
    }
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.testIcon, this.eventName, this.from, this.to, this.background,
      this.isAllDay);

  IconData testIcon;

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
