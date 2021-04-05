import 'package:applicationx/backend/events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../beans/event.dart';
import 'package:flutter/material.dart';

class Events {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> addEvent(Event event) async {
    String addEventResult = "";
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    var userUID = _firebaseAuth.currentUser.uid;

    try {
      await events
          .add({
            'event_name': event.name,
            'event_team_size': event.teamSize,
            'event_date': event.date,
            'event_start_time': event.startTime,
            'event_end_time': event.endTime,
            'event_location_name': event.locationName,
            'event_team_code': event.teamCode,
            'event_close_before': event.closeEvent
          })
          .catchError((error) => addEventResult = "$error")
          .whenComplete(() => addEventResult = "success");
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      addEventResult = e.toString();
    }
    return addEventResult;
  }

  Future<List<Event>> getEvents() async {
    var userUID = _firebaseAuth.currentUser.uid;
    List<Event> events = [];
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection("events")
        //.where("user", isEqualTo: userUID)
        //.where("group_members", arrayContains: userUID)
        .get();

    querySnap.docs.forEach((doc) {
      Event event = Event.fillCalendar(
        name: doc["event_name"],
        date: doc["event_date"],
        startTime: doc["event_start_time"],
        endTime: doc["event_end_time"],
      );

      events.add(event);
    });
    return events;
  }
}
