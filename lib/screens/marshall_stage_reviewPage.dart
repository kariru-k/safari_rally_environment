
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../forms/carwash_review_form.dart';
import '../forms/refuelling_review_form.dart';
import '../forms/service_park_review_form.dart';
import '../forms/stage_review_form.dart';
import '../models/user_model.dart';


class MarshallStageReviewPage extends StatefulWidget {
  const MarshallStageReviewPage({Key? key}) : super(key: key);

  @override
  State<MarshallStageReviewPage> createState() => _MarshallStageReviewPageState();
}

class _MarshallStageReviewPageState extends State<MarshallStageReviewPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      //ListView to display the list of reports
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: const Text('Stage Review Form'),
                subtitle: const Text('Fill out this form to review a rally stage'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StageReviewForm(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Service Park Review Form'),
                subtitle: const Text('Fill out this form to review the service park'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceParkForm(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Refuelling Review Form'),
                subtitle: const Text('Fill out this form to review the refuelling stations'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RefuellingForm(),
                  ));
                }
            ),
          ),
          Card(
            child: ListTile(
                title: const Text('Car Wash Review Form'),
                subtitle: const Text('Fill out this form to review the car wash'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CarWashForm(),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}
