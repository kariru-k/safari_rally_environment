import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import 'home_screen.dart';



class NoisePage extends StatefulWidget {
  const NoisePage({Key? key}) : super(key: key);

  @override
  State<NoisePage> createState() => _NoisePageState();
}

class _NoisePageState extends State<NoisePage> {
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


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "RC1 Rally1", child: Text("RC1 Rally1")),
      const DropdownMenuItem(value: "RC2 Rally2", child: Text("RC2 Rally2")),
      const DropdownMenuItem(value: "RC3 Rally 3", child: Text("RC3 Rally 3")),
      const DropdownMenuItem(value: "NAT NR4", child: Text("NAT NR4")),
      const DropdownMenuItem(value: "NAT N4", child: Text("NAT N4")),
      const DropdownMenuItem(value: "NAT NR2", child: Text("NAT NR2")),
    ];
    return menuItems;
  }

  late int _carNumber;
  late String? _driverName;
  late String? _coDriverName;
  late String? _carMake;
  late String? _carModel;
  String? _rallyCategory;
  late double? _test1Value;
  late double? _test2Value;
  late double? _test3Value;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _checksoundtest1compliance(value){
    if(value > 108.0){
      return "Non-Compliant to the sound limit";
    }
    else{
      return "Compliant to the sound limit";
    }

  }

  _checksoundtest2compliance(value){
    if(value > 96.0){
      return "Non-Compliant to the sound limit";
    }
    else{
      return "Compliant to the sound limit";
    }

  }

  _checksoundtest3compliance(value){
    if(value > 84.0){
      return "Non-Compliant to the sound limit";
    }
    else{
      return "Compliant to the sound limit";
    }

  }

  Widget _buildCarNumberField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Number',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the rally car number';
        }
        //checks if value is an integer. If it isn't it sends an error message
        if (int.tryParse(value) == null) {
          return 'Please enter a valid car number';
        }
        return null;
      },
      onSaved: (value) => _carNumber = int.parse(value!),
    );
  }

  Widget _buildDriverNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Driver Name',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter the Driver's Name";
        }
        //checks if value is an integer. If it isn't it sends an error message
        return null;
      },
      onSaved: (value) {
        _driverName = value;
      },
    );
  }

  Widget _buildCoDriverNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Co-Driver Name',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Co-Driver\'s Name';
        }
        return null;
      },
      onSaved: (value) {
        _coDriverName = value;
      },
    );
  }

  Widget _buildCarMakeField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Make (i.e. Toyota, Hyundai, etc.)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Car Make';
        }
        return null;
      },
      onSaved: (value) {
        _carMake = value;
      },
    );
  }

  Widget _buildCarModelField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Model',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your car model';
        }
        return null;
      },
      onSaved: (value) {
        _carModel = value;
      },
    );
  }

  Widget _buildRallyCategoryField(){
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Rally Category',
        prefixIcon: Icon(Icons.directions_car),
      ),
      value: _rallyCategory,
      items: dropdownItems,
      validator: (value) {
        if (value == null) {
          return 'Please select a rally category';
        }
        return null;
      },
      onChanged: (String? value) {
        setState(() {
          _rallyCategory = value;
        });
      },
    );
  }

  Widget _buildTest1Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 1 (0.5m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 1';
        }
        //checks if value is a double. If it isn't it sends an error message
        if (double.tryParse(value) == null) {
          return 'Please enter a valid value for Sound Test 1. Remember to use a decimal point.';
        }
        return null;
      },
      onSaved: (value) {
        _test1Value = double.parse(value!);
      },
    );
  }

  Widget _buildTest2Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 2 (2m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 2';
        }
        //checks if value is a double. If it isn't it sends an error message
        if (double.tryParse(value) == null) {
          return 'Please enter a valid value for Sound Test 2. Remember to use a decimal point.';
        }
        return null;
      },
      onSaved: (value) {
        _test2Value = double.parse(value!);
      },
    );
  }

  Widget _buildTest3Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 3 (5m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 3';
        }
        //checks if value is a double. If it isn't it sends an error message
        if (double.tryParse(value) == null) {
          return 'Please enter a valid value for Sound Test 3. Remember to use a decimal point.';
        }
        return null;
      },
      onSaved: (value) {
        _test3Value = double.parse(value!);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: const Text('Submit'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          FirebaseFirestore.instance.collection('noisetestdata').add({
            'Car Number': _carNumber,
            'Driver Name': _driverName,
            'Co-Driver Name': _coDriverName,
            'Car Make': _carMake,
            'Car Model': _carModel,
            'Rally Category': _rallyCategory,
            'Sound Test 1': _test1Value,
            'Sound Test 1 Compliance': _checksoundtest1compliance(_test1Value),
            'Sound Test 2 (2m)': _test2Value,
            'Sound Test 2 Compliance': _checksoundtest2compliance(_test2Value),
            'Sound Test 3 (5m)': _test3Value,
            'Sound Test 3 Compliance': _checksoundtest3compliance(_test3Value),
            'timestamp': DateTime.now(),
            'submitted by': '${loggedInUser.firstName} ${loggedInUser.secondName}',
          });

          Fluttertoast.showToast(msg: "Data submitted successfully");

          Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) =>  const HomeScreen()),
          (route) => false);

        } else {
          Fluttertoast.showToast(msg: "Please check your values. They are not valid.");
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Test'),
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
                  'Noise Test Form',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildCarNumberField(),
              const SizedBox(height: 20),
              _buildDriverNameField(),
              const SizedBox(height: 20),
              _buildCoDriverNameField(),
              const SizedBox(height: 20),
              _buildCarMakeField(),
              const SizedBox(height: 20),
              _buildCarModelField(),
              const SizedBox(height: 20),
              _buildRallyCategoryField(),
              const SizedBox(height: 20),
              _buildTest1Field(),
              const SizedBox(height: 20),
              _buildTest2Field(),
              const SizedBox(height: 20),
              _buildTest3Field(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          )
        ),
      ),
    );
  }
}

