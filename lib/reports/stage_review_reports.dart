
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/locations.dart';


class ReportStagePage extends StatelessWidget {
  const ReportStagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Safari Rally 2022 Stage Maps'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index)
            {
              Locations location = locations[index];
              return Card(
                child: ListTile(
                  title: Text(location.title.toString()),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => StageReviewReports(location))
                    );
                  },
                ),
              );
            }
        )
    );
  }
}


class StageReviewReports extends StatelessWidget {
  final Locations location;
  const StageReviewReports(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title.toString()),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stagereports').where("What is the name of the stage?", isEqualTo: location.title).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((document) {

              dynamic _checkifExists(name){
                if (document.data().toString().contains(name)) {
                  return ListTile(
                      title: Text("$name: ${document.get(name)}",)
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }


              return Card(
                child: SizedBox(
                    child: Column(
                      children: [
                        _checkifExists("What is the name of the stage?"),
                        _checkifExists("How is the current terrain of the ground?"),
                        _checkifExists("How was the weather during the stage?"),
                        _checkifExists("Were posters and banners clearly depicting each zones deployed?"),
                        _checkifExists("Were the posters and banners removed after the event within the required time frame?"),
                        _checkifExists("Was there a spectator zone in the stage?"),
                        _checkifExists("What was the surface of the spectator zone parking?"),
                        _checkifExists("Was there adequate security for spectators in the spectator zone?"),
                        _checkifExists("What type of Spectator Zone was it?"),
                        _checkifExists("Were there adequate signage and posters to guide spectators in the zone?"),
                        _checkifExists("Were there adequate litter bags and trash bins in the area?"),
                        _checkifExists("Was the spectator area regularly cleaned and litter collected during the event?"),
                        _checkifExists("Were there adequate and sufficient toilets in the area?"),
                        _checkifExists("Were the toilets evenly distributed between male and female?"),
                        _checkifExists("Was there a toiled specific for the disabled?"),
                        _checkifExists("Were the toilets cleaned regularly?"),
                        _checkifExists("Were there food vendors in the area?"),
                        _checkifExists("Were the food vendors fully compliant with the food hygiene protocols"),
                        _checkifExists("Were the food vendors properly sanitized and had trash bags and litter bins?"),
                        _checkifExists("Was there any approved outside catering in the area? (VIP)"),
                        _checkifExists("Were the approved caterers properly sanitized and had trash bags and litter bins?"),
                        _checkifExists("Were the approved caterers fully compliant with the food hygiene protocols"),

                      ],
                    )
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

