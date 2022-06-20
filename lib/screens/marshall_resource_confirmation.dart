import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safari_rally/screens/home_screen.dart';
import '../models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MarshallResourceConfirmationPage extends StatefulWidget {
  const MarshallResourceConfirmationPage({Key? key}) : super(key: key);

  @override
  State<MarshallResourceConfirmationPage> createState() => _MarshallResourceConfirmationPageState();
}

class _MarshallResourceConfirmationPageState extends State<MarshallResourceConfirmationPage> {
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

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Kasarani", child: Text("Kasarani")),
      const DropdownMenuItem(
          value: "Service Park",
          child: Text("Service Park")),
      const DropdownMenuItem(value: "Shakedown", child: Text("Shakedown")),
      const DropdownMenuItem(value: "Loldia", child: Text("Loldia")),
      const DropdownMenuItem(value: "Kedong", child: Text("Kedong")),
      const DropdownMenuItem(value: "Geothermal", child: Text("Geothermal")),
      const DropdownMenuItem(value: "Soysambu", child: Text("Soysambu")),
      const DropdownMenuItem(value: "Elementaita", child: Text("Elementaita")),
      const DropdownMenuItem(
          value: "Sleeping Warrior",
          child: Text("Sleeping Warrior")),
      const DropdownMenuItem(value: "Oserian", child: Text("Oserian")),
      const DropdownMenuItem(value: "Narasha", child: Text("Narasha")),
      const DropdownMenuItem(value: "Hell's Gate", child: Text("Hell's Gate")),
    ];
    return menuItems;
  }

  //List of dropdown menu items with only yes and no
  List<DropdownMenuItem<String>> get yesNoItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Yes", child: Text("Yes")),
      const DropdownMenuItem(value: "No", child: Text("No")),
    ];
    return menuItems;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _stage;
  late int? _vipToilets;
  late int? _regularToilets;
  late int? _disabledToilets;
  String? _trashbags;


  Widget _buildStageDropdown() {
    return DropdownButtonFormField(
      value: _stage,
      validator: (value) {
        if (value == null) {
          return 'Please select a stage';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.location_on),
        labelText: "Stage",
      ),
      items: dropDownItems,
      onChanged: (String? value) {
        setState(() {
          _stage = value;
        });
      },
    );
  }

  Widget _buildVipToiletsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Number of VIP Toilets present (if any)',
        prefixIcon: Icon(Icons.spa_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of VIP toilets';
        }
        //Check if the number is a number
        if (int.tryParse(value) == null) {
          return 'Please enter a number. No strings allowed';
        }
        return null;
      },
      onSaved: (String? value) {
        _vipToilets = int.parse(value!);
      },
    );
  }

  Widget _buildRegularToiletsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Number of Regular Toilets present',
        prefixIcon: Icon(Icons.wc_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of Regular toilets';
        }
        //Check if the number is a number
        if (int.tryParse(value) == null) {
          return 'Please enter a number. No strings allowed';
        }
        return null;
      },
      onSaved: (String? value) {
        _regularToilets = int.parse(value!);
      },
    );
  }

  Widget _buildDisabledToiletsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Number of Disabled Toilets present(if any)',
        prefixIcon: Icon(Icons.accessible_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of Disabled toilets';
        }
        //Check if the number is a number
        if (int.tryParse(value) == null) {
          return 'Please enter a number. No strings allowed';
        }
        return null;
      },
      onSaved: (String? value) {
        _disabledToilets = int.parse(value!);
      },
    );
  }

  Widget _buildTrashbagsField() {
    return DropdownButtonFormField(
      value: _trashbags,
      validator: (value) {
        if (value == null) {
          return 'Please select a value';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.local_shipping),
        labelText: "Are there adequate and sufficient trash bins?",
      ),
      items: yesNoItems,
      onChanged: (String? value) {
        setState(() {
          _trashbags = value;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: const Text('Submit'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          FirebaseFirestore.instance.collection('marshallconfirmation').add({
            'Stage': _stage,
            'Number of VIP Toilets Present': _vipToilets,
            'Number of Regular Toilets Present': _regularToilets,
            'Number of Disabled Toilets Present': _disabledToilets,
            'Presence of Trashbags': _trashbags,
            'timestamp': DateTime.now(),
            'submitted by': '${loggedInUser.firstName} ${loggedInUser
                .secondName}',
          });

          Fluttertoast.showToast(msg: "Data submitted successfully");

          Navigator.pushAndRemoveUntil(
              (context),
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marshall Resources Confirmation Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 90,
                  child: Image.asset('assets/images/2022-Badge.png'),
                ),
                const SizedBox(
                  height: 20,
                  child: Text(
                    'Resource Confirmation Form',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStageDropdown(),
                const SizedBox(height: 20),
                _buildVipToiletsField(),
                const SizedBox(height: 20),
                _buildRegularToiletsField(),
                const SizedBox(height: 20),
                _buildDisabledToiletsField(),
                const SizedBox(height: 20),
                _buildTrashbagsField(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          )
      )
    );
  }
}