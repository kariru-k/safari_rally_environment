import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../screens/home_screen.dart';

class ServiceParkForm extends StatefulWidget {
  const ServiceParkForm({Key? key}) : super(key: key);

  @override
  State<ServiceParkForm> createState() => _ServiceParkFormState();
}

class _ServiceParkFormState extends State<ServiceParkForm> {
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
      PolarQuestion(
        question: "Were there adequate litter bags and trash bins in the area?",
        answers: ["Yes", "No"],
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
      PolarQuestion(
        question: "Was the service park regularly cleaned and litter collected during the event?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      NestedQuestion(
        question: "Were Oil Drums available to all the crew for oil rags and oily parts?",
        answers: ["Yes", "No"],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "Were the oil drums conveniently located and signs posted to show where they are?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were the oil drums placed on hard impermeable surfaces(Not on the ground)",
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
              question: "Were the waste bins easily accessible and easy to find?",
              answers: ["Yes", "No"],
              isMandatory: true,
        ),
            PolarQuestion(
              question: "Were the waste bins easily segregated into plastic, metal and general waste bins?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),

    ],
      },
    ),
      PolarQuestion(
        question: "Was solid waste collected and disposed of at regular occasions i.e. litter on floor and Bins being emptied?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Was hazardous waste collected and disposed of at regular occasions i.e. oily rugs and used spill kits?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Were the rally crews using environmentally friendly mats and oil spill kits in the service park?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Was there adequate fire fighting personnel and equipment in the area?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      NestedQuestion(
        question: "Was there any approved outside catering in the area? (VIP)",
        answers: ["Yes", "No"],
        isMandatory: true,
        children: {
          "Yes": [
            PolarQuestion(
              question: "Were the catering crew properly sanitized and had trash bags and litter bins?",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
            PolarQuestion(
              question: "Were the catering crew fully compliant with the food hygiene protocols",
              answers: ["Yes", "No"],
              isMandatory: true,
            ),
          ],
        },
      ),

    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Park Review Form'),
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
              FirebaseFirestore.instance.collection('serviceparkreports').add(
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
