class Event {
  String name;
  int teamSize;
  String date;
  String startTime;
  String endTime;
  int recurrence;
  List days;
  String locationName;
  String teamCode;
  double closeEvent;

  Event(
      {this.name,
      this.teamSize,
      this.date,
      this.startTime,
      this.endTime,
      this.locationName,
      this.teamCode,
      this.closeEvent});

  Event.fillCalendar({
    this.name,
    this.date,
    this.startTime,
    this.endTime,
  });
}
