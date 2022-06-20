import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/user_model.dart';
import 'home_screen.dart';

class DeploymentConfirmationPage extends StatefulWidget {
  const DeploymentConfirmationPage({Key? key}) : super(key: key);

  @override
  State<DeploymentConfirmationPage> createState() => _DeploymentConfirmationPageState();
}

class _DeploymentConfirmationPageState extends State<DeploymentConfirmationPage> {
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

  List<DropdownMenuItem<String>> get dropDownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Kasarani", child: Text("Kasarani")),
      const DropdownMenuItem(value: "Service Park", child: Text("Service Park")),
      const DropdownMenuItem(value: "Shakedown", child: Text("Shakedown")),
      const DropdownMenuItem(value: "Loldia", child: Text("Loldia")),
      const DropdownMenuItem(value: "Kedong", child: Text("Kedong")),
      const DropdownMenuItem(value: "Geothermal", child: Text("Geothermal")),
      const DropdownMenuItem(value: "Soysambu", child: Text("Soysambu")),
      const DropdownMenuItem(value: "Elementaita", child: Text("Elementaita")),
      const DropdownMenuItem(value: "Sleeping Warrior", child: Text("Sleeping Warrior")),
      const DropdownMenuItem(value: "Oserian", child: Text("Oserian")),
      const DropdownMenuItem(value: "Narasha", child: Text("Narasha")),
      const DropdownMenuItem(value: "Hell's Gate", child: Text("Hell's Gate")),
    ];
    return menuItems;
  }

  String? _stage;
  late int? _vipToilets;
  late int? _regularToilets;
  late int? _disabledToilets;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _checkExpectedvipToilets(stage, toiletnumber) {
    if (stage == "Kasarani" || stage == "Shakedown" || stage == "Kedong"){
      if (toiletnumber < 1){
        return "VIP Toilets are lower than expected for this stage";
      }
      else{
        return "Expected VIP Toilets: 1";
      }
    } else if (stage == "Soysambu" || stage == "Hell's Gate"){
      if (toiletnumber < 2){
        return "VIP Toilets are lower than expected for this stage";
      }
      else{
        return "Expected VIP Toilets: 2";
      }
    } else if (stage == "Service Park"){
      if (toiletnumber < 4){
        return "VIP Toilets are lower than expected for this stage";
      }
      else{
        return "Expected VIP Toilets: 4";
      }
    } else {
      return "No VIP Toilets expected for this stage";
    }
  }

  _checkRegularToilets(stage, toiletnumber) {
    if (stage == "Kasarani" || stage == "Kedong" || stage == "Soysambu" || stage == "Elementaita" || stage == "Sleeping Warrior"){
      if(toiletnumber <10){
        return "Regular Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Regular Toilets: 10";
      }
    } else if (stage == "Shakedown" || stage == "Geothermal" || stage == "Narasha"){
      if(toiletnumber <6){
        return "Regular Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Regular Toilets: 6";
      }
    } else if (stage == "Loldia" || stage == "Oserian"){
      if(toiletnumber <4){
        return "Regular Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Regular Toilets: 4";
      }
    } else if (stage == "Hell's Gate" || stage == "Service Park"){
      if(toiletnumber <14){
        return "Regular Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Regular Toilets: 14";
      }
    } else {
      return "No Regular Toilets expected for this stage";
    }

  }

  _checkDisabledToilets(stage, toiletnumber) {
    if (stage == "Service Park"){
      if(toiletnumber <2){
        return "Disabled Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Disabled Toilets: 2";
      }
    } else if (stage == "Soysambu"){
      if(toiletnumber <1){
        return "Disabled Toilets are lower than expected for this stage";
      }
      else{
        return "Expected Disabled Toilets: 1";
      }
    } else if (stage == "Kasarani" || stage == "Shakedown" || stage == "Kedong" || stage == "Loldia" || stage == "Oserian" || stage == "Elementaita" || stage == "Sleeping Warrior" || stage == "Narasha" || stage == "Hell's Gate" || stage == "Geothermal"){
      return "No Disabled Toilets expected for this stage";
    }
  }

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
        labelText: 'VIP Toilets',
        prefixIcon: Icon(Icons.spa_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of VIP toilets';
        }
        // check if the value is an integer
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (value) {
        _vipToilets = int.parse(value!);
      },
    );
  }

  Widget _buildRegularToiletsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Regular Toilets',
        prefixIcon: Icon(Icons.wc_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of Regular toilets';
        }
        // check if the value is an integer
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (value) {
        _regularToilets = int.parse(value!);
      },
    );
  }

  Widget _buildDisabledToiletsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Disabled Toilets',
        prefixIcon: Icon(Icons.accessible_sharp),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of Disabled toilets';
        }
        // check if the value is an integer
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (value) {
        _disabledToilets = int.parse(value!);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: const Text('Submit'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          FirebaseFirestore.instance
              .collection("supplierdeployment")
              .add({
            "Stage": _stage,
            "Number of Vip Toilets": _vipToilets,
            "VIP Toilet Feedback": _checkExpectedvipToilets(_stage, _vipToilets),
            "Number of Regular Toilets": _regularToilets,
            "Regular Toilet Feedback": _checkRegularToilets(_stage, _regularToilets),
            "Number of Disabled Toilets": _disabledToilets,
            "Disabled Toilet Feedback": _checkDisabledToilets(_stage, _disabledToilets),
            "timestamp": DateTime.now(),
            "submitted by": '${loggedInUser.firstName} ${loggedInUser.secondName}',
          });

          Fluttertoast.showToast(msg: "Data submitted successfully");

          Navigator.pushAndRemoveUntil(
              (context),
              MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                  (route) => false);
        }});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deployment Form(Suppliers)'),
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
                height: 50,
                child: Text(
                  'Supplier Deployment Form',
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
              _buildSubmitButton(),
            ],
          ),
        )
      ),
    );
  }
}

