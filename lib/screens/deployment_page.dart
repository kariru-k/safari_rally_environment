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
      const DropdownMenuItem(child: Text("Kasarani"),value: "Kasarani"),
      const DropdownMenuItem(child: Text("Service Park"),value: "Service Park"),
      const DropdownMenuItem(child: Text("Shakedown"),value: "Shakedown"),
      const DropdownMenuItem(child: Text("Loldia"),value: "Loldia"),
      const DropdownMenuItem(child: Text("Kedong"),value: "Kedong"),
      const DropdownMenuItem(child: Text("Geothermal"),value: "Geothermal"),
      const DropdownMenuItem(child: Text("Soysambu"),value: "Soysambu"),
      const DropdownMenuItem(child: Text("Elementaita"),value: "Elementaita"),
      const DropdownMenuItem(child: Text("Sleeping Warrior"),value: "Sleeping Warrior"),
      const DropdownMenuItem(child: Text("Oserian"),value: "Oserian"),
      const DropdownMenuItem(child: Text("Narasha"),value: "Narasha"),
      const DropdownMenuItem(child: Text("Hell's Gate"),value: "Hell's Gate"),
    ];
    return menuItems;
  }

  String? _stage;
  late String? _vipToilets;
  late String? _regularToilets;
  late String? _disabledToilets;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        return null;
      },
      onSaved: (value) {
        _vipToilets = value;
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
        return null;
      },
      onSaved: (value) {
        _regularToilets = value;
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
        return null;
      },
      onSaved: (value) {
        _disabledToilets = value;
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
            "stage": _stage,
            "vipToilets": _vipToilets,
            "regularToilets": _regularToilets,
            "disabledToilets": _disabledToilets,
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

