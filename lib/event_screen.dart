import 'package:applicationx/addevent_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class EventPage extends StatefulWidget {
  Widget build(BuildContext context) {}

  /// Creates the home page to display teh calendar widget.
  const EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Meeting> meetings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Events List'), backgroundColor: Colors.green),
      body: SfCalendar(
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
            numberOfWeeksInView: 5),
        dataSource: MeetingDataSource(_getDataSource()),
        onTap: calendarTapped,
        onLongPress: null, //delete event
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        // monthViewSettings: MonthViewSettings(
        //  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddeventPage()),
            );
          }),
    );
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Meeting(Icons.ac_unit_sharp, 'New Event', startTime, endTime,
        const Color(0xFF4CAF50), false));
    meetings.add(Meeting(Icons.ac_unit_sharp, 'New Event', startTime, endTime,
        const Color(0xFFE91E63), false));
    meetings.add(Meeting(Icons.ac_unit_sharp, 'New Event', startTime, endTime,
        const Color(0xFF9C27B0), false));
    meetings.add(Meeting(Icons.ac_unit_sharp, 'New Event', startTime, endTime,
        const Color(0xFFE91111), false));
    return meetings;
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      print("appoitment");
    } else if (calendarTapDetails.targetElement ==
        CalendarElement.calendarCell) {
      print("cell");
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
