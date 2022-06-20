// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../screens/home_screen.dart';

class RefuellingForm extends StatefulWidget {
  const RefuellingForm({Key? key}) : super(key: key);

  @override
  State<RefuellingForm> createState() => _RefuellingFormState();
}

class _RefuellingFormState extends State<RefuellingForm> {
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
    'Submitted By': '${loggedInUser.firstName}, ${loggedInUser.secondName}'
  };

  List<Question> questions() {
    return [
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
              question: "Were they removed after the event within the required time frame?",
              answers: ["Yes", "No"],
            )
          ],
        },
      ),
      NestedQuestion(
        question: "Were Oil Drums available to all the crew for oil rags and oily parts?",
        answers: ["Yes", "No"],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "Were they conveniently located and signs were placed to show their presence?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were they placed on hard impermeable surfaces(Not on the grassy ground)",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
          ],
        },
      ),
      NestedQuestion(
        question: "Were there waste disposal bins in the paddock area and service park?",
        answers: ["Yes", "No"],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "Were they easily accessible and easy to find?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were they easily segregated into plastic, metal and general waste bins?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),

          ],
        },
      ),
      PolarQuestion(
        question: "Were the refuel crews using environmentally friendly mats and oil spill kits in the refuel station?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Were there adequate and sufficient toilets in the area?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Were the toilets cleaned regularly?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Was hazardous waste collected and disposed of at regular occasions i.e. oily rugs and used spill kits?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Was protective gear used in the refuel station?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Was there adequate fire fighting personnel and equipment in the area?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),


    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refuel Station Review Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ConditionalQuestions(
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
                FirebaseFirestore.instance.collection('refuelstationreports').add(
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
      ),
    );
  }
}
