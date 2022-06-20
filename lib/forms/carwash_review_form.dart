

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../screens/home_screen.dart';

class CarWashForm extends StatefulWidget {
  const CarWashForm({Key? key}) : super(key: key);

  @override
  State<CarWashForm> createState() => _CarWashFormState();
}

class _CarWashFormState extends State<CarWashForm> {

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

  // ignore: prefer_typing_uninitialized_variables
  late final newMap;

  late Map<String, dynamic> map = {
    'Timestamp': DateTime.now(),
    'Submitted By': '${loggedInUser.firstName}, ${loggedInUser.secondName}'
  };

  List<Question> questions() {
    return [
      PolarQuestion(
        question: "Did the carwash employ the use of environmentally friendly mats?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
      PolarQuestion(
        question: "Did the carwash ensure the drainage was channeled properly and that it was not affecting the environment?",
        answers: ["Yes", "No"],
        isMandatory: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Wash Review Form'),
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
                FirebaseFirestore.instance.collection('carwashreports').add(
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

