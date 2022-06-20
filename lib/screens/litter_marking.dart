import 'package:flutter/material.dart';

import '../models/locations.dart';
import 'map_details_screen.dart';

class LitterMapsPage extends StatelessWidget {
  const LitterMapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Litter Marking Page'),
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
                            builder: (context) => LitterMapDetailsScreen(location))
                    );
                  },
                ),
              );
            }
        )
    );
  }
}
