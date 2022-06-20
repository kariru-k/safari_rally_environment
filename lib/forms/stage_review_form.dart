import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../screens/home_screen.dart';

class StageReviewForm extends StatefulWidget {
  const StageReviewForm({Key? key}) : super(key: key);



  @override
  State<StageReviewForm> createState() => _StageReviewFormState();
}

class _StageReviewFormState extends State<StageReviewForm> {
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

  final _key = GlobalKey<QuestionFormState>();

  late final newMap;

  late Map<String, dynamic> map = {
    'Timestamp': DateTime.now(),
    'Submitted By': '${loggedInUser.firstName} ${loggedInUser.secondName}'
  };


  List<Question> questions() {
    return [
      PolarQuestion(
        question: "What is the name of the stage?",
        answers: ["Kasarani", "Shakedown", "Loldia", "Kedong", "Geothermal", "Soysambu", "Elementaita", "Sleeping Warrior", "Oserian", "Narasha", "Hell's Gate"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "How is the current terrain of the ground?",
        answers: ["Muddy", "Dusty",],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "How was the weather during the stage?",
        answers: ["Sunny", "Rainy", "Cloudy"],
        isMandatory: true,
      ),
      NestedQuestion(
        question: "Were posters and banners clearly depicting each zones deployed?",
        answers: [
          "Yes",
          "No",
        ],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "Were the posters and banners removed after the event within the required time frame?",
              answers: ["Yes", "No"],
            )
          ],
        },
      ),
      NestedQuestion(
        question: "Was there a spectator zone in the stage?",
        answers: [
          "Yes",
          "No",
        ],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "What was the surface of the spectator zone parking?",
              answers: ["Grass", "Dirt", "Concrete", "Other"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Was there adequate security for spectators in the spectator zone?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "What type of Spectator Zone was it?",
              answers: ["Regular", "VIP"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were there adequate signage and posters to guide spectators in the zone?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were there adequate litter bags and trash bins in the area?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Was the spectator area regularly cleaned and litter collected during the event?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were there adequate and sufficient toilets in the area?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were the toilets evenly distributed between male and female?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Was there a toiled specific for the disabled?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were the toilets cleaned regularly?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            NestedQuestion(
              question: "Were there food vendors in the area?",
              answers: ["Yes", "No"],
              isMandatory: true,
              children: {
                "Yes": [
                  PolarQuestion(
                    question: "Were the food vendors fully compliant with the food hygiene protocols",
                    answers: ["Yes", "No"],
                    isMandatory: true,
                  ),
                  PolarQuestion(
                    question: "Were the food vendors properly sanitized and had trash bags and litter bins?",
                    answers: ["Yes", "No"],
                    isMandatory: true,
                  ),
                ],

              },
            ),
            NestedQuestion(
              question: "Was there any approved outside catering in the area? (VIP)",
              answers: ["Yes", "No"],
              isMandatory: true,
              children: {
                "Yes": [
                  PolarQuestion(
                    question: "Were the approved caterers properly sanitized and had trash bags and litter bins?",
                    answers: ["Yes", "No"],
                    isMandatory: true,
                  ),
                  PolarQuestion(
                    question: "Were the approved caterers fully compliant with the food hygiene protocols",
                    answers: ["Yes", "No"],
                    isMandatory: true,
                  ),
                ],
              },
            )
          ],
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stage Review Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:  ConditionalQuestions(
              key: _key,
              children: questions(),
              trailing: [
                MaterialButton(
                  color: Colors.blue,
                  splashColor: Colors.black,

                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      newMap = _key.currentState!.toMap();
                      map.addAll(newMap);
                      FirebaseFirestore.instance.collection('stagereports').add(
                        map
                      );
                      Fluttertoast.showToast(msg: "Form submitted successfully");

                      Navigator.pushAndRemoveUntil(
                          (context),
                          MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                              (route) => false);
                    }
                  },
                  child: const Text("Submit"),
                )
              ],
      )
            );
        }
  }
