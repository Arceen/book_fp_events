import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/event_detail.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];
  Future<List<EventDetail>> getDetailsList() async => (await db
          .collection('event_details')
          .get())
      .docs
      .map((event) => EventDetail.fromMap({'id': event.id, ...event.data()}))
      .toList();

  void initializeEventsList() async {
    details = await getDetailsList();
    setState(() {
      details = details;
    });
  }

  @override
  void initState() {
    initializeEventsList();
    super.initState();
  }

  void updateEventFavorite(EventDetail event, i) async {
    setState(() {
      details[i] = event;
    });
    var x = db.doc("event_details/${event.id}");
    await x.set(event.toMap());
    print((await x.get()).data());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: ((context, i) {
        return ListTile(
          title: Text(details[i].description),
          subtitle: Text(
              'Date: ${details[i].date}  Duration: ${details[i].startTime} - ${details[i].endTime}'),
          trailing: IconButton(
            onPressed: () {
              details[i].isFavorite =
                  details[i].isFavorite == "true" ? "false" : "true";
              updateEventFavorite(details[i], i);
            },
            icon: Icon(
              details[i].isFavorite == "true"
                  ? Icons.star
                  : Icons.star_border_outlined,
              color: details[i].isFavorite == "true" ? Colors.blue : Colors.red,
            ),
          ),
        );
      }),
    );
  }
}
