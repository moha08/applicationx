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
  String teamName;
  double closeEvent;
  String fullDateTime;

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

  Event.getByName(
      {this.name,
      this.teamSize,
      this.teamName,
      this.fullDateTime,
      this.locationName});
}
