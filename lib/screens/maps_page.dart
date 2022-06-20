import 'package:flutter/material.dart';
import 'package:safari_rally/models/locations.dart';
import 'package:safari_rally/screens/map_details_screen.dart';


class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

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
                      builder: (context) => MapDetailsScreen(location))
                  );
                },
              ),
            );
          }
      ),
    );
  }
}
